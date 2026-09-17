#!/usr/bin/env bash
# $1 = workspace ID this item represents
# $2 = this workspace's accent color
# $FOCUSED_WORKSPACE = set by the aerospace_workspace_change trigger
CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
source "$CONFIG_DIR/colors.sh"

COLOR="${2:-$CATPPUCCIN_TEXT}"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set "$NAME" \
        background.drawing=on    \
        background.color="$COLOR" \
        label.color="$CATPPUCCIN_BASE"
else
    sketchybar --set "$NAME" \
        background.drawing=off   \
        label.color="$COLOR"
fi
