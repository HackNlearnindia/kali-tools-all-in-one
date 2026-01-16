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
  echo "4. Exit"
  echo ""
  read -p "Enter your choice (1-4): " choice

  case $choice in
    1)
      echo "[*] Scanning Kali Linux tools..."
      bash core/scan_all_tools.sh
      ;;
    2)
      echo "[*] Opening Chrome documentation..."
      bash core/chrome_runner.sh
      ;;
    3)
      echo "[*] Running GitHub labs..."
      bash core/github_auto_runner.sh
      ;;
    4)
      echo "Exiting... Thank you for using HackNlearn India"
      exit 0
      ;;
    *)
      echo "Invalid choice! Please select 1-4"
      ;;
  esac
done
