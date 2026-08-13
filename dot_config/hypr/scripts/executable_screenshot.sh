#!/usr/bin/env bash

hyprctl dispatch 'hl.dsp.submap("reset")'

SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"
FILE="$SAVE_DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

case "$1" in
    full)
        grim -o "$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')" - | tee "$FILE" | wl-copy
        notify-send "Screenshot" "Full screen saved and copied"
        ;;
    full-copy)
        grim -o "$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')" - | wl-copy
        notify-send "Screenshot" "Full screen copied to clipboard"
        ;;
    full-satty)
        grim -o "$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')" - | satty --fullscreen --filename - --output-filename "$FILE"
        ;;
    area)
        grim -g "$(slurp -d)" - | tee "$FILE" | wl-copy
        notify-send "Screenshot" "Area saved and copied"
        ;;
    area-copy)
        grim -g "$(slurp -d)" - | wl-copy
        ;;
    area-satty)
        grim -g "$(slurp -d)" - | satty --filename - --output-filename "$FILE"
        ;;
    window)
        GEOM=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
        grim -g "$GEOM" - | tee "$FILE" | wl-copy
        notify-send "Screenshot" "Window saved and copied"
        ;;
    window-copy)
        GEOM=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
        grim -g "$GEOM" - | wl-copy
        notify-send "Screenshot" "Window copied to clipboard"
        ;;
    window-satty)
        GEOM=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
        grim -g "$GEOM" - | satty --filename - --output-filename "$FILE"
        [ -f "$FILE" ] && wl-copy < "$FILE"
        ;;
    last-satty)
        LAST_FILE=$(ls -t "$SAVE_DIR"/*.png 2>/dev/null | head -n 1)
        if [ -n "$LAST_FILE" ]; then
            satty --fullscreen --filename "$LAST_FILE" --output-filename "$LAST_FILE"
            [ -f "$LAST_FILE" ] && wl-copy < "$LAST_FILE"
        else
            notify-send "Screenshot" "No screenshots found."
        fi
        ;;
    clip-satty)
        if wl-paste -l | grep -q "^image/"; then
            wl-paste -t image/png | satty --filename - --output-filename "$FILE"
        else
            notify-send "Screenshot" "No image found in clipboard."
        fi
        ;;
    *)
        echo "Usage: $0 {full|full-save|full-satty|area|area-copy|area-satty|window|window-copy|window-satty|last-satty}"
        exit 1
        ;;
esac
