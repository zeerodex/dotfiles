#!/usr/bin/env bash

# Dependencies: slurp, grim, zbar, wl-clipboard, libnotify

hyprctl dispatch 'hl.dsp.submap("reset")' >/dev/null 2>&1

AREA=$(slurp -d) || exit 0

RESULT=$(grim -g "$AREA" - | zbarimg --raw -q - 2>/dev/null)

if [ -n "$RESULT" ]; then
    printf '%s' "$RESULT" | wl-copy
    notify-send "QR Scan" "$RESULT"
else
    notify-send "QR Scan" "No QR code found"
fi
