#!/bin/bash


#      __                       __ 
#     / /  _______ ____    ___ / / 
#    / _ \/ __/ _ `/ _ \_ (_-</ _ \
#   /_.__/_/  \_,_/_//_(_)___/_//_/
                                                                                                    
        # Inspired from the tree command, but with system output.                                                                                       

# Function for tree struct
tree_node() {
    local level=$1
    local label=$2
    local value=$3
    local color=$4

    printf "%s├── ${clear}%s${clear}: %b%s${clear}\n" \
        "$(printf "$prefix%.0s" $(seq 1 $level))" "$label" "$color" "$value"
}

# Add Colors
clear="\033[0m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
magenta="\033[35m"
red="\033[31m"

# Grab system info
#
#
# Hostname
hostname=$(hostname)
# Distribution
dist=$(lsb_release -d | cut -f2)
# Package (For now it's only for Debian)
pkg=$(dpkg -l | wc -l)
# Kernel Version
kernel=$(uname -r)
# Fetch CPU 
cpu=$(lscpu | grep "Model name" | awk -F: '{print $2}' | sed 's/^ *//')
# Nouveau Status (Swapped for GPU)
nouveau=$(lsmod | grep nouveau)
if [ -z "$nouveau" ]; then
    nouveau_status="Not loaded"
else
    nouveau_status="Loaded"
fi
# Print Shell
shell=$SHELL
# Memory Usage
mem=$(free -m | grep Mem | awk '{print $3 "MB" "/"$2 "MB"}')
# System uptime
uptime=$(uptime -p)
# Installation Date
install=$(stat / | awk '/Birth: /{print $2}')
# Detect if the user has DE or WM
if [ "$XDG_CURRENT_DESKTOP" ]; then
        DESKTOP_ENVIRONMENT=$XDG_CURRENT_DESKTOP
elif [ "$DESKTOP_SESSION" ]; then
            DESKTOP_ENVIRONMENT=$DESKTOP_SESSION
elif pgrep -x sway >/dev/null; then
            DESKTOP_ENVIRONMENT="SwayWM"
elif pgrep -x i3 >/dev/null; then
            DESKTOP_ENVIRONMENT="i3"
elif pgrep -x gnome-session >/dev/null; then
            DESKTOP_ENVIRONMENT="GNOME"
elif pgrep -x startkde >/dev/null; then
            DESKTOP_ENVIRONMENT="KDE"
elif pgrep -x xfce4-session >/dev/null; then
            DESKTOP_ENVIRONMENT="XFCE"
elif pgrep -x lxsession >/dev/null; then
            DESKTOP_ENVIRONMENT="LXDE/LXQt"
        else
            DESKTOP_ENVIRONMENT="Unknown"
        fi

# Initial Output
echo -e "${red}bran.sh${clear}"
tree_node 0 "Hostname" "$hostname" "$green"
tree_node 0 "Distro" "$dist" "$red"
tree_node 0 "Packages" "$pkg" "$blue"
tree_node 0 "Kernel" "$kernel"	"$magenta"
tree_node 0 "CPU" "$cpu" "$blue"
tree_node 0 "Nouveau Status" "$nouveau_status" "$green"
tree_node 0 "Shell" "$shell" "$yellow"
tree_node 0 "Memory" "$mem" "$magenta"
tree_node 0 "Uptime" "$uptime" "$green"
tree_node 0 "DE" "$DESKTOP_ENVIRONMENT" "$blue"
