#!/usr/bin/env bash
# Show CPU usage percentage with color-coded Nerd Font icon.
CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
source "$CONFIG_DIR/colors.sh"

CPU=$(top -l 1 -n 0 | awk '/CPU usage/ {gsub(/%/,""); print int($3 + $5)}')

if [ "$CPU" -ge 80 ]; then
    COLOR="$CATPPUCCIN_RED"    # red
elif [ "$CPU" -ge 50 ]; then
    COLOR="$CATPPUCCIN_YELLOW" # yellow
else
    COLOR="$CATPPUCCIN_GREEN"  # green
fi

sketchybar --set "$NAME" icon.color="$COLOR" label="${CPU}%"
