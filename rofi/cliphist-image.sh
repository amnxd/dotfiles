#!/bin/bash
# Creates a temporary directory for thumbnails
cache_dir="/tmp/cliphist-thumbnails"
mkdir -p "$cache_dir"

# Read cliphist list and generate thumbnails for images
cliphist list | while read -r line; do
    if [[ "$line" == *"[[ binary data"* ]]; then
        id=$(echo "$line" | awk '{print $1}')
        thumb_path="$cache_dir/$id.png"
        
        # Decode and save thumbnail if it doesn't exist
        if [ ! -f "$thumb_path" ]; then
            echo "$line" | cliphist decode > "$thumb_path"
        fi
        
        # Send to rofi with icon tag
        echo -en "$line\0icon\x1f$thumb_path\n"
    else
        echo "$line"
    fi
done
