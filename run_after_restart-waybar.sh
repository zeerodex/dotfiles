#!/usr/bin/env bash
set -euo pipefail

if pgrep -x "waybar" > /dev/null; then
    echo "Reloading Waybar..."
    pkill -SIGUSR2 waybar 2>/dev/null || true
fi
