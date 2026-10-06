#!/usr/bin/env bash

hyprctl dispatch 'hl.dsp.submap("reset")' >/dev/null 2>&1

notify() {
    notify-send -a "OCR Tool" "$1" "$2"
}

case "$1" in
    eng)
        LANG="eng"
        LABEL="English"
        ;;
    ukr)
        LANG="ukr"
        LABEL="Ukrainian"
        ;;
    rus)
        LANG="rus"
        LABEL="Russian"
        ;;
    all|eng+ukr+rus|*)
        LANG="eng+ukr+rus"
        LABEL="Eng+Ukr+Rus"
        ;;
esac

AREA=$(slurp -d) || exit 1
TEXT=$(grim -g "$AREA" - | tesseract - - -l "$LANG" 2>/dev/null)

if [ -n "$TEXT" ]; then
    printf '%s' "$TEXT" | wl-copy
    notify "OCR ($LABEL)" "Recognized text copied to clipboard"
else
    notify "OCR ($LABEL)" "No text recognized"
fi
