#!/bin/bash

if [ $(docker info 2>&1 | wc -c) -lt 2000 ]; then
  tput setaf 1
  printf "     Docker"
  tput sgr0
else printf "     Docker"; fi
printf " | "
if curl -s --max-time 5 -H "Authorization: Bearer $OPENROUTER_API_KEY" https://openrouter.ai/api/v1/credits 2>/dev/null | grep -q '"total_credits"'; then printf "OpenRouter"; else
  tput setaf 1
  printf "OpenRouter"
  tput sgr0
fi
printf " | "
if [ $(curl -s https://api.openai.com/v1/models -H "Authorization: Bearer $OPENAI_API_KEY" 2>/dev/null | wc -c) -gt 4000 ]; then printf "OpenAI API"; else
  tput setaf 1
  printf "OpenAI API"
  tput sgr0
fi
