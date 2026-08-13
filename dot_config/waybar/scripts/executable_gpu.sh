#!/usr/bin/env bash

BASE=""
if [[ -n "${CARD:-}" ]]; then
    BASE="/sys/class/drm/${CARD}/device"
else
    for dev in /sys/class/drm/card*/device; do
        if [[ -f "$dev/gpu_busy_percent" ]]; then
            BASE="$dev"
            break
        fi
    done
    BASE="${BASE:-/sys/class/drm/card1/device}"
fi

read -r gpu_util < "${BASE}/gpu_busy_percent" 2>/dev/null || gpu_util=0

hwmon_paths=("${BASE}"/hwmon/hwmon*/temp1_input)
if [[ -f "${hwmon_paths[0]}" ]]; then
    read -r temp_raw < "${hwmon_paths[0]}" 2>/dev/null
    gpu_temp=$(( temp_raw / 1000 ))
else
    gpu_temp="N/A"
fi

if read -r vram_used_raw < "${BASE}/mem_info_vram_used" 2>/dev/null; then
    vram_used_mib=$(( vram_used_raw / 1048576 ))
    vram_str="${vram_used_mib} MiB"
else
    vram_str="N/A"
fi

printf '{"text":"gpu: %s%% %s°C %s"}\n' "$gpu_util" "$gpu_temp" "$vram_str"
