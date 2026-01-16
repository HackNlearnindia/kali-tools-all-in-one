#!/bin/bash

while true
do
  echo ""
  echo "======================================"
  echo " HackNlearn India - Kali Tools All In One"
  echo "======================================"
  echo "1. Scan tools"
  echo "2. Open Chrome docs"
  echo "3. Run GitHub labs"
  echo "4. Use Kali tools (Auto List)"
  echo "5. Update Kali tools"
  echo "6. Exit"
  echo ""

  read -p "Enter your choice: " ch

  case $ch in
    1) bash core/scan_all_tools.sh ;;
    2) bash core/chrome_runner.sh ;;
    3) bash core/github_auto_runner.sh ;;
    4) bash core/use_tools_menu.sh ;;
    5) bash core/update_tools.sh ;;
    6) exit 0 ;;
    *) echo "Invalid choice" ;;
  esac

  read -p "Press ENTER to return to menu..." temp
done
