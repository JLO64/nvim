#!/bin/bash

# Get the JSON data from npx ccusage blocks --json
json_output=$(npx ccusage blocks --json 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$json_output" ]; then
  printf "Claude Usage | Error fetching data"
  exit 1
fi

# Parse the active block data using jq
active_block=$(echo "$json_output" | jq -r '.blocks[] | select(.isActive == true)')

if [ -z "$active_block" ]; then
  printf "           Claude Usage | No active session"
  exit 0
fi

# Extract values from the active block
total_tokens=$(echo "$active_block" | jq -r '.totalTokens')
remaining_minutes=$(echo "$active_block" | jq -r '.projection.remainingMinutes // 0')
end_time=$(echo "$active_block" | jq -r '.endTime')
# projected_total=$(echo "$active_block" | jq -r '.projection.totalTokens // 0')

# Format tokens in K format
format_tokens() {
  local tokens=$1
  if [ "$tokens" -ge 1000000 ]; then
    echo "$(echo "scale=1; $tokens / 1000000" | bc)M"
  elif [ "$tokens" -ge 1000 ]; then
    echo "$(echo "scale=0; $tokens / 1000" | bc)K"
  else
    echo "$tokens"
  fi
}

current_tokens_formatted=$(format_tokens $total_tokens)

# Calculate end time by adding remaining minutes to current time
current_epoch=$(date +%s)
end_epoch=$((current_epoch + remaining_minutes * 60))
formatted_time=$(date -r "$end_epoch" "+%-I %p")

# Output the formatted line
printf "Claude Usage | Tokens: %s/%s | Time: %d Minutes (%s)" \
  "$current_tokens_formatted" \
  "6M" \
  "$remaining_minutes" \
  "$formatted_time"
