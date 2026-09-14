#!/bin/sh
set -eu

theme_dir=/usr/share/sddm/themes/evergreen
config_dir=/etc/sddm.conf.d
source_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

sudo install -d "$theme_dir" "$config_dir"
sudo cp -a "$source_dir"/. "$theme_dir"/
sudo install -m 0644 "$source_dir/10-evergreen.conf" "$config_dir/10-evergreen.conf"

printf '%s\n' 'Evergreen SDDM theme installed.'
printf '%s\n' 'Restart SDDM or reboot to see it.'