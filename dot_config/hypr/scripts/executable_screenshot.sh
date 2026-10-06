#!/usr/bin/env bash

hyprctl dispatch 'hl.dsp.submap("reset")' >/dev/null 2>&1

SAVE_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SAVE_DIR"
FILE="$SAVE_DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"

notify() {
    notify-send -a "Screenshot Tool" "$1" "$2"
}

get_focused_monitor() {
    hyprctl monitors -j | jq -r '.[] | select(.focused) | .name'
}

get_active_window() {
    hyprctl activewindow -j | jq -r 'if .at then "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])" else "" end'
}

case "$1" in
    full)
        grim -o "$(get_focused_monitor)" - | tee "$FILE" | wl-copy
        notify "Screenshot" "Full screen saved and copied"
        ;;
    full-copy)
        grim -o "$(get_focused_monitor)" - | wl-copy
        notify "Screenshot" "Full screen copied to clipboard"
        ;;
    full-satty)
        grim -o "$(get_focused_monitor)" - | satty --fullscreen --filename - --output-filename "$FILE"
        [ -f "$FILE" ] && { wl-copy < "$FILE"; notify "Screenshot" "Edited image saved and copied"; }
        ;;
    area)
        AREA=$(slurp -d) || exit 1
        grim -g "$AREA" - | tee "$FILE" | wl-copy
        notify "Screenshot" "Area saved and copied"
        ;;
    area-copy)
        AREA=$(slurp -d) || exit 1
        grim -g "$AREA" - | wl-copy
        notify "Screenshot" "Area copied to clipboard"
        ;;
    area-satty)
        AREA=$(slurp -d) || exit 1
        grim -g "$AREA" - | satty --filename - --output-filename "$FILE"
        [ -f "$FILE" ] && { wl-copy < "$FILE"; notify "Screenshot" "Edited area saved and copied"; }
        ;;
    window)
        GEOM=$(get_active_window)
        [ -z "$GEOM" ] && { notify "Screenshot" "No active window found."; exit 1; }
        grim -g "$GEOM" - | tee "$FILE" | wl-copy
        notify "Screenshot" "Window saved and copied"
        ;;
    window-copy)
        GEOM=$(get_active_window)
        [ -z "$GEOM" ] && { notify "Screenshot" "No active window found."; exit 1; }
        grim -g "$GEOM" - | wl-copy
        notify "Screenshot" "Window copied to clipboard"
        ;;
    window-satty)
        GEOM=$(get_active_window)
        [ -z "$GEOM" ] && { notify "Screenshot" "No active window found."; exit 1; }
        grim -g "$GEOM" - | satty --filename - --output-filename "$FILE"
        [ -f "$FILE" ] && { wl-copy < "$FILE"; notify "Screenshot" "Edited window saved and copied"; }
        ;;
    last-satty)
        LAST_FILE=$(ls -t "$SAVE_DIR"/*.png 2>/dev/null | head -n 1)
        if [ -n "$LAST_FILE" ]; then
            satty --fullscreen --filename "$LAST_FILE" --output-filename "$FILE"
            [ -f "$FILE" ] && { wl-copy < "$FILE"; notify "Screenshot" "Edited last screenshot saved and copied"; }
        else
            notify "Screenshot" "No screenshots found."
        fi
        ;;
    clip-satty)
        if wl-paste -l | grep -q "^image/"; then
            wl-paste -t image/png | satty --filename - --output-filename "$FILE"
            [ -f "$FILE" ] && { wl-copy < "$FILE"; notify "Screenshot" "Edited clipboard image saved and copied"; }
        else
            notify "Screenshot" "No image found in clipboard."
        fi
        ;;
    qr)
        if ! command -v zbarimg &>/dev/null; then
            notify "QR Scan" "zbarimg not found. Install 'zbar' package."
            exit 1
        fi
        AREA=$(slurp -d) || exit 1
        TMP_QR=$(mktemp --suffix=.png)
        grim -g "$AREA" "$TMP_QR"
        RESULT=$(zbarimg --raw -q "$TMP_QR" 2>/dev/null | head -n 1)
        rm -f "$TMP_QR"

        if [ -n "$RESULT" ]; then
            printf '%s' "$RESULT" | wl-copy
            notify "QR Scan" "Copied: $RESULT"
        else
            notify "QR Scan" "No QR code found."
        fi
        ;;
    pick)
        if ! command -v hyprpicker &>/dev/null; then
            notify "Color Picker" "hyprpicker not found. Install 'hyprpicker' package."
            exit 1
        fi
        COLOR=$(hyprpicker -a -f hex)
        if [ -n "$COLOR" ]; then
            notify "Color Picker" "Copied: $COLOR"
        else
            notify "Color Picker" "No color picked."
        fi
        ;;
    *)
        echo "Usage: $0 {full|full-copy|full-satty|area|area-copy|area-satty|window|window-copy|window-satty|last-satty|clip-satty|qr|lens|lens-full|pick}"
        exit 1
        ;;
esac
