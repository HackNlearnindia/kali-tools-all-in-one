#!/bin/bash

echo "[*] Scanning all installed Kali Linux tools..."

TOOLS=$(ls /usr/bin)

for tool in $TOOLS
do
  if $tool --help &>/dev/null; then
    echo "[FOUND] $tool"
  fi
done
