---
name: fal-generate
description: Generate AI images, videos, audio and 3D content using fal.ai's 500+ models. Supports Kling V3, FLUX.2, Grok Imagine, Veo 3.1, MiniMax, Hunyuan 3D, OpenRouter LLMs and more via queue-based generation.
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
- **LLM / VLM / ALM** - Run any LLM, vision, audio or video model via OpenRouter

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

---

## Complete Model Catalog

### Image Generation — February 2026

| Endpoint | Description |
|----------|-------------|
| `fal-ai/kling-image/v3/text-to-image` | Kling V3: Latest Kling image model |
| `fal-ai/kling-image/v3/image-to-image` | Kling V3 image transformation |
| `fal-ai/kling-image/o3/text-to-image` | Kling Omni 3: Top-tier with flawless consistency |
| `fal-ai/kling-image/o3/image-to-image` | Kling Omni 3 image editing |
| `xai/grok-imagine-image` | xAI Grok Imagine: Highly aesthetic images |
| `xai/grok-imagine-image/edit` | Grok Imagine precise editing |
| `fal-ai/hunyuan-image/v3/instruct/text-to-image` | Hunyuan 3.0 Instruct with reasoning |
| `fal-ai/hunyuan-image/v3/instruct/edit` | Hunyuan 3.0 instruction-based editing |
| `fal-ai/qwen-image-max/text-to-image` | Qwen Image Max: Enhanced realism |
| `fal-ai/qwen-image-max/edit` | Qwen Image Max editing |
| `fal-ai/z-image/base` | Z-Image Base: 6B fast model |
| `fal-ai/z-image/base/lora` | Z-Image Base with LoRA |

### Image Generation — January 2026

| Endpoint | Description |
|----------|-------------|
| `fal-ai/flux-2/klein/9b` | FLUX.2 Klein 9B: Enhanced realism & text |
| `fal-ai/flux-2/klein/9b/edit` | FLUX.2 Klein 9B editing with hex colors |
| `fal-ai/flux-2/klein/9b/base` | FLUX.2 Klein 9B Base foundation |
| `fal-ai/flux-2/klein/9b/base/lora` | FLUX.2 Klein 9B with LoRA |
| `fal-ai/flux-2/klein/4b` | FLUX.2 Klein 4B: Lightweight |
| `fal-ai/flux-2/klein/4b/edit` | FLUX.2 Klein 4B editing |
| `fal-ai/flux-2/klein/4b/base` | FLUX.2 Klein 4B Base |
| `fal-ai/flux-2/klein/4b/base/lora` | FLUX.2 Klein 4B with LoRA |
| `fal-ai/glm-image` | GLM Image: Accurate text rendering |
| `fal-ai/glm-image/image-to-image` | GLM Image style transfer |
| `fal-ai/qwen-image-2512/lora` | Qwen Image 2512 with LoRA |
| `fal-ai/qwen-image-edit-2511-multiple-angles` | Qwen Multi-Angles editing |
| `bria/fibo-edit/edit` | Bria Fibo Edit: JSON + Mask + Image |
| `bria/fibo-edit/blend` | Bria Fibo multi-step composition |
| `bria/fibo-edit/colorize` | Bria Fibo style-based colors |
| `bria/fibo-edit/relight` | Bria Fibo controllable lighting |
| `bria/fibo-edit/restyle` | Bria Fibo artistic styles |
| `bria/fibo-edit/restore` | Bria Fibo noise cleanup |
| `bria/fibo-edit/reseason` | Bria Fibo seasonal transforms |
| `bria/fibo-edit/rewrite_text` | Bria Fibo text modification |
| `bria/fibo-edit/erase_by_text` | Bria Fibo text-based erasing |
| `bria/fibo-edit/add_object_by_text` | Bria Fibo object insertion |
| `bria/replace-background` | Bria Background Replace |
| `bria/fibo-lite/generate` | Bria Fibo Lite: Fast high-quality |
| `imagineart/imagineart-1.5-pro-preview/text-to-image` | ImagineArt 1.5 Pro: 4K images |

### Image Generation — December 2025

