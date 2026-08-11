-- Key bindings for Lua Hyprland config
hl.bind(HYPR.main_mod .. " + SHIFT + S", hl.dsp.exec_cmd([=[sh -c 'mkdir -p "$HOME/Pictures/Screenshots" && file="$HOME/Pictures/Screenshots/screenshot-$(date +%F_%T).png" && grim -g "$(slurp)" "$file" && wl-copy < "$file" && notify-send "Screenshot saved and copied"']=]))
hl.bind(HYPR.main_mod .. " + T", hl.dsp.exec_cmd(HYPR.terminal))
hl.bind(HYPR.main_mod .. " + Q", hl.dsp.window.close())
hl.bind(HYPR.main_mod .. " + M", hl.dsp.exec_cmd("/home/aman/.local/bin/powermenu"))
hl.bind(HYPR.main_mod .. " + E", hl.dsp.exec_cmd(HYPR.file_manager))
hl.bind(HYPR.main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(HYPR.main_mod .. " + P", hl.dsp.window.pseudo())
hl.bind(HYPR.main_mod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(HYPR.main_mod .. " + slash", hl.dsp.exec_cmd("rofi -show drun -show-icons -theme /home/aman/.config/rofi/config_app_luancher.rasi"))
hl.bind(HYPR.main_mod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(HYPR.main_mod .. " + W", hl.dsp.exec_cmd("/home/aman/.local/bin/wallpaper-switch.sh"))
hl.bind(HYPR.main_mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(HYPR.main_mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(HYPR.main_mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(HYPR.main_mod .. " + down", hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
    local key = i % 10
    hl.bind(HYPR.main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(HYPR.main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(HYPR.main_mod .. " + grave", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind(HYPR.main_mod .. " + F", hl.dsp.workspace.toggle_special("fullScreen"))
hl.bind(HYPR.main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(HYPR.main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(HYPR.main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(HYPR.main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
