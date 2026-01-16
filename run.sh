#!/bin/bash
GREEN="\e[92m"
RESET="\e[0m"

echo -e "${GREEN}==========================================${RESET}"
echo -e "${GREEN} HackNlearn India - Kali Tools Manager${RESET}"
echo -e "${GREEN}==========================================${RESET}"

mkdir -p logs
echo -e "${GREEN}Started at $(date)${RESET}" > logs/hacknlearn.log

bash core/menu.sh