| Endpoint | Description |
|----------|-------------|
| `fal-ai/qwen-image-2512` | Qwen Image 2512: Better text & textures |
| `fal-ai/qwen-image-edit-2511` | Qwen Image Edit 2511: Superior editing |
| `fal-ai/qwen-image-edit-2511/lora` | Qwen Edit 2511 with LoRA |
| `fal-ai/qwen-image-layered` | Qwen Layered: RGBA decomposition |
| `fal-ai/flux-2-max` | FLUX.2 Max: State-of-the-art |
| `fal-ai/flux-2-max/edit` | FLUX.2 Max editing |
| `fal-ai/flux-2/turbo` | FLUX.2 Turbo: Fast generation |
| `fal-ai/flux-2/turbo/edit` | FLUX.2 Turbo editing |
| `fal-ai/flux-2/flash` | FLUX.2 Flash: Ultra-fast |
| `fal-ai/flux-2/flash/edit` | FLUX.2 Flash editing |
| `fal-ai/gpt-image-1.5` | GPT Image 1.5: Strong prompt adherence |
| `fal-ai/gpt-image-1.5/edit` | GPT Image 1.5 editing |
| `fal-ai/stepx-edit2` | Step1X-Edit V2: Reasoning-enhanced |
| `fal-ai/bytedance/seedream/v4.5/text-to-image` | Seedream 4.5: ByteDance |
| `fal-ai/bytedance/seedream/v4.5/edit` | Seedream 4.5 editing |
| `fal-ai/z-image/turbo` | Z-Image Turbo: 6B super fast |
| `fal-ai/z-image/turbo/lora` | Z-Image Turbo with LoRA |
| `fal-ai/z-image/turbo/inpaint` | Z-Image Turbo inpainting |
| `fal-ai/z-image/turbo/controlnet` | Z-Image Turbo ControlNet |
| `fal-ai/z-image/turbo/image-to-image` | Z-Image Turbo I2I |
| `wan/v2.6/text-to-image` | Wan 2.6 text-to-image |
| `wan/v2.6/image-to-image` | Wan 2.6 image-to-image |

### Image Generation — November 2025

| Endpoint | Description |
|----------|-------------|
| `fal-ai/flux-2` | FLUX.2 [dev]: Enhanced realism |
| `fal-ai/flux-2/edit` | FLUX.2 editing |
| `fal-ai/flux-2/lora` | FLUX.2 with LoRA |
| `fal-ai/flux-2-pro` | FLUX.2 [pro]: Maximum quality |
| `fal-ai/flux-2-pro/edit` | FLUX.2 Pro editing |
| `fal-ai/flux-2-flex` | FLUX.2 [flex]: Multi-reference |
| `fal-ai/flux-2-trainer` | FLUX.2 LoRA trainer |
| `fal-ai/chrono-edit` | NVIDIA Chrono Edit: Physics-aware |
| `fal-ai/nano-banana-pro` | Nano Banana Pro: Google's new SOTA |
| `fal-ai/nano-banana-pro/edit` | Nano Banana Pro editing |
| `fal-ai/sam-3/image` | SAM 3: Universal segmentation |
| `clarityai/crystal-upscaler` | Crystal Upscaler |

### Image Generation — October 2025

| Endpoint | Description |
|----------|-------------|
| `bria/fibo/generate` | Bria Fibo: SOTA open source |
| `fal-ai/piflow` | PiFlow: Fast quality images |
| `fal-ai/gpt-image-1-mini` | GPT Image 1 Mini: Efficient |
| `fal-ai/image2pixel` | Image2Pixel: Retro art |
| `fal-ai/dreamomni2/edit` | DreamOmni2: Unified editing |
| `fal-ai/lucidflux` | LucidFlux: High-fidelity upscaling |

---

### Video Generation — February 2026

