#!/bin/bash
GREEN="\e[92m"
RESET="\e[0m"

while true
do
  clear
  echo -e "${GREEN}======================================${RESET}"
  echo -e "${GREEN} HackNlearn India - Kali Tools Manager${RESET}"
  echo -e "${GREEN}======================================${RESET}"
  echo -e "${GREEN}1. Scan tools (System + Other Installed)${RESET}"
  echo -e "${GREEN}2. Custom GitHub Tools${RESET}"
  echo -e "${GREEN}3. Use Kali tools (Auto List)${RESET}"
  echo -e "${GREEN}4. Update / Install Kali tools${RESET}"
  echo -e "${GREEN}5. Exit${RESET}"
  echo ""

  read -p "$(echo -e ${GREEN}Enter your choice:${RESET} )" ch

  case $ch in
    1) bash core/scan_all_tools.sh ;;
    2) bash core/custom_tools.sh ;;
    3) bash core/use_tools_menu.sh ;;
    4) bash core/update_tools.sh ;;
    5) exit 0 ;;
    *) echo -e "${GREEN}Invalid choice${RESET}" ;;
  esac

  read -p "$(echo -e ${GREEN}Press ENTER to return to menu...${RESET})" temp
done
