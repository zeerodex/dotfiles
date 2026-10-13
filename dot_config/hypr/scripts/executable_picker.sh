#!/usr/bin/env bash

# Dependencies: hyprpicker, wl-clipboard, libnotify

hyprctl dispatch 'hl.dsp.submap("reset")' >/dev/null 2>&1

COLOR=$(hyprpicker -a -f hex) || exit 0

notify-send "Color Picker" "Copied: $COLOR"
