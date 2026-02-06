---
name: fal-generate
description: Generate AI images, videos, audio and 3D content using fal.ai's 500+ models. Supports Kling V3, FLUX.2, Grok Imagine, Veo 3.1, MiniMax, Hunyuan 3D and more via queue-based generation.
---

# fal-generate Skill

## Overview

This skill enables AI content generation through fal.ai's latest models using a queue-based system. It supports:

- **Text-to-Image** - Generate images from text prompts
- **Image-to-Image** - Edit and transform existing images
- **Text-to-Video** - Create videos from text descriptions
- **Image-to-Video** - Animate images into videos
- **Text-to-Speech** - Generate natural speech from text
- **Speech-to-Text** - Transcribe audio to text
- **Text-to-3D** - Create 3D models from text
- **Image-to-3D** - Convert images to 3D models

## Scripts

| Script | Purpose |
|--------|---------|
| `scripts/generate.sh` | Main generation tool with queue management |
| `scripts/upload.sh` | Upload files to fal CDN |
| `scripts/poll.sh` | Poll queue status until completion |
| `scripts/models.sh` | Search and discover models |

## Quick Start

### Prerequisites

```bash
# Ensure FAL_KEY is set
export FAL_KEY="your-api-key"

# Or source from .test_env
source .test_env
```

### Generate an Image

```bash
./scripts/generate.sh --model fal-ai/kling-image/v3/text-to-image \
  --prompt "A majestic mountain at sunrise"
```

### Generate a Video

```bash
./scripts/generate.sh --model fal-ai/kling-video/v3/pro/text-to-video \
  --prompt "A butterfly emerging from a cocoon" \
  --duration 5
```

### Generate Speech

```bash
./scripts/generate.sh --model fal-ai/minimax/speech-2.8-hd \
  --text "Hello, welcome to fal.ai!"
```

## Featured Models (February 2026)

### Image Generation

| Model | Endpoint | Best For |
|-------|----------|----------|
| **Kling V3** | `fal-ai/kling-image/v3/text-to-image` | High-quality general images |
| **Kling Omni 3** | `fal-ai/kling-image/o3/text-to-image` | Flawless consistency |
| **Grok Imagine** | `xai/grok-imagine-image` | Highly aesthetic images |
| **FLUX.2 Klein 9B** | `fal-ai/flux-2/klein/9b` | Photorealism & text |
| **Qwen Image Max** | `fal-ai/qwen-image-max/text-to-image` | Natural textures |
| **Hunyuan 3.0 Instruct** | `fal-ai/hunyuan-image/v3/instruct/text-to-image` | Complex prompts |

### Video Generation

| Model | Endpoint | Best For |
|-------|----------|----------|
| **Kling V3 Pro** | `fal-ai/kling-video/v3/pro/text-to-video` | Cinematic + audio |
| **Kling O3 Pro** | `fal-ai/kling-video/o3/pro/text-to-video` | Realistic motion |
| **Grok Imagine Video** | `xai/grok-imagine-video/text-to-video` | Video with audio |
| **Vidu Q3** | `fal-ai/vidu/q3/text-to-video` | Quality control |
| **LTX-2 19B** | `fal-ai/ltx-2-19b/text-to-video` | Video with LoRA |

### Audio

| Model | Endpoint | Best For |
|-------|----------|----------|
| **MiniMax 2.8 HD** | `fal-ai/minimax/speech-2.8-hd` | High-quality TTS |
| **Qwen-3 TTS** | `fal-ai/qwen-3-tts/text-to-speech/1.7b` | Custom voices |
| **Nemotron ASR** | `fal-ai/nemotron/asr` | Fast transcription |
| **ElevenLabs Scribe** | `fal-ai/elevenlabs/speech-to-text/scribe-v2` | Accurate STT |

### 3D Generation

| Model | Endpoint | Best For |
|-------|----------|----------|
| **Hunyuan 3D V3.1 Pro** | `fal-ai/hunyuan-3d/v3.1/pro/text-to-3d` | Detailed 3D |
| **Hunyuan 3D V3.1 Rapid** | `fal-ai/hunyuan-3d/v3.1/rapid/image-to-3d` | Fast conversion |
| **UltraShape** | `fal-ai/ultrashape` | High-fidelity geometry |
| **Trellis 2** | `fal-ai/trellis-2` | Versatile 3D assets |

## Usage Patterns

### 1. Queue Mode (Default)

Submit request, poll for completion:

```bash
./scripts/generate.sh --model fal-ai/flux-2/klein/9b \
  --prompt "Portrait of a scientist" \
  --wait
```

### 2. Async Mode

Get request ID immediately:

```bash
REQUEST_ID=$(./scripts/generate.sh --model fal-ai/kling-video/v3/pro/text-to-video \
  --prompt "Drone flying over a city" \
  --async)

# Check later
./scripts/poll.sh fal-ai/kling-video/v3/pro/text-to-video $REQUEST_ID
```

### 3. With File Upload

```bash
# Upload image first
IMAGE_URL=$(./scripts/upload.sh ~/photos/portrait.jpg)

# Use in generation
./scripts/generate.sh --model fal-ai/kling-video/o3/pro/image-to-video \
  --image-url "$IMAGE_URL" \
  --prompt "Gentle wind blowing through hair"
```

## Common Parameters

| Parameter | Description | Example |
|-----------|-------------|---------|
| `--prompt` | Text description | `"A sunset over mountains"` |
| `--image-url` | Input image URL | `"https://..."` |
| `--video-url` | Input video URL | `"https://..."` |
| `--audio-url` | Input audio URL | `"https://..."` |
| `--aspect-ratio` | Output ratio | `"16:9"`, `"9:16"`, `"1:1"` |
| `--duration` | Video length (sec) | `5`, `10` |
| `--seed` | Reproducibility | `12345` |
| `--wait` | Poll until done | (flag) |
| `--async` | Return ID only | (flag) |

## Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `FAL_KEY` | Yes | API authentication key |
| `FAL_WEBHOOK` | No | Webhook URL for callbacks |

## Error Handling

The scripts handle common errors:

- **401 Unauthorized** - Check FAL_KEY is set correctly
- **429 Rate Limited** - Wait and retry
- **400 Bad Request** - Check model parameters
- **FAILED status** - Request failed, check logs

## Tips

1. **Use queue for videos** - They take longer, queue prevents timeouts
2. **Check model schema** - Use `./scripts/models.sh --schema <endpoint>`
3. **Upload large files first** - Use `./scripts/upload.sh` for files > 1MB
4. **Set webhooks for long tasks** - Avoid polling for 3D generation
5. **Use seeds for reproducibility** - Same seed = same output