| Endpoint | Description |
|----------|-------------|
| `fal-ai/kling-video/v3/pro/text-to-video` | Kling 3.0 Pro: Cinematic + native audio + multi-shot |
| `fal-ai/kling-video/v3/standard/text-to-video` | Kling 3.0 Standard: Cost-effective |
| `fal-ai/kling-video/v3/pro/image-to-video` | Kling 3.0 Pro I2V with custom elements |
| `fal-ai/kling-video/v3/standard/image-to-video` | Kling 3.0 Standard I2V |
| `fal-ai/kling-video/o3/pro/text-to-video` | Kling O3 Pro: Realistic videos |
| `fal-ai/kling-video/o3/pro/image-to-video` | Kling O3 Pro I2V with start/end frames |
| `fal-ai/kling-video/o3/pro/reference-to-video` | Kling O3 Reference: Character consistency |
| `fal-ai/kling-video/o3/pro/video-to-video/edit` | Kling O3 natural-language video editing |
| `fal-ai/kling-video/o3/pro/video-to-video/reference` | Kling O3 video style transfer |
| `fal-ai/kling-video/o3/standard/text-to-video` | Kling O3 Standard |
| `fal-ai/kling-video/o3/standard/image-to-video` | Kling O3 Standard I2V |
| `xai/grok-imagine-video/text-to-video` | Grok Imagine Video with audio |
| `xai/grok-imagine-video/image-to-video` | Grok Video I2V with audio |
| `xai/grok-imagine-video/edit-video` | Grok Video editing |

### Video Generation — January 2026

| Endpoint | Description |
|----------|-------------|
| `fal-ai/vidu/q3/text-to-video` | Vidu Q3: Latest Vidu model |
| `fal-ai/vidu/q3/image-to-video` | Vidu Q3 I2V |
| `fal-ai/pixverse/v5.6/text-to-video` | Pixverse V5.6 T2V |
| `fal-ai/pixverse/v5.6/image-to-video` | Pixverse V5.6 I2V |
| `fal-ai/pixverse/v5.6/transition` | Pixverse V5.6 transitions |
| `fal-ai/ltx-2-19b/text-to-video` | LTX-2 19B: Video with audio |
| `fal-ai/ltx-2-19b/image-to-video` | LTX-2 19B I2V with audio |
| `fal-ai/ltx-2-19b/video-to-video` | LTX-2 19B video transformation |
| `fal-ai/ltx-2-19b/extend-video` | LTX-2 19B video extension |
| `fal-ai/ltx-2-19b/audio-to-video` | LTX-2 19B audio-driven video |
| `fal-ai/ltx-2-19b/distilled/text-to-video` | LTX-2 Distilled: Faster |
| `fal-ai/ltx-2-19b/distilled/image-to-video` | LTX-2 Distilled I2V |
| `wan/v2.6/image-to-video/flash` | Wan 2.6 Flash I2V |
| `fal-ai/longcat-multi-avatar/image-audio-to-video` | LongCat Multi Avatar: Lip-sync |
| `fal-ai/elevenlabs/dubbing` | ElevenLabs Dubbing |

### Video Generation — December 2025

| Endpoint | Description |
|----------|-------------|
| `fal-ai/kling-video/v2.6/pro/text-to-video` | Kling 2.6 Pro: Top-tier with audio |
| `fal-ai/kling-video/v2.6/pro/image-to-video` | Kling 2.6 Pro I2V |
| `fal-ai/kling-video/ai-avatar/v2/pro` | Kling AI Avatar V2 Pro |
| `fal-ai/kling-video/ai-avatar/v2/standard` | Kling AI Avatar V2 Standard |
| `fal-ai/kandinsky5-pro/text-to-video` | Kandinsky 5 Pro T2V |
| `fal-ai/kandinsky5-pro/image-to-video` | Kandinsky 5 Pro I2V |
| `fal-ai/bytedance/seedance/v1.5/pro/text-to-video` | Seedance 1.5 Pro T2V |
| `fal-ai/bytedance/seedance/v1.5/pro/image-to-video` | Seedance 1.5 Pro I2V |
| `fal-ai/hunyuan-video-v1.5/text-to-video` | Hunyuan Video 1.5 T2V |
| `fal-ai/hunyuan-video-v1.5/image-to-video` | Hunyuan Video 1.5 I2V |
| `fal-ai/veo3.1` | Veo 3.1: Google's best with sound |
| `fal-ai/veo3.1/fast` | Veo 3.1 Fast: Cost-effective |
| `fal-ai/veo3.1/image-to-video` | Veo 3.1 I2V |
| `fal-ai/veo3.1/extend-video` | Veo 3.1 Extend: Up to 30s |
| `fal-ai/veo3.1/first-last-frame-to-video` | Veo 3.1 Start/End frames |
| `fal-ai/veo3.1/reference-to-video` | Veo 3.1 Reference |
| `fal-ai/live-avatar` | Live Avatar: Real-time streaming |
| `fal-ai/lightx/relight` | LightX: Video relighting |
| `fal-ai/lightx/recamera` | LightX: Camera changes |
| `decart/lucy-restyle` | Lucy Restyle: Up to 30min |
| `fal-ai/scail` | SCAIL: 3D consistent animation |
| `fal-ai/wan-vision-enhancer` | Wan Vision Enhancer: Video upscale |
| `fal-ai/sync-lipsync/react-1` | Sync React-1: Emotion refinement |
| `fal-ai/wan-move` | Wan Move: Trajectory control |
| `clarityai/crystal-video-upscaler` | Crystal Video Upscaler |
| `fal-ai/creatify/aurora` | Creatify Aurora: Studio avatars |

