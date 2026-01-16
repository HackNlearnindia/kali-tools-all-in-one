#!/bin/bash

TOOLS=($(ls /usr/bin | sort))
TOTAL=${#TOOLS[@]}

while true
do
  clear
  echo "======================================"
  echo " HackNlearn India - Tool Launcher"
  echo " Total Tools: $TOTAL"
  echo "======================================"

  i=1
  for t in "${TOOLS[@]}"
  do
    printf "%3d. %s\n" "$i" "$t"
    i=$((i+1))
  done

  echo ""
  echo "0. Back"
  echo "999. Exit"

  read -p "Select tool number: " n

  [[ "$n" == "0" ]] && break
  [[ "$n" == "999" ]] && exit 0

  index=$((n-1))
  tool=${TOOLS[$index]}

  echo "1. Help"
  echo "2. Run tool"
  read -p "Choose option: " op

  case $op in
    1) $tool -h | less ;;
    2)
       read -p "Enter arguments: " args
       $tool $args ;;
  esac

  read -p "Press ENTER to continue..." temp
done
