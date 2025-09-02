#!/bin/bash

if curl -s --unix-socket /var/run/docker.sock http/_ping 2>&1 >/dev/null; then
  printf "     Docker"
else
  tput setaf 1
  printf "     Docker"
  tput sgr0
fi

printf " | "
response=$(curl -s --max-time 5 -H "Authorization: Bearer $OPENROUTER_API_KEY" https://openrouter.ai/api/v1/credits 2>/dev/null)
credits=$(echo "$response" | jq -r '.data.total_credits')
usage=$(echo "$response" | jq -r '.data.total_usage')
if [ "$credits" != "null" ] && [ "$usage" != "null" ]; then
  remaining=$(echo "$credits - $usage" | bc -l)
  printf "OpenRouter ($%.2f)" "$remaining"
else
  tput setaf 1
  printf "OpenRouter"
  tput sgr0
fi
printf " | "
response=$(curl -s --max-time 5 http://localhost:1234/v1/models 2>/dev/null)
if echo "$response" | grep -q '"object": "list"'; then
  printf "LM Studio"
else
  tput setaf 1
  printf "LM Studio"
  tput sgr0
fi