### Video Generation — November 2025

| Endpoint | Description |
|----------|-------------|
| `fal-ai/ltx-2/text-to-video` | LTX-2 Pro: Video with audio |
| `fal-ai/ltx-2/image-to-video` | LTX-2 Pro I2V |
| `fal-ai/ltx-2/text-to-video/fast` | LTX-2 Fast |
| `fal-ai/ltx-2/retake-video` | LTX-2 Retake |
| `bytedance/lynx` | ByteDance Lynx: Subject consistency |
| `fal-ai/editto` | Editto: Instruction-based editing |
| `fal-ai/flashvsr/upscale/video` | FlashVSR: Video upscaling |
| `fal-ai/infinity-star/text-to-video` | InfinityStar: 8B autoregressive |
| `fal-ai/sana-video` | Sana Video: Ultra-fast |

### Video Generation — October 2025

| Endpoint | Description |
|----------|-------------|
| `fal-ai/video-as-prompt` | Video as Prompt: Motion transfer |
| `fal-ai/minimax/hailuo-2.3/*` | MiniMax Hailuo 2.3: Up to 1080p |
| `fal-ai/birefnet/v2/video` | BiRefNet Video: BG removal |
| `fal-ai/vidu/q2/*` | Vidu Q2 variants |
| `fal-ai/sora-2/*` | Sora 2: OpenAI's best |
| `fal-ai/kling-video/video-to-audio` | Kling Video to Audio |
| `fal-ai/luma-dream-machine/ray-2` | Ray 2: Luma's best |

---

### Audio — February 2026

| Endpoint | Description |
|----------|-------------|
| `fal-ai/minimax/speech-2.8-hd` | MiniMax Speech 2.8 HD: High-quality TTS |
| `fal-ai/minimax/speech-2.8-turbo` | MiniMax Speech 2.8 Turbo: Fast TTS |

### Audio — January 2026

| Endpoint | Description |
|----------|-------------|
| `fal-ai/qwen-3-tts/text-to-speech/1.7b` | Qwen-3 TTS 1.7B: Custom voices |
| `fal-ai/qwen-3-tts/text-to-speech/0.6b` | Qwen-3 TTS 0.6B: Lightweight |
| `fal-ai/qwen-3-tts/clone-voice/1.7b` | Qwen-3 Voice Clone: Zero-shot |
| `fal-ai/qwen-3-tts/clone-voice/0.6b` | Qwen-3 Voice Clone Light |
| `fal-ai/qwen-3-tts/voice-design/1.7b` | Qwen-3 Voice Design |
| `fal-ai/nemotron/asr` | Nemotron ASR: Fast & accurate STT |
| `fal-ai/nemotron/asr/stream` | Nemotron ASR Streaming |
| `fal-ai/elevenlabs/voice-changer` | ElevenLabs Voice Changer |
| `fal-ai/elevenlabs/speech-to-text/scribe-v2` | ElevenLabs Scribe V2: Fast STT |
| `fal-ai/nova-sr` | Nova SR: 16kHz to 48kHz enhance |
| `fal-ai/silero-vad` | Silero VAD: Speech detection |
| `fal-ai/deepfilternet3` | DeepFilterNet3: Noise removal |

### Audio — December 2025

| Endpoint | Description |
|----------|-------------|
| `fal-ai/sam-audio/separate` | SAM Audio: Text-guided separation |
| `fal-ai/sam-audio/span-separate` | SAM Audio Span |
| `fal-ai/sam-audio/visual-separate` | SAM Audio Visual |
| `fal-ai/elevenlabs/music` | ElevenLabs Music |
| `fal-ai/vibevoice/0.5b` | VibeVoice: Fast TTS |
| `fal-ai/maya/batch` | Maya Batch: Expressive voice |
| `fal-ai/maya/stream` | Maya Stream |

