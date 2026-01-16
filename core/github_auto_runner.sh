#!/bin/bash

echo "[*] Loading educational GitHub repositories..."

mkdir -p github-labs
cd github-labs || exit

git clone https://github.com/digininja/DVWA
git clone https://github.com/OWASP/WebGoat
git clone https://github.com/vulhub/vulhub

echo "Read README of each repo before use."
