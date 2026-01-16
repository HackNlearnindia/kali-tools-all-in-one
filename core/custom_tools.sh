#!/bin/bash
GREEN="\e[92m"
RESET="\e[0m"

TOOLS=()

collect_folders () {
  for d in "$1"/*
  do
    [ -d "$d" ] || continue
    name=$(basename "$d")
    [[ "$name" == "kali-tools-all-in-one" ]] && continue
    TOOLS+=("$d")
  done
}

collect_folders "$HOME"
collect_folders "/opt"

TOTAL=${#TOOLS[@]}

while true
do
  clear
  echo -e "${GREEN}======================================${RESET}"
  echo -e "${GREEN} Custom Tools (Smart Auto Runner)${RESET}"
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

  cd "$TOOL_PATH" || continue
  echo -e "${GREEN}Running tool from: $TOOL_PATH${RESET}"

  # 1️⃣ Shell scripts
  shfile=$(ls *.sh 2>/dev/null | head -n 1)
  if [ -n "$shfile" ]; then
    bash "$shfile"
    read -p "$(echo -e ${GREEN}Press ENTER to continue...${RESET})" tmp
    continue
  fi

  # 2️⃣ Python tools
  pyfile=$(ls *.py 2>/dev/null | head -n 1)
  if [ -n "$pyfile" ]; then
    python3 "$pyfile"
    read -p "$(echo -e ${GREEN}Press ENTER to continue...${RESET})" tmp
    continue
  fi

  # 3️⃣ NodeJS tools
  if [ -f "package.json" ]; then
    npm start
    read -p "$(echo -e ${GREEN}Press ENTER to continue...${RESET})" tmp
    continue
  fi

  # 4️⃣ README fallback
  if [ -f "README.md" ]; then
    echo -e "${GREEN}No auto-run file found.${RESET}"
    echo -e "${GREEN}Showing README instructions:${RESET}"
    less README.md
  else
    echo -e "${GREEN}No runnable file detected.${RESET}"
  fi

  read -p "$(echo -e ${GREEN}Press ENTER to continue...${RESET})" tmp
done
