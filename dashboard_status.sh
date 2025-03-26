#!/bin/bash

if [ $(docker info 2>&1 | wc -c) -lt 2000 ]; then
  tput setaf 1
  printf "Docker is not running"
  tput sgr0
else printf "    Docker is running"; fi
printf " | "
if curl -s localhost:11434/api/health >/dev/null 2>&1; then printf "Ollama is running"; else
  tput setaf 1
  printf "Ollama is not running"
  tput sgr0
fi
