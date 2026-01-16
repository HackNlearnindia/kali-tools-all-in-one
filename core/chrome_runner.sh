#!/bin/bash

echo "[*] Opening Kali tools documentation in Chrome..."

for tool in $(ls /usr/bin)
do
  google-chrome "https://www.kali.org/tools/$tool/" &>/dev/null &
done
