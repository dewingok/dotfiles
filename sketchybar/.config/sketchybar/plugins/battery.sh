#!/usr/bin/env bash
# Show battery percentage with a Nerd Font icon.
CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
source "$CONFIG_DIR/colors.sh"

PERCENTAGE=$(pmset -g batt | grep -Eo '[0-9]+%' | tr -d '%')
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ -z "$PERCENTAGE" ]; then
    sketchybar --set "$NAME" icon="󱉝" label="?"
    exit 0
fi

if [ -n "$CHARGING" ]; then
    ICON="󰂄"                    # charging
    COLOR="$CATPPUCCIN_GREEN"  # green
elif [ "$PERCENTAGE" -ge 80 ]; then
    ICON="󰁹" COLOR="$CATPPUCCIN_TEXT" # full
elif [ "$PERCENTAGE" -ge 60 ]; then
    ICON="󰂁" COLOR="$CATPPUCCIN_TEXT"
elif [ "$PERCENTAGE" -ge 40 ]; then
    ICON="󰁾" COLOR="$CATPPUCCIN_YELLOW" # yellow
elif [ "$PERCENTAGE" -ge 20 ]; then
    ICON="󰁼" COLOR="$CATPPUCCIN_RED" # red-ish
else
    ICON="󰁺" COLOR="$CATPPUCCIN_RED" # critical
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${PERCENTAGE}%"
