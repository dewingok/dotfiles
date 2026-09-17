#!/usr/bin/env bash
# $1 = workspace ID this item represents
# $2 = this workspace's accent color
# $FOCUSED_WORKSPACE = set by the aerospace_workspace_change trigger
CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
source "$CONFIG_DIR/colors.sh"

COLOR="${2:-$CATPPUCCIN_TEXT}"
WINDOW_COUNT="$(aerospace list-windows --workspace "$1" --count 2>/dev/null || printf '0')"

if [ "$WINDOW_COUNT" -gt 0 ]; then
    LABEL_COLOR="$CATPPUCCIN_TEXT"
else
    LABEL_COLOR="$CATPPUCCIN_OVERLAY1"
fi

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set "$NAME" \
        background.drawing=on    \
        background.color="$COLOR" \
        label.color="$CATPPUCCIN_BASE"
else
    sketchybar --set "$NAME" \
        background.drawing=off   \
        label.color="$LABEL_COLOR"
fi
