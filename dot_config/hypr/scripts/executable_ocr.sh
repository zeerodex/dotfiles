#!/usr/bin/env bash

# Dependencies: slurp, grim, tesseract, wl-clipboard, libnotify
# Language packs: tesseract-data-eng, tesseract-data-ukr, tesseract-data-rus

hyprctl dispatch 'hl.dsp.submap("reset")' >/dev/null 2>&1

case "$1" in
    eng) LANG="eng"; LABEL="English" ;;
    ukr) LANG="ukr"; LABEL="Ukrainian" ;;
    rus) LANG="rus"; LABEL="Russian" ;;
    *)   LANG="eng+ukr+rus"; LABEL="Eng+Ukr+Rus" ;;
esac

AREA=$(slurp -d) || exit 0

TEXT=$(grim -g "$AREA" - | tesseract - - -l "$LANG" 2>/dev/null)

if [ -n "$TEXT" ]; then
    printf '%s' "$TEXT" | wl-copy
    notify-send "OCR ($LABEL)" "$TEXT"
else
    notify-send "OCR ($LABEL)" "No text recognized"
fi
