#!/bin/bash
GREEN="\e[92m"
RESET="\e[0m"

echo -e "${GREEN}======================================${RESET}"
echo -e "${GREEN} Scanning System + Installed Tools${RESET}"
echo -e "${GREEN}======================================${RESET}"

echo -e "${GREEN}[SYSTEM COMMANDS]${RESET}"
for t in $(ls /usr/bin | sort)
do
  command -v "$t" &>/dev/null && echo -e "${GREEN}[FOUND] $t${RESET}"
done

echo ""
echo -e "${GREEN}[CUSTOM / USER TOOLS]${RESET}"
for d in "$HOME"/*
do
  [ -d "$d" ] && echo -e "${GREEN}[DIR] $(basename "$d")${RESET}"
done
