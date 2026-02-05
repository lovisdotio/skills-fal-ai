#!/bin/bash
# fal-poll: Poll queue status until completion
# Usage: ./poll.sh <endpoint> <request_id>

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Help
show_help() {
  cat << EOF
fal-poll: Poll queue status until completion

USAGE:
  ./poll.sh <endpoint> <request_id> [options]

ARGUMENTS:
  endpoint      The model endpoint (e.g., fal-ai/flux-2/klein/9b)
  request_id    The request ID to poll

OPTIONS:
  --interval    Polling interval in seconds (default: 3)
  --timeout     Maximum wait time in seconds (default: 600)
  --status      Only show status, don't wait for completion
  --help, -h    Show this help

EXAMPLES:
  ./poll.sh fal-ai/kling-video/v3/pro/text-to-video abc123-def456
  ./poll.sh fal-ai/flux-2/klein/9b abc123-def456 --interval 5
  ./poll.sh fal-ai/hunyuan-3d/v3.1/pro/text-to-3d abc123 --status
EOF
}

# Defaults
INTERVAL=3
TIMEOUT=600
STATUS_ONLY=false
ENDPOINT=""
REQUEST_ID=""

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --interval)
      INTERVAL="$2"
      shift 2
      ;;
    --timeout)
      TIMEOUT="$2"
      shift 2
      ;;
    --status)
      STATUS_ONLY=true
      shift
      ;;
    --help|-h)
      show_help
      exit 0
      ;;
    *)
      if [ -z "$ENDPOINT" ]; then
        ENDPOINT="$1"
      elif [ -z "$REQUEST_ID" ]; then
        REQUEST_ID="$1"
      else
        echo -e "${RED}Unknown argument: $1${NC}"
        show_help
        exit 1
      fi
      shift
      ;;
  esac
done

# Validate
if [ -z "$ENDPOINT" ] || [ -z "$REQUEST_ID" ]; then
  echo -e "${RED}Error: endpoint and request_id are required${NC}"
  show_help
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
  echo -e "${RED}Error: jq is required${NC}"
  exit 1
fi

# Get status
get_status() {
  curl -s "https://queue.fal.run/$ENDPOINT/requests/$REQUEST_ID/status" \
    -H "Authorization: Key $FAL_KEY"
}

# Get result
get_result() {
  curl -s "https://queue.fal.run/$ENDPOINT/requests/$REQUEST_ID" \
    -H "Authorization: Key $FAL_KEY"
}

# Status only mode
if [ "$STATUS_ONLY" = true ]; then
  response=$(get_status)
  status=$(echo "$response" | jq -r '.status')
  queue_pos=$(echo "$response" | jq -r '.queue_position // "N/A"')

  echo -e "${BLUE}Status: ${NC}$status"
  if [ "$status" = "IN_QUEUE" ]; then
    echo -e "${BLUE}Queue Position: ${NC}$queue_pos"
  fi
  exit 0
fi

# Poll until completion
START_TIME=$(date +%s)

echo -e "${BLUE}Polling $ENDPOINT for request $REQUEST_ID${NC}"
echo -e "${BLUE}Timeout: ${TIMEOUT}s, Interval: ${INTERVAL}s${NC}"

while true; do
  CURRENT_TIME=$(date +%s)
  ELAPSED=$((CURRENT_TIME - START_TIME))

  if [ $ELAPSED -gt $TIMEOUT ]; then
    echo -e "${RED}Timeout after ${TIMEOUT}s${NC}"
    exit 1
  fi

  response=$(get_status)
  status=$(echo "$response" | jq -r '.status')

  case "$status" in
    "COMPLETED")
      echo -e "${GREEN}Completed after ${ELAPSED}s${NC}"
      get_result | jq
      exit 0
      ;;
    "FAILED")
      echo -e "${RED}Failed after ${ELAPSED}s${NC}"
      get_result | jq
      exit 1
      ;;
    "IN_QUEUE")
      queue_pos=$(echo "$response" | jq -r '.queue_position // "?"')
      echo -e "${YELLOW}[$ELAPSED s] In queue (position: $queue_pos)${NC}"
      ;;
    "IN_PROGRESS")
      logs=$(echo "$response" | jq -r '.logs[-1].message // empty')
      if [ -n "$logs" ]; then
        echo -e "${BLUE}[$ELAPSED s] Processing: $logs${NC}"
      else
        echo -e "${BLUE}[$ELAPSED s] Processing...${NC}"
      fi
      ;;
    *)
      echo -e "${YELLOW}[$ELAPSED s] Status: $status${NC}"
      ;;
  esac

  sleep $INTERVAL
done
