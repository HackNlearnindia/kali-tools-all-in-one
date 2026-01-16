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

run_tool_auto () {
  TOOL_PATH="$1"
  cd "$TOOL_PATH" || return

  echo -e "${GREEN}Running tool from: $TOOL_PATH${RESET}"

  # 🔹 Python dependencies
  if [ -f "requirements.txt" ]; then
    echo -e "${GREEN}Installing Python dependencies...${RESET}"
    pip3 install -r requirements.txt
  fi

  # 🔹 NodeJS dependencies
  if [ -f "package.json" ]; then
    echo -e "${GREEN}Installing NodeJS dependencies...${RESET}"
    npm install
    npm start
    return
  fi

  # 🔹 Shell scripts
  shfiles=(*.sh)
  if [ -f "${shfiles[0]}" ]; then
    if [ "${#shfiles[@]}" -gt 1 ]; then
      echo -e "${GREEN}Multiple shell scripts found:${RESET}"
      select f in "${shfiles[@]}"; do
        bash "$f"
        break
      done
    else
      bash "${shfiles[0]}"
    fi
    return
  fi

  # 🔹 Python scripts
  pyfiles=(*.py)
  if [ -f "${pyfiles[0]}" ]; then
    if [ "${#pyfiles[@]}" -gt 1 ]; then
      echo -e "${GREEN}Multiple python files found:${RESET}"
      select f in "${pyfiles[@]}"; do
        python3 "$f"
        break
      done
    else
      python3 "${pyfiles[0]}"
    fi
    return
  fi

  # 🔹 README fallback
  if [ -f "README.md" ]; then
    echo -e "${GREEN}No auto-run file found. Showing README:${RESET}"
    less README.md
  else
    echo -e "${GREEN}No runnable file detected.${RESET}"
  fi
}

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

  run_tool_auto "$TOOL_PATH"
  read -p "$(echo -e ${GREEN}Press ENTER to continue...${RESET})" tmp
done
