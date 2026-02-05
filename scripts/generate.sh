#!/bin/bash
# fal-generate: Generate AI content using fal.ai models
# Usage: ./generate.sh --model <endpoint> --prompt "text" [options]

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Defaults
MODEL=""
PROMPT=""
IMAGE_URL=""
VIDEO_URL=""
AUDIO_URL=""
TEXT=""
ASPECT_RATIO=""
DURATION=""
SEED=""
WAIT=false
ASYNC=false
WEBHOOK=""
EXTRA_PARAMS=""

# Help
show_help() {
  cat << EOF
fal-generate: Generate AI content using fal.ai models

USAGE:
  ./generate.sh --model <endpoint> [options]

OPTIONS:
  --model, -m       Model endpoint (required)
  --prompt, -p      Text prompt for generation
  --image-url       Input image URL
  --video-url       Input video URL
  --audio-url       Input audio URL
  --text, -t        Text for TTS models
  --aspect-ratio    Output aspect ratio (16:9, 9:16, 1:1, etc.)
  --duration        Video duration in seconds
  --seed            Random seed for reproducibility
  --wait, -w        Poll until completion (default: false)
  --async, -a       Return request ID only
  --webhook         Webhook URL for callback
  --param           Extra parameter (key=value format, can repeat)
  --help, -h        Show this help

EXAMPLES:
  # Text-to-Image
  ./generate.sh -m fal-ai/kling-image/v3/text-to-image -p "A sunset" -w

  # Image-to-Video
  ./generate.sh -m fal-ai/kling-video/v3/pro/image-to-video \
    --image-url "https://..." -p "Animate gently" -w

  # Text-to-Speech
  ./generate.sh -m fal-ai/minimax/speech-2.8-hd -t "Hello world" -w

  # With extra params
  ./generate.sh -m fal-ai/flux-2/klein/9b -p "Portrait" \
    --param num_inference_steps=28 --param guidance_scale=3.5 -w

FEATURED MODELS:
  Image:  fal-ai/kling-image/v3/text-to-image, fal-ai/flux-2/klein/9b
  Video:  fal-ai/kling-video/v3/pro/text-to-video, fal-ai/vidu/q3/text-to-video
  Audio:  fal-ai/minimax/speech-2.8-hd, fal-ai/qwen-3-tts/text-to-speech/1.7b
  3D:     fal-ai/hunyuan-3d/v3.1/pro/text-to-3d, fal-ai/ultrashape
EOF
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --model|-m)
      MODEL="$2"
      shift 2
      ;;
    --prompt|-p)
      PROMPT="$2"
      shift 2
      ;;
    --image-url)
      IMAGE_URL="$2"
      shift 2
      ;;
    --video-url)
      VIDEO_URL="$2"
      shift 2
      ;;
    --audio-url)
      AUDIO_URL="$2"
      shift 2
      ;;
    --text|-t)
      TEXT="$2"
      shift 2
      ;;
    --aspect-ratio)
      ASPECT_RATIO="$2"
      shift 2
      ;;
    --duration)
      DURATION="$2"
      shift 2
      ;;
    --seed)
      SEED="$2"
      shift 2
      ;;
    --wait|-w)
      WAIT=true
      shift
      ;;
    --async|-a)
      ASYNC=true
      shift
      ;;
    --webhook)
      WEBHOOK="$2"
      shift 2
      ;;
    --param)
      EXTRA_PARAMS="$EXTRA_PARAMS,$2"
      shift 2
      ;;
    --help|-h)
      show_help
      exit 0
      ;;
    *)
      echo -e "${RED}Unknown option: $1${NC}"
      show_help
      exit 1
      ;;
  esac
done

# Validate
if [ -z "$MODEL" ]; then
  echo -e "${RED}Error: --model is required${NC}"
  show_help
  exit 1
fi

# Check FAL_KEY
if [ -z "$FAL_KEY" ]; then
  # Try to find FAL_KEY
  for f in .test_env ../.test_env ../../.test_env; do
    if [ -f "$f" ]; then
      export FAL_KEY=$(grep FAL_KEY "$f" | cut -d= -f2)
      break
    fi
  done
fi

if [ -z "$FAL_KEY" ]; then
  echo -e "${RED}Error: FAL_KEY not found${NC}"
  echo "Please set FAL_KEY in your environment or create a .test_env file"
  exit 1
