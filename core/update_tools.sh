#!/bin/bash
GREEN="\e[92m"
RESET="\e[0m"

echo -e "${GREEN}======================================${RESET}"
echo -e "${GREEN} Update / Install Kali Tools${RESET}"
echo -e "${GREEN}======================================${RESET}"
echo -e "${GREEN}1. Update system tools${RESET}"
echo -e "${GREEN}2. Install a new tool (APT / GitHub)${RESET}"
echo -e "${GREEN}0. Back${RESET}"
echo ""

read -p "$(echo -e ${GREEN}Enter choice:${RESET} )" ch

case $ch in
  1)
    echo -e "${GREEN}Updating system tools...${RESET}"
    sudo apt update && sudo apt upgrade -y
    ;;
  2)
    echo -e "${GREEN}Enter tool name (apt) OR GitHub URL:${RESET}"
    read -p "> " input

    # Check if input is GitHub URL
    if [[ "$input" == https://github.com/* ]]; then
      TOOL_NAME=$(basename "$input" .git)
      INSTALL_DIR="$HOME/$TOOL_NAME"

      if [ -d "$INSTALL_DIR" ]; then
        echo -e "${GREEN}Tool already exists: $INSTALL_DIR${RESET}"
      else
        echo -e "${GREEN}Cloning GitHub repository...${RESET}"
        git clone "$input" "$INSTALL_DIR"

        if [ $? -eq 0 ]; then
          echo -e "${GREEN}Tool installed successfully in $INSTALL_DIR${RESET}"
        else
          echo -e "${GREEN}GitHub clone failed${RESET}"
        fi
      fi
    else
      echo -e "${GREEN}Installing package using apt...${RESET}"
      sudo apt install "$input" -y
    fi
    ;;
  0)
    break
    ;;
  *)
    echo -e "${GREEN}Invalid option${RESET}"
    ;;
esac

read -p "$(echo -e ${GREEN}Press ENTER to continue...${RESET})" temp
