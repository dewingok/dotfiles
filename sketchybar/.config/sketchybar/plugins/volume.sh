#!/usr/bin/env bash
# Show system volume with a Nerd Font speaker icon.
CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
source "$CONFIG_DIR/colors.sh"

VOLUME=$(osascript -e 'output volume of (get volume settings)')
MUTED=$(osascript -e 'output muted of (get volume settings)')

if [ "$MUTED" = "true" ] || [ "$VOLUME" = "0" ]; then
    ICON="󰝟"
    COLOR="$CATPPUCCIN_OVERLAY0"
elif [ "$VOLUME" -lt 34 ]; then
    ICON="󰕿"
    COLOR="$CATPPUCCIN_TEXT"
elif [ "$VOLUME" -lt 67 ]; then
    ICON="󰖀"
    COLOR="$CATPPUCCIN_TEXT"
else
    ICON="󰕾"
    COLOR="$CATPPUCCIN_TEXT"
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${VOLUME}%"
