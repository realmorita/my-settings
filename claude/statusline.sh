# TODO: chmod +x ~/.claude/statusline.sh でスクリプトに実行権限を付与する

#!/usr/bin/env bash

# Read JSON input from stdin
input=$(cat)

MODEL_DISPLAY=$(echo "$input" | jq -r '.model.display_name')
CURRENT_DIR=$(echo "$input" | jq -r '.workspace.current_dir')
TRANSCRIPT_PATH=$(echo "$input" | jq -r '.transcript_path')
INPUT_TOKENS=$(echo "$input" | jq -r '.context_window.total_input_tokens // "0"')
OUTPUT_TOKENS=$(echo "$input" | jq -r '.context_window.total_output_tokens // "0"')
USED=$(echo "$input" | jq -r '.context_window.used_percentage // "0"')
DURATION_MS=$(echo "$input" | jq -r '.cost.total_api_duration_ms // "0"')

# レイテンシを秒に変換（小数点1桁）
LATENCY=$(echo "scale=1; $DURATION_MS / 1000" | bc)

# Get git branch information
GIT_BRANCH=""
if git rev-parse &>/dev/null; then
  BRANCH=$(git branch --show-current)
  if [ -n "$BRANCH" ]; then
    GIT_BRANCH=" | $BRANCH"
  else
    COMMIT_HASH=$(git rev-parse --short HEAD 2>/dev/null)
    if [ -n "$COMMIT_HASH" ]; then
      GIT_BRANCH=" | HEAD ($COMMIT_HASH)"
    fi
  fi
fi

echo "${MODEL_DISPLAY} | ${CURRENT_DIR##*/}${GIT_BRANCH} | ${INPUT_TOKENS}/${OUTPUT_TOKENS} tokens | Context: ${USED}% used | ${LATENCY}s"
