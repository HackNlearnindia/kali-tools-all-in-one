#!/bin/bash

echo "[*] Scanning installed Kali Linux tools..."

for tool in $(ls /usr/bin | sort)
do
  if command -v "$tool" &>/dev/null; then
    echo "[FOUND] $tool"
  fi
done
