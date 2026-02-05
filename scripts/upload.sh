#!/bin/bash
# fal-upload: Upload files to fal.ai CDN
# Usage: ./upload.sh <file_path>

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Help
show_help() {
  cat << EOF
fal-upload: Upload files to fal.ai CDN

USAGE:
  ./upload.sh <file_path>

ARGUMENTS:
  file_path    Path to the file to upload (required)

SUPPORTED FORMATS:
  Images: jpg, jpeg, png, gif, webp, bmp
  Videos: mp4, mov, avi, webm, mkv
  Audio:  mp3, wav, m4a, ogg, flac

EXAMPLES:
  ./upload.sh ~/photos/portrait.jpg
  ./upload.sh ./video.mp4

OUTPUT:
  Returns the CDN URL of the uploaded file

NOTES:
  - Maximum file size: 100MB
  - Files are stored temporarily and may expire
  - Use the returned URL in generation requests
EOF
}

# Parse arguments
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
  show_help
  exit 0
fi

FILE_PATH="$1"

if [ -z "$FILE_PATH" ]; then
  echo -e "${RED}Error: file path is required${NC}"
  show_help
  exit 1
fi

if [ ! -f "$FILE_PATH" ]; then
  echo -e "${RED}Error: file not found: $FILE_PATH${NC}"
  exit 1
fi

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
  echo -e "${RED}Error: jq is required but not installed${NC}"
  exit 1
fi

# Get file size
FILE_SIZE=$(stat -f%z "$FILE_PATH" 2>/dev/null || stat -c%s "$FILE_PATH" 2>/dev/null)
MAX_SIZE=$((100 * 1024 * 1024))  # 100MB

if [ "$FILE_SIZE" -gt "$MAX_SIZE" ]; then
  echo -e "${RED}Error: file too large (max 100MB)${NC}"
  exit 1
fi

# Get content type
get_content_type() {
  local ext="${1##*.}"
  ext=$(echo "$ext" | tr '[:upper:]' '[:lower:]')

  case "$ext" in
    jpg|jpeg) echo "image/jpeg" ;;
    png) echo "image/png" ;;
    gif) echo "image/gif" ;;
    webp) echo "image/webp" ;;
    bmp) echo "image/bmp" ;;
    mp4) echo "video/mp4" ;;
    mov) echo "video/quicktime" ;;
    avi) echo "video/x-msvideo" ;;
    webm) echo "video/webm" ;;
    mkv) echo "video/x-matroska" ;;
    mp3) echo "audio/mpeg" ;;
    wav) echo "audio/wav" ;;
    m4a) echo "audio/mp4" ;;
    ogg) echo "audio/ogg" ;;
    flac) echo "audio/flac" ;;
    *) echo "application/octet-stream" ;;
  esac
}

CONTENT_TYPE=$(get_content_type "$FILE_PATH")
FILENAME=$(basename "$FILE_PATH")

echo -e "${BLUE}Uploading $FILENAME (${FILE_SIZE} bytes)...${NC}" >&2

# Upload using fal storage API
RESPONSE=$(curl -s -X POST "https://fal.ai/api/storage/upload" \
  -H "Authorization: Key $FAL_KEY" \
  -F "file=@$FILE_PATH;type=$CONTENT_TYPE")

# Extract URL
URL=$(echo "$RESPONSE" | jq -r '.url // empty')

if [ -z "$URL" ]; then
  echo -e "${RED}Error uploading file:${NC}" >&2
  echo "$RESPONSE" | jq >&2
  exit 1
fi

echo -e "${GREEN}Uploaded successfully!${NC}" >&2
echo "$URL"