### Audio — October 2025

| Endpoint | Description |
|----------|-------------|
| `fal-ai/minimax-music/v2` | MiniMax Music 2.0 |
| `fal-ai/minimax/speech-2.6-turbo` | MiniMax Speech 2.6 Turbo |
| `fal-ai/minimax/speech-2.6-hd` | MiniMax Speech 2.6 HD |
| `fal-ai/demucs` | Demucs: SOTA stemming |
| `fal-ai/audio-understanding` | Audio Understanding |
| `beatoven/sound-effect-generation` | Beatoven SFX |
| `beatoven/music-generation` | Beatoven Music |
| `fal-ai/index-tts-2/text-to-speech` | Index TTS 2.0 |

---

### 3D Generation — February 2026

| Endpoint | Description |
|----------|-------------|
| `fal-ai/hunyuan-3d/v3.1/pro/text-to-3d` | Hunyuan 3D V3.1 Pro: Text to 3D |
| `fal-ai/hunyuan-3d/v3.1/pro/image-to-3d` | Hunyuan 3D V3.1 Pro: Image to 3D |
| `fal-ai/hunyuan-3d/v3.1/rapid/text-to-3d` | Hunyuan 3D Rapid: Fast text to 3D |
| `fal-ai/hunyuan-3d/v3.1/rapid/image-to-3d` | Hunyuan 3D Rapid: Fast image to 3D |
| `fal-ai/hunyuan-3d/v3.1/smart-topology` | Hunyuan Smart Topology |
| `fal-ai/hunyuan-3d/v3.1/part` | Hunyuan 3D Part: Split into parts |
| `fal-ai/ultrashape` | UltraShape 1.0: High-fidelity geometry |

### 3D Generation — December 2025

| Endpoint | Description |
|----------|-------------|
| `fal-ai/trellis-2` | Trellis 2: Versatile 3D |
| `fal-ai/hunyuan3d-v3/text-to-3d` | Hunyuan 3D V3 text-to-3D |
| `fal-ai/hunyuan3d-v3/sketch-to-3d` | Hunyuan 3D V3 sketch-to-3D |
| `fal-ai/hunyuan3d-v3/image-to-3d` | Hunyuan 3D V3 image-to-3D |
| `fal-ai/hunyuan-motion` | Hunyuan Motion: 3D animation |
| `fal-ai/hunyuan-motion/fast` | Hunyuan Motion Fast |
| `fal-ai/sam-3/3d-align` | SAM 3D Align: Scene reconstruction |
| `fal-ai/sam-3/3d-body` | SAM 3D Body: Human body 3D |
| `fal-ai/sam-3/3d-objects` | SAM 3D Objects |

### 3D Generation — October 2025

| Endpoint | Description |
|----------|-------------|
| `fal-ai/omnipart` | OmniPart: Part-aware 3D |
| `fal-ai/bytedance/seed3d/image-to-3d` | ByteDance Seed3D |
| `fal-ai/meshy/v6-preview/text-to-3d` | Meshy V6 Preview |
| `fal-ai/hunyuan-part` | Hunyuan Part: Point clouds |

---

## OpenRouter — Run Any LLM/VLM/ALM on fal.ai

Access 100+ LLMs, vision, audio, and video language models via OpenRouter integration. Supports GPT-5, Claude, Gemini, Llama 4, Grok and more.

### Text (LLM)

| Endpoint | Description |
|----------|-------------|
| `openrouter/router` | Run any LLM: GPT-5, Claude, Gemini, Llama 4, Mistral, etc. |
| `openrouter/router/stream` | LLM with streaming response |
| `openrouter/router/enterprise` | Enterprise LLM (enhanced SLA) |
| `openrouter/router/enterprise/stream` | Enterprise LLM streaming |

### Vision (VLM)

| Endpoint | Description |
|----------|-------------|
| `openrouter/router/vision` | Run any VLM: Analyze images with GPT-5, Gemini, Claude, etc. |
| `openrouter/router/vision/stream` | Vision with streaming response |
| `openrouter/router/vision/enterprise` | Enterprise vision (enhanced SLA) |
| `openrouter/router/vision/enterprise/stream` | Enterprise vision streaming |

