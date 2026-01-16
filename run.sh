#!/bin/bash

echo "=========================================="
echo " HackNlearn India - Kali Tools All In One "
echo "=========================================="

mkdir -p logs
echo "Started at $(date)" > logs/hacknlearn.log

bash core/menu.sh
