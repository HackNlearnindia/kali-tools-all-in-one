#!/bin/bash

echo "[*] Checking errors and auto-fix suggestions..."

grep -i "command not found" logs/hacknlearn.log && \
echo "FIX: sudo apt install <tool-name>"

grep -i "permission denied" logs/hacknlearn.log && \
echo "FIX: Run script with sudo"
