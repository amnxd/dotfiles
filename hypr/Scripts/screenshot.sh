#!/usr/bin/env sh
mkdir -p "$HOME/Pictures/Screenshots"
file="$HOME/Pictures/Screenshots/screenshot-$(date +%F_%T).png"
grim -g "$(slurp)" "$file" && wl-copy < "$file" && notify-send "Screenshot saved and copied"
