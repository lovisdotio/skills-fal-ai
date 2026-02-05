#!/bin/bash
# fal-models: Search and discover fal.ai models
# Usage: ./models.sh [options]

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Defaults
QUERY=""
CATEGORY=""
LIMIT=20
SCHEMA=""
PRICING=""
LIST_FEATURED=false

# Help
show_help() {
  cat << EOF
fal-models: Search and discover fal.ai models

USAGE:
  ./models.sh [options]

OPTIONS:
  --search, -s    Search by keyword
  --category, -c  Filter by category (text-to-image, image-to-video, etc.)
  --limit, -l     Max results (default: 20)
  --schema        Get OpenAPI schema for an endpoint
  --pricing       Get pricing for an endpoint
  --featured      List featured recent models
  --help, -h      Show this help

CATEGORIES:
  text-to-image, image-to-image, text-to-video, image-to-video,
  text-to-audio, speech-to-text, text-to-3d, image-to-3d, training

EXAMPLES:
  ./models.sh --search "video generation"
  ./models.sh --category text-to-video --limit 10
  ./models.sh --schema fal-ai/kling-video/v3/pro/text-to-video
  ./models.sh --pricing fal-ai/flux-2/klein/9b
  ./models.sh --featured
EOF
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --search|-s)
      QUERY="$2"
      shift 2
      ;;
    --category|-c)
      CATEGORY="$2"
      shift 2
      ;;
    --limit|-l)
      LIMIT="$2"
      shift 2
      ;;
    --schema)
      SCHEMA="$2"
      shift 2
      ;;
    --pricing)
      PRICING="$2"
      shift 2
      ;;
    --featured)
      LIST_FEATURED=true
      shift
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

# Check FAL_KEY
if [ -z "$FAL_KEY" ]; then
  for f in .test_env ../.test_env ../../.test_env; do
    if [ -f "$f" ]; then
      export FAL_KEY=$(grep FAL_KEY "$f" | cut -d= -f2)
      break
    fi
  done
fi

if [ -z "$FAL_KEY" ]; then
  echo -e "${RED}Error: FAL_KEY not found${NC}"
  exit 1
fi

# Check jq
if ! command -v jq &> /dev/null; then
  echo -e "${RED}Error: jq is required${NC}"
  exit 1
fi

# Featured models
list_featured() {
  echo -e "${CYAN}=== Featured Models (February 2026) ===${NC}\n"

  echo -e "${GREEN}IMAGE GENERATION${NC}"
  echo "  fal-ai/kling-image/v3/text-to-image     - Kling V3 (latest)"
  echo "  fal-ai/kling-image/o3/text-to-image     - Kling Omni 3 (best consistency)"
  echo "  xai/grok-imagine-image                  - Grok Imagine (highly aesthetic)"
  echo "  fal-ai/flux-2/klein/9b                  - FLUX.2 Klein 9B (photorealistic)"
  echo "  fal-ai/qwen-image-max/text-to-image     - Qwen Image Max (natural textures)"
  echo "  fal-ai/hunyuan-image/v3/instruct/text-to-image - Hunyuan 3.0 (reasoning)"
  echo "  fal-ai/z-image/base                     - Z-Image Base (6B fast)"
  echo "  fal-ai/glm-image                        - GLM Image (text rendering)"
  echo ""

  echo -e "${GREEN}VIDEO GENERATION${NC}"
  echo "  fal-ai/kling-video/v3/pro/text-to-video - Kling V3 Pro (cinematic + audio)"
  echo "  fal-ai/kling-video/o3/pro/text-to-video - Kling O3 Pro (realistic motion)"
  echo "  xai/grok-imagine-video/text-to-video    - Grok Video (with audio)"
  echo "  fal-ai/vidu/q3/text-to-video            - Vidu Q3 (quality control)"
  echo "  fal-ai/ltx-2-19b/text-to-video          - LTX-2 19B (LoRA support)"
  echo "  fal-ai/pixverse/v5.6/text-to-video      - Pixverse V5.6"
  echo "  wan/v2.6/text-to-video                  - Wan 2.6"
  echo ""

  echo -e "${GREEN}AUDIO${NC}"
  echo "  fal-ai/minimax/speech-2.8-hd            - MiniMax 2.8 HD TTS"
  echo "  fal-ai/qwen-3-tts/text-to-speech/1.7b   - Qwen-3 TTS (custom voices)"
  echo "  fal-ai/nemotron/asr                     - Nemotron ASR (fast STT)"
  echo "  fal-ai/elevenlabs/speech-to-text/scribe-v2 - ElevenLabs Scribe"
  echo "  fal-ai/nova-sr                          - Nova SR (audio enhance)"
  echo ""

  echo -e "${GREEN}3D GENERATION${NC}"
  echo "  fal-ai/hunyuan-3d/v3.1/pro/text-to-3d   - Hunyuan 3D V3.1 Pro"
  echo "  fal-ai/hunyuan-3d/v3.1/rapid/image-to-3d- Hunyuan 3D Rapid"
  echo "  fal-ai/ultrashape                       - UltraShape (high-fidelity)"
  echo "  fal-ai/trellis-2                        - Trellis 2"
}

# Get model schema
get_schema() {
  local endpoint="$1"
  echo -e "${BLUE}Fetching schema for $endpoint...${NC}" >&2

  curl -s "https://api.fal.ai/v1/models?endpoint_id=$endpoint&expand=openapi-3.0" \
    -H "Authorization: Key $FAL_KEY" | jq '.models[0].openapi_schema // .models[0]'
}

# Get pricing
get_pricing() {
  local endpoint="$1"
  echo -e "${BLUE}Fetching pricing for $endpoint...${NC}" >&2

  curl -s "https://api.fal.ai/v1/models/pricing?endpoint_id=$endpoint" \
    -H "Authorization: Key $FAL_KEY" | jq
}

# Search models
search_models() {
  local url="https://api.fal.ai/v1/models?status=active&limit=$LIMIT"

  if [ -n "$QUERY" ]; then
    url+="&q=$(echo "$QUERY" | jq -sRr @uri)"
  fi

  if [ -n "$CATEGORY" ]; then
    url+="&category=$CATEGORY"
  fi

  echo -e "${BLUE}Searching models...${NC}" >&2

  response=$(curl -s "$url" -H "Authorization: Key $FAL_KEY")

  echo "$response" | jq -r '.models[] | "\(.endpoint_id)\t\(.title // .name)"' | \
    while IFS=$'\t' read -r endpoint title; do
      printf "${GREEN}%-50s${NC} %s\n" "$endpoint" "$title"
    done
}

# Main
if [ "$LIST_FEATURED" = true ]; then
  list_featured
elif [ -n "$SCHEMA" ]; then
  get_schema "$SCHEMA"
elif [ -n "$PRICING" ]; then
  get_pricing "$PRICING"
else
  search_models
fi