fi

# Check jq
if ! command -v jq &> /dev/null; then
  echo -e "${RED}Error: jq is required but not installed${NC}"
  exit 1
fi

# Build JSON payload
build_payload() {
  local payload="{"
  local first=true

  add_field() {
    if [ -n "$2" ]; then
      if [ "$first" = false ]; then
        payload+=","
      fi
      payload+="\"$1\":\"$2\""
      first=false
    fi
  }

  add_field_number() {
    if [ -n "$2" ]; then
      if [ "$first" = false ]; then
        payload+=","
      fi
      payload+="\"$1\":$2"
      first=false
    fi
  }

  add_field "prompt" "$PROMPT"
  add_field "image_url" "$IMAGE_URL"
  add_field "video_url" "$VIDEO_URL"
  add_field "audio_url" "$AUDIO_URL"
  add_field "text" "$TEXT"
  add_field "aspect_ratio" "$ASPECT_RATIO"
  add_field_number "duration" "$DURATION"
  add_field_number "seed" "$SEED"

  # Add extra params
  if [ -n "$EXTRA_PARAMS" ]; then
    IFS=',' read -ra PARAMS <<< "${EXTRA_PARAMS:1}"
    for param in "${PARAMS[@]}"; do
      key=$(echo "$param" | cut -d= -f1)
      value=$(echo "$param" | cut -d= -f2)
      # Check if value is a number
      if [[ "$value" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        add_field_number "$key" "$value"
      else
        add_field "$key" "$value"
      fi
    done
  fi

  payload+="}"
  echo "$payload"
}

# Submit request
submit_request() {
  local payload=$(build_payload)
  local url="https://queue.fal.run/$MODEL"

  echo -e "${BLUE}Submitting to $MODEL...${NC}" >&2

  local response=$(curl -s -X POST "$url" \
    -H "Authorization: Key $FAL_KEY" \
    -H "Content-Type: application/json" \
    -d "$payload")

  local request_id=$(echo "$response" | jq -r '.request_id // empty')

  if [ -z "$request_id" ]; then
    echo -e "${RED}Error submitting request:${NC}" >&2
    echo "$response" | jq >&2
    exit 1
  fi

  echo "$request_id"
}

# Poll for status
poll_status() {
  local request_id="$1"
  local url="https://queue.fal.run/$MODEL/requests/$request_id/status"

  while true; do
    local response=$(curl -s "$url" -H "Authorization: Key $FAL_KEY")
    local status=$(echo "$response" | jq -r '.status')

    case "$status" in
      "COMPLETED")
        echo -e "${GREEN}Completed!${NC}" >&2
        return 0
        ;;
      "FAILED")
        echo -e "${RED}Failed${NC}" >&2
        return 1
        ;;
      "IN_QUEUE")
        local position=$(echo "$response" | jq -r '.queue_position // "?"')
        echo -e "${YELLOW}In queue (position: $position)...${NC}" >&2
        ;;
      "IN_PROGRESS")
        echo -e "${BLUE}Processing...${NC}" >&2
        ;;
      *)
        echo -e "${YELLOW}Status: $status${NC}" >&2
        ;;
    esac

    sleep 3
  done
}

# Get result
get_result() {
  local request_id="$1"
  local url="https://queue.fal.run/$MODEL/requests/$request_id"

  curl -s "$url" -H "Authorization: Key $FAL_KEY" | jq
}

# Main execution
REQUEST_ID=$(submit_request)

if [ "$ASYNC" = true ]; then
  # Just print request ID
  echo "$REQUEST_ID"
  exit 0
fi

echo -e "${GREEN}Request ID: $REQUEST_ID${NC}" >&2

if [ "$WAIT" = true ]; then
  echo -e "${BLUE}Waiting for completion...${NC}" >&2
  if poll_status "$REQUEST_ID"; then
    get_result "$REQUEST_ID"
  else
    get_result "$REQUEST_ID"
    exit 1
  fi
else
  echo -e "${YELLOW}Use --wait to poll for completion, or check status with:${NC}" >&2
  echo "curl -s \"https://queue.fal.run/$MODEL/requests/$REQUEST_ID/status\" -H \"Authorization: Key \$FAL_KEY\" | jq" >&2
fi
