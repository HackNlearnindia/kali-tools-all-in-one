#!/bin/bash
GREEN="\e[92m"
RESET="\e[0m"

TOOLS=()

# ======================================
# COLLECT ALL TOOL FOLDERS
# ======================================
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

# ======================================
# SINGLE INSTALL + SINGLE LAUNCH (COMBINED)
# ======================================
run_tool_auto () {
  TOOL_PATH="$1"
  cd "$TOOL_PATH" || return

  echo -e "${GREEN}Running tool from: $TOOL_PATH${RESET}"

  # ==================================
  # PYTHON TOOLS (SAFE + SINGLE INSTALL)
  # ==================================
  if ls *.py &>/dev/null; then

    # Create virtual environment only once
    if [ ! -d ".venv" ]; then
      echo -e "${GREEN}First time Python setup detected${RESET}"
      python3 -m venv .venv
    fi

    source .venv/bin/activate

    # Install dependencies only once
    if [ ! -f ".deps_installed" ]; then
      if [ -f "requirements.txt" ]; then
        echo -e "${GREEN}Installing requirements.txt...${RESET}"
        pip install -r requirements.txt
      else
        echo -e "${GREEN}Installing common dependency (flask)...${RESET}"
        pip install flask
      fi
      touch .deps_installed
    fi

    # Ignore __init__.py
    pyfiles=($(ls *.py | grep -v "__init__.py"))

    if [ ${#pyfiles[@]} -gt 1 ]; then
      echo -e "${GREEN}Select Python file to run:${RESET}"
      select f in "${pyfiles[@]}"; do
        python3 "$f"
        break
      done
    else
      python3 "${pyfiles[0]}"
    fi

    deactivate
    return
  fi

  # ==================================
  # NODEJS TOOLS (SINGLE INSTALL)
  # ==================================
  if [ -f "package.json" ]; then
    if [ ! -d "node_modules" ]; then
      echo -e "${GREEN}First time NodeJS setup detected${RESET}"
      npm install
    fi
    npm start
    return
  fi

  # ==================================
  # SHELL TOOLS
  # ==================================
  shfiles=(*.sh)
  if [ -f "${shfiles[0]}" ]; then
    if [ "${#shfiles[@]}" -gt 1 ]; then
      echo -e "${GREEN}Select shell script to run:${RESET}"
      select f in "${shfiles[@]}"; do
        bash "$f"
        break
      done
    else
      bash "${shfiles[0]}"
    fi
    return
  fi

  # ==================================
  # FALLBACK
  # ==================================
  if [ -f "README.md" ]; then
    echo -e "${GREEN}No auto-run file found. Showing README:${RESET}"
    less README.md
  else
    echo -e "${GREEN}No runnable file detected.${RESET}"
  fi
}

# ======================================
# MENU
# ======================================
TOTAL=${#TOOLS[@]}

while true
do
  clear
  echo -e "${GREEN}======================================${RESET}"
  echo -e "${GREEN} Custom Tools (Single Install + Launch)${RESET}"
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
