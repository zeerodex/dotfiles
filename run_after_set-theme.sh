#!/usr/bin/env bash
set -euo pipefail

echo "=== Applying matugen theme ==="

if ! command -v matugen &> /dev/null; then
    echo "Matugen is not installed."
    exit 0
fi

WALLPAPER=~/.config/wallpaper

if [ -n "$WALLPAPER" ] && [ -f "$WALLPAPER" ]; then
    matugen image "$WALLPAPER"
    echo "Theme applied from: $WALLPAPER"
else
    echo "Wallpaper file not found or empty path"
fi
