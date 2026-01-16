#!/bin/bash
GREEN="\e[92m"
RESET="\e[0m"

echo -e "${GREEN}======================================${RESET}"
echo -e "${GREEN} Update / Install Kali Tools${RESET}"
echo -e "${GREEN}======================================${RESET}"
echo -e "${GREEN}1. Update system tools${RESET}"
echo -e "${GREEN}2. Install a new tool${RESET}"
echo -e "${GREEN}0. Back${RESET}"

read -p "$(echo -e ${GREEN}Enter choice:${RESET} )" ch

case $ch in
  1)
    sudo apt update && sudo apt upgrade -y
    ;;
  2)
    read -p "$(echo -e ${GREEN}Enter tool/package name:${RESET} )" pkg
    sudo apt install "$pkg" -y
    ;;
  0)
    exit 0
    ;;
  *)
    echo -e "${GREEN}Invalid option${RESET}"
    ;;
esac
