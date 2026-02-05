# Skills fal.ai

> **Claude Code Skill for fal.ai - Generate AI Images, Videos, Audio & 3D**
>
> Based on the [fal-ai-community/skills](https://github.com/fal-ai-community/skills/tree/main/skills/claude.ai/fal-generate) project by [@ilker](https://github.com/ilker)

---

## GitHub Project Info

**Suggested Repository Name:** `skills-fal-ai`

**Title:** `Skills fal.ai - Claude Code Skill for AI Generation`

**Description:**
> Claude Code skill for generating AI images, videos, audio and 3D content using fal.ai's 500+ models. Supports Kling V3, FLUX.2, Veo 3.1, MiniMax, Hunyuan 3D and more.

**Topics/Tags:**
`claude-code` `fal-ai` `ai-generation` `text-to-image` `text-to-video` `text-to-speech` `3d-generation` `kling` `flux` `hunyuan` `skill`

---

## Features

- **500+ AI Models** - Latest image, video, audio, and 3D generation models
- **Queue-based System** - Reliable async processing with automatic polling
- **File Upload** - Built-in CDN upload for local files
- **Model Discovery** - Search and explore available models
- **Updated February 2026** - Kling V3, FLUX.2 Klein, Grok Imagine, Veo 3.1, and more

## Installation

### Option 1: Clone from GitHub
```bash
git clone https://github.com/YOUR_USERNAME/skills-fal-ai.git
cp -r skills-fal-ai/fal-generate ~/.claude/skills/
```

### Option 2: Direct Copy
```bash
# Copy the fal-generate folder to your Claude skills directory
cp -r fal-generate ~/.claude/skills/
```

## Prerequisites

```bash
# Set your fal.ai API key
export FAL_KEY="your-api-key"

# Install jq (required for JSON parsing)
brew install jq  # macOS
apt-get install jq  # Ubuntu/Debian
```

## Quick Start

```bash
cd ~/.claude/skills/fal-generate

# Generate an Image (Kling V3)
./scripts/generate.sh -m fal-ai/kling-image/v3/text-to-image \
  -p "A majestic castle at sunset, cinematic lighting" -w

# Generate a Video (Kling V3 Pro with audio)
./scripts/generate.sh -m fal-ai/kling-video/v3/pro/text-to-video \
  -p "A butterfly emerging from a cocoon in slow motion" --duration 5 -w

# Generate Speech (MiniMax)
./scripts/generate.sh -m fal-ai/minimax/speech-2.8-hd \
  -t "Hello! Welcome to fal.ai, the AI cloud platform." -w

# Generate 3D Model (Hunyuan 3D)
./scripts/generate.sh -m fal-ai/hunyuan-3d/v3.1/pro/text-to-3d \
  -p "A detailed medieval sword with ornate handle" -w

# Animate an Image (Kling O3)
./scripts/generate.sh -m fal-ai/kling-video/o3/pro/image-to-video \
  --image-url "https://example.com/portrait.jpg" \
  -p "Gentle wind blowing through hair, subtle smile" -w
```

## Directory Structure

```
fal-generate/
├── README.md           # This file
├── SKILL.md            # Detailed skill documentation
├── MODELS.md           # Complete model catalog (500+ models)
└── scripts/
    ├── generate.sh     # Main generation script
    ├── upload.sh       # File upload to fal CDN
    ├── poll.sh         # Queue status polling
    └── models.sh       # Model discovery & search
```

## Featured Models (February 2026)

### Image Generation (Top Picks)
| Model | Endpoint | Best For |
|-------|----------|----------|
| **Kling V3** | `fal-ai/kling-image/v3/text-to-image` | Best overall quality |
| **Kling Omni 3** | `fal-ai/kling-image/o3/text-to-image` | Perfect consistency |
| **Grok Imagine** | `xai/grok-imagine-image` | Highly aesthetic |
| **FLUX.2 Klein 9B** | `fal-ai/flux-2/klein/9b` | Photorealistic |
| **FLUX.2 Max** | `fal-ai/flux-2-max` | State-of-the-art |
| **Hunyuan 3.0 Instruct** | `fal-ai/hunyuan-image/v3/instruct/text-to-image` | Complex prompts |
| **Qwen Image Max** | `fal-ai/qwen-image-max/text-to-image` | Natural textures |
| **Z-Image Turbo** | `fal-ai/z-image/turbo` | Super fast (6B) |
| **Ideogram V3** | `fal-ai/ideogram/v3` | Typography |
| **Imagen 4** | `fal-ai/imagen4/preview` | Google's best |

### Video Generation (Top Picks)
| Model | Endpoint | Best For |
|-------|----------|----------|
| **Kling V3 Pro** | `fal-ai/kling-video/v3/pro/text-to-video` | Cinematic + audio |
| **Kling O3 Pro** | `fal-ai/kling-video/o3/pro/text-to-video` | Best realism |
| **Grok Imagine Video** | `xai/grok-imagine-video/text-to-video` | Video with audio |
| **Veo 3.1** | `fal-ai/veo3.1` | Google's best |
| **Vidu Q3** | `fal-ai/vidu/q3/text-to-video` | Quality control |
| **LTX-2 19B** | `fal-ai/ltx-2-19b/text-to-video` | LoRA support |
| **Seedance 1.5 Pro** | `fal-ai/bytedance/seedance/v1.5/pro/text-to-video` | ByteDance |
| **Hunyuan Video 1.5** | `fal-ai/hunyuan-video-v1.5/text-to-video` | Tencent's best |
| **Pixverse V5.6** | `fal-ai/pixverse/v5.6/text-to-video` | Effects & transitions |
| **Ray 2** | `fal-ai/luma-dream-machine/ray-2` | Luma's best |

### Audio (Top Picks)
| Model | Endpoint | Best For |
|-------|----------|----------|
| **MiniMax 2.8 HD** | `fal-ai/minimax/speech-2.8-hd` | Best TTS quality |
| **MiniMax 2.8 Turbo** | `fal-ai/minimax/speech-2.8-turbo` | Fast TTS |
| **Qwen-3 TTS** | `fal-ai/qwen-3-tts/text-to-speech/1.7b` | Custom voices |
| **Nemotron ASR** | `fal-ai/nemotron/asr` | Fast transcription |
| **ElevenLabs Scribe V2** | `fal-ai/elevenlabs/speech-to-text/scribe-v2` | Accurate STT |
| **ElevenLabs Music** | `fal-ai/elevenlabs/music` | Music generation |
| **Maya** | `fal-ai/maya` | Expressive voice |
| **SAM Audio** | `fal-ai/sam-audio/separate` | Audio separation |

### 3D Generation (Top Picks)
| Model | Endpoint | Best For |
|-------|----------|----------|
| **Hunyuan 3D V3.1 Pro** | `fal-ai/hunyuan-3d/v3.1/pro/text-to-3d` | Detailed 3D |
| **Hunyuan 3D V3.1 Rapid** | `fal-ai/hunyuan-3d/v3.1/rapid/image-to-3d` | Fast conversion |
| **UltraShape** | `fal-ai/ultrashape` | High-fidelity geometry |
| **Trellis 2** | `fal-ai/trellis-2` | Versatile assets |
| **Meshy V6** | `fal-ai/meshy/v6-preview/text-to-3d` | Production ready |
| **Hunyuan Motion** | `fal-ai/hunyuan-motion` | 3D animation |

## Scripts Reference

### generate.sh - Main Generation
```bash
./scripts/generate.sh --model <endpoint> [options]

Options:
  -m, --model       Model endpoint (required)
  -p, --prompt      Text prompt for generation
  -t, --text        Text for TTS models
  --image-url       Input image URL
  --video-url       Input video URL
  --audio-url       Input audio URL
  --aspect-ratio    16:9, 9:16, 1:1, 4:3, 3:4
  --duration        Video length in seconds
  --seed            Seed for reproducibility
  -w, --wait        Poll until completion
  -a, --async       Return request ID only
  --param           Extra param (key=value)
```

### upload.sh - File Upload
```bash
./scripts/upload.sh /path/to/file.jpg
# Returns: https://fal.ai/cdn/...
```

### poll.sh - Status Polling
```bash
./scripts/poll.sh <endpoint> <request_id> [--timeout 600]
```

### models.sh - Model Discovery
```bash
./scripts/models.sh --featured              # List featured models
./scripts/models.sh --search "video"        # Search by keyword
./scripts/models.sh --category text-to-image # Filter by category
./scripts/models.sh --schema <endpoint>     # Get API schema
./scripts/models.sh --pricing <endpoint>    # Get pricing
```

## Full Model Catalog

See **[MODELS.md](MODELS.md)** for the complete catalog of 500+ models organized by:
- Release date (February 2026 → December 2024)
- Category (Image, Video, Audio, 3D, Text)
- Use case recommendations

## Publishing to GitHub

```
skills-fal-ai/
├── README.md
├── LICENSE
└── fal-generate/
    ├── README.md
    ├── SKILL.md
    ├── MODELS.md
    └── scripts/
        ├── generate.sh
        ├── upload.sh
        ├── poll.sh
        └── models.sh
```

## Credits

- **Original Skill**: [fal-ai-community/skills](https://github.com/fal-ai-community/skills) by [@ilker](https://github.com/ilker)
- **fal.ai Platform**: https://fal.ai
- **fal.ai Documentation**: https://docs.fal.ai
- **Model Catalog**: Updated February 2026

## License

MIT License - See [LICENSE](LICENSE) file.

---

Made with fal.ai
