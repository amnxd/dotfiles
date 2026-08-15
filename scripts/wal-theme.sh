#!/usr/bin/env bash
# Apply wallpaper-derived theme using pywal and update running apps (kitty)
# Usage: wal-theme.sh /path/to/wallpaper.jpg
set -euo pipefail
if [ "$#" -lt 1 ]; then
  echo "Usage: $0 /path/to/wallpaper"
  exit 2
fi
WALL="$1"
if ! command -v wal >/dev/null 2>&1; then
  echo "pywal (wal) not found. Install it (pip install pywal) or adjust script." >&2
  exit 3
fi
# Generate colors from wallpaper
wal -i "$WALL"
# Update kitty (all windows) if kitty remote control is available
if command -v kitty >/dev/null 2>&1; then
  if kitty @ ls >/dev/null 2>&1; then
    kitty @ set-colors --all /home/aman/.cache/wal/colors-kitty.conf || true
  fi
fi
# Optional: reload waybar, rofi, foot, etc. Uncomment if you use them
# pkill -USR1 waybar
# pkill -RTMIN+1 waybar
# pgrep -x rofi && pkill -HUP rofi

echo "Applied theme from: $WALL"
