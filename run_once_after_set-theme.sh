#!/usr/bin/env bash
set -euo pipefail

echo "=== Applying matugen theme ==="

if ! command -v matugen &> /dev/null; then
    echo "Matugen is not installed."
    exit 0
fi

read -rep "Wallpaper file path: " WALLPAPER

WALLPAPER="${WALLPAPER/#\~/$HOME}"

if [ -n "$WALLPAPER" ] && [ -f "$WALLPAPER" ]; then
    matugen image "$WALLPAPER"
    echo "Theme applied from: $WALLPAPER"
else
    echo "File not found or empty path. Generating default color scheme..."
    DEFAULT_COLOR="#ffbf9b"
    matugen color hex "$DEFAULT_COLOR"
    echo "Default theme applied ($DEFAULT_COLOR)."
fi
