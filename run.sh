#!/bin/bash

echo "=========================================="
echo " HackNlearn India - Kali Tools All In One "
echo "=========================================="

mkdir -p logs
LOGFILE="logs/hacknlearn.log"
echo "Started at $(date)" > $LOGFILE

bash core/scan_all_tools.sh | tee -a $LOGFILE
bash core/chrome_runner.sh
bash core/error_autofix.sh
bash core/github_auto_runner.sh

echo "Completed Successfully"
