#!/bin/bash
GREEN="\e[92m"
RESET="\e[0m"

TOOLS=($(ls /usr/bin | sort))
TOTAL=${#TOOLS[@]}

while true
do
  clear
  echo -e "${GREEN}======================================${RESET}"
  echo -e "${GREEN} Kali Tools Auto Launcher${RESET}"
  echo -e "${GREEN} Total Tools: $TOTAL${RESET}"
  echo -e "${GREEN}======================================${RESET}"

  i=1
  for t in "${TOOLS[@]}"
  do
    printf "${GREEN}%3d. %s${RESET}\n" "$i" "$t"
    i=$((i+1))
  done

  echo ""
  echo -e "${GREEN}0. Back${RESET}"
  echo -e "${GREEN}999. Exit${RESET}"

  read -p "$(echo -e ${GREEN}Select tool number:${RESET} )" n

  [[ "$n" == "0" ]] && break
  [[ "$n" == "999" ]] && exit 0

  index=$((n-1))
  tool=${TOOLS[$index]}

  echo -e "${GREEN}1. Help (-h)${RESET}"
  echo -e "${GREEN}2. Run with arguments${RESET}"
  read -p "$(echo -e ${GREEN}Choose option:${RESET} )" op

  case $op in
    1) $tool -h | less ;;
    2)
       read -p "$(echo -e ${GREEN}Enter arguments:${RESET} )" args
       $tool $args ;;
  esac

  read -p "$(echo -e ${GREEN}Press ENTER to continue...${RESET})" temp
done