### Audio (ALM)

| Endpoint | Description |
|----------|-------------|
| `openrouter/router/audio` | Run any ALM: Process audio with Gemini, etc. |
| `openrouter/router/audio/stream` | Audio with streaming response |
| `openrouter/router/audio/enterprise` | Enterprise audio (enhanced SLA) |
| `openrouter/router/audio/enterprise/stream` | Enterprise audio streaming |

### Video (VLM)

| Endpoint | Description |
|----------|-------------|
| `openrouter/router/video` | Run any video LM: Analyze video with Gemini, etc. |
| `openrouter/router/video/stream` | Video with streaming response |
| `openrouter/router/video/enterprise` | Enterprise video (enhanced SLA) |
| `openrouter/router/video/enterprise/stream` | Enterprise video streaming |

### OpenAI-Compatible

| Endpoint | Description |
|----------|-------------|
| `openrouter/router/openai/v1/chat/completions` | OpenAI Chat Completions API compatible |
| `openrouter/router/openai/v1/responses` | OpenAI Responses API compatible |
| `openrouter/router/openai/v1/embeddings` | OpenAI Embeddings API compatible |

---

## Model Selection Guide

| Use Case | Recommended Model |
|----------|------------------|
| **Best quality image** | `fal-ai/kling-image/o3/text-to-image` |
| **Fastest image** | `fal-ai/z-image/turbo` |
| **Photorealistic portrait** | `fal-ai/flux-2/klein/9b` |
| **Text in images** | `fal-ai/glm-image` or `fal-ai/ideogram/v3` |
| **Image editing** | `fal-ai/qwen-image-max/edit` |
| **Best quality video** | `fal-ai/kling-video/v3/pro/text-to-video` |
| **Fastest video** | `fal-ai/ltx-2-19b/distilled/text-to-video` |
| **Video with audio** | `xai/grok-imagine-video/text-to-video` |
| **Image animation** | `fal-ai/kling-video/o3/pro/image-to-video` |
| **Natural TTS** | `fal-ai/minimax/speech-2.8-hd` |
| **Fast TTS** | `fal-ai/qwen-3-tts/text-to-speech/0.6b` |
| **Voice cloning** | `fal-ai/qwen-3-tts/clone-voice/1.7b` |
| **Transcription** | `fal-ai/nemotron/asr` |
| **3D from text** | `fal-ai/hunyuan-3d/v3.1/pro/text-to-3d` |
| **3D from image** | `fal-ai/hunyuan-3d/v3.1/rapid/image-to-3d` |
| **Talking avatar** | `fal-ai/longcat-multi-avatar/image-audio-to-video` |
| **Any LLM** | `openrouter/router` |
| **Image analysis** | `openrouter/router/vision` |
| **Audio analysis** | `openrouter/router/audio` |
| **Video analysis** | `openrouter/router/video` |

---

## Usage Patterns

### 1. Queue Mode (Default)

```bash
./scripts/generate.sh --model fal-ai/flux-2/klein/9b \
  --prompt "Portrait of a scientist" --wait
```

### 2. Async Mode

```bash
REQUEST_ID=$(./scripts/generate.sh --model fal-ai/kling-video/v3/pro/text-to-video \
  --prompt "Drone flying over a city" --async)
./scripts/poll.sh fal-ai/kling-video/v3/pro/text-to-video $REQUEST_ID
```

### 3. With File Upload

```bash
IMAGE_URL=$(./scripts/upload.sh ~/photos/portrait.jpg)
./scripts/generate.sh --model fal-ai/kling-video/o3/pro/image-to-video \
  --image-url "$IMAGE_URL" --prompt "Gentle wind blowing through hair"
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

## Tips

1. **Use queue for videos** - They take longer, queue prevents timeouts
2. **Check model schema** - Use `./scripts/models.sh --schema <endpoint>`
3. **Upload large files first** - Use `./scripts/upload.sh` for files > 1MB
4. **Set webhooks for long tasks** - Avoid polling for 3D generation
5. **Use seeds for reproducibility** - Same seed = same output
6. **Use LoRA variants** - For custom styles, prefer `-lora` endpoints
7. **Pro vs Standard** - Pro = better quality, Standard = cost-effective
8. **Flash/Turbo/Distilled** - Best for previews and fast iterations
