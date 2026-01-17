run_tool_auto () {
  TOOL_PATH="$1"
  cd "$TOOL_PATH" || return

  echo -e "${GREEN}Running tool from: $TOOL_PATH${RESET}"

  # ===============================
  # PYTHON TOOLS (FIXED)
  # ===============================
  if ls *.py &>/dev/null; then

    # Create venv safely
    if [ ! -d ".venv" ]; then
      echo -e "${GREEN}Creating Python virtual environment...${RESET}"
      python3 -m venv .venv || {
        echo -e "${GREEN}Failed to create virtual environment${RESET}"
        return
      }
    fi

    # Activate venv safely
    if [ -f ".venv/bin/activate" ]; then
      source .venv/bin/activate
    else
      echo -e "${GREEN}Virtual environment activation failed${RESET}"
      return
    fi

    # Install dependencies once
    if [ ! -f ".deps_installed" ]; then
      if [ -f "requirements.txt" ]; then
        echo -e "${GREEN}Installing requirements.txt...${RESET}"
        pip install -r requirements.txt
      else
        echo -e "${GREEN}Installing dependency: flask${RESET}"
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

    # Deactivate safely
    deactivate 2>/dev/null
    return
  fi

  # ===============================
  # NODEJS TOOLS
  # ===============================
  if [ -f "package.json" ]; then
    [ ! -d "node_modules" ] && npm install
    npm start
    return
  fi

  # ===============================
  # SHELL TOOLS
  # ===============================
  shfiles=(*.sh)
  if [ -f "${shfiles[0]}" ]; then
    bash "${shfiles[0]}"
    return
  fi

  # ===============================
  # FALLBACK
  # ===============================
  if [ -f "README.md" ]; then
    less README.md
  else
    echo -e "${GREEN}No runnable file detected.${RESET}"
  fi
}
