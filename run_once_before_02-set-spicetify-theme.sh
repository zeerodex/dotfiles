#!/usr/bin/env bash
set -euo pipefail

echo "=== Applying spicetify theme ==="

if ! command -v spicetify &> /dev/null; then
    echo "spicetify is not installed."
    exit 0
fi

spicetify config current_theme Sleek color_scheme matugen
echo "Spicetify theme set successfully."
