#!/bin/bash
GREEN="\e[92m"
RESET="\e[0m"

while true
do
  clear
  echo -e "${GREEN}======================================${RESET}"
  echo -e "${GREEN} Custom GitHub Tools${RESET}"
  echo -e "${GREEN}======================================${RESET}"
  echo -e "${GREEN}1. CamPhish${RESET}"
  echo -e "${GREEN}2. HackNlearn-Kali-AutoSec${RESET}"
  echo -e "${GREEN}0. Back${RESET}"
  echo -e "${GREEN}9. Exit${RESET}"

  read -p "$(echo -e ${GREEN}Select option:${RESET} )" ch

  case $ch in
    1)
      [ -d "$HOME/CamPhish" ] && cd "$HOME/CamPhish" && bash camphish.sh
      ;;
    2)
      [ -d "$HOME/HackNlearn-Kali-AutoSec" ] && cd "$HOME/HackNlearn-Kali-AutoSec" && bash run.sh
      ;;
    0) break ;;
    9) exit 0 ;;
    *) echo -e "${GREEN}Invalid option${RESET}" ;;
  esac

  read -p "$(echo -e ${GREEN}Press ENTER to continue...${RESET})" temp
done
