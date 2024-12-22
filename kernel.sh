#!/bin/bash

# Simulate a kernel compilation screensaver with bold text and colors

# Define color codes
BOLD="\e[1m"
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

clear
echo -e "${GREEN}${BOLD}Linux Kernel v.69_420r2429.09142fa3-1${RESET}"
sleep 1

# Define arrays of directories and filenames
directories=("drivers" "fs" "arch" "kernel" "mm" "net" "block" "lib")
subdirs=("char" "audio" "video" "pci" "usb" "scsi" "crypto" "x86" "arm" "mips")
files=("init" "main" "config" "helper" "driver" "module" "interface" "util" "core" "io")
extensions=("c" "h" "S")

# Loop to simulate compilation
while true; do
  # Generate a random file path
  dir1="${directories[RANDOM % ${#directories[@]}]}"
  dir2="${subdirs[RANDOM % ${#subdirs[@]}]}"
  file="${files[RANDOM % ${#files[@]}]}"
  ext="${extensions[RANDOM % ${#extensions[@]}]}"
  filepath="${dir1}/${dir2}/${file}.${ext}"

  # Print simulated compilation steps
  echo -e "${GREEN}${BOLD}  CC      ${RESET}${filepath}"
  sleep 0.75
  echo -e "${BLUE}${BOLD}  LD      ${RESET}$(basename $filepath .${ext}).o"
  sleep 0.75
  echo -e "${YELLOW}${BOLD}  AR      ${RESET}built-in.o"
  sleep 0.75

  # Simulate occasional warnings
  if (( RANDOM % 20 == 0 )); then
    echo -e "${YELLOW}${BOLD}warning:${RESET} unused variable ‘tmp’ [-Wunused-variable]"
    sleep 2
  fi

  if (( RANDOM % 15 == 0 )); then
    echo -e "${YELLOW}${BOLD}Error:${RESET} your mom [W-unused-variable]"
    sleep 2
  fi

  # Simulate occasional errors
  if (( RANDOM % 50 == 0 )); then
    echo -e "${RED}${BOLD}error:${RESET} implicit declaration of function ‘do_something’"
    sleep 2
  fi

  # Simulate build stats
  if (( RANDOM % 30 == 0 )); then
    echo -e "${CYAN}${BOLD}[INFO] Build duration: $((RANDOM % 50)).$((RANDOM % 100))s${RESET}"
    sleep 2
  fi
done
