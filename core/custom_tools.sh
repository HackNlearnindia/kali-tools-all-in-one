#!/bin/bash
GREEN="\e[92m"
RESET="\e[0m"

TOOLS=()

# Function to collect folders
collect_folders() {
  for d in "$1"/*
  do
    if [ -d "$d" ]; then
      name=$(basename "$d")
      # Ignore our own project folder
      if [[ "$name" != "kali-tools-all-in-one" ]]; then
        TOOLS+=("$d")
      fi
    fi
  done
}

# Collect from HOME and other common locations
collect_folders "$HOME"
collect_folders "/opt"
collect_folders "/usr/share"

TOTAL=${#TOOLS[@]}

while true
do
  clear
  echo -e "${GREEN}======================================${RESET}"
  echo -e "${GREEN} Custom Tools (Auto Detect – All Folders)${RESET}"
  echo -e "${GREEN}======================================${RESET}"
  echo -e "${GREEN} Total Tools Found: $TOTAL${RESET}"
  echo ""

  i=1
  for t in "${TOOLS[@]}"
  do
    echo -e "${GREEN}$i. $(basename "$t")${RESET}"
    i=$((i+1))
  done

  echo ""
  echo -e "${GREEN}0. Back${RESET}"
  echo -e "${GREEN}9. Exit${RESET}"
  echo ""

  read -p "$(echo -e ${GREEN}Select option:${RESET} )" ch

  [[ "$ch" == "0" ]] && break
  [[ "$ch" == "9" ]] && exit 0

  index=$((ch-1))
  TOOL_PATH="${TOOLS[$index]}"

  if [ -d "$TOOL_PATH" ]; then
    cd "$TOOL_PATH" || continue

    echo -e "${GREEN}Running tool from: $TOOL_PATH${RESET}"

    if [ -f "run.sh" ]; then
      bash run.sh
    else
      shfile=$(ls *.sh 2>/dev/null | head -n 1)
      if [ -n "$shfile" ]; then
        bash "$shfile"
      else
        echo -e "${GREEN}No runnable .sh file found${RESET}"
      fi
    fi
  else
    echo -e "${GREEN}Invalid selection${RESET}"
  fi

  read -p "$(echo -e ${GREEN}Press ENTER to continue...${RESET})" temp
done
