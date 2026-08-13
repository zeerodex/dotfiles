#!/usr/bin/env bash

hyprctl dispatch 'hl.dsp.submap("reset")'

case "$1" in
    eng)
        grim -g "$(slurp -d)" - | tesseract - - -l eng | wl-copy
        ;;
    ukr)
        grim -g "$(slurp -d)" - | tesseract - - -l ukr | wl-copy
        ;;
    rus)
        grim -g "$(slurp -d)" - | tesseract - - -l rus | wl-copy
        ;;
    *)
        grim -g "$(slurp -d)" - | tesseract - - -l eng+rus+ukr | wl-copy
        ;;
esac
