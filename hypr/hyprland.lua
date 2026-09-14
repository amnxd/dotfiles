---@diagnostic disable: undefined-global

local home = os.getenv("HOME") or "/home/aman"
local main_mod = "SUPER"
local terminal = "kitty"
local file_manager = "nautilus"

local function wal_color(name, fallback)
    local path = home .. "/.cache/wal/colors-hyprland.conf"
    local file = io.open(path, "r")
    if not file then
        return fallback
    end

    for line in file:lines() do
        local value = line:match("^%$" .. name .. "%s*=%s*(.+)$")
        if value then
            file:close()
            return value
        end
    end

    file:close()
    return fallback
end

local color0 = wal_color("color0", "rgb(0f0f12)")
local color4 = wal_color("color4", "rgb(9F5F74)")

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@60.01Hz",
    position = "0x0",
    scale = "1.25",
})

hl.on("hyprland.start", function()
    hl.exec_cmd("mako") -- Started mako instead of swaync
    -- hl.exec_cmd("sh -c 'pgrep -u \"$USER\" -f \"quickshell .*\\/usr\\/share\\/tide-island\" >/dev/null || tide-island >/dev/null 2>&1 &'")
    hl.exec_cmd(
        'sh -c "if ! pgrep -x awww-daemon >/dev/null; then awww-daemon >/dev/null 2>&1 & sleep 1; fi; awww img $HOME/.config/hypr/wallpaper.png"')
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd("waypaper --restore")
    hl.exec_cmd(
        "sh -c 'systemctl --user import-environment WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP XDG_SESSION_TYPE DBUS_SESSION_BUS_ADDRESS; dbus-update-activation-environment --systemd WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE XDG_CURRENT_DESKTOP XDG_SESSION_TYPE DBUS_SESSION_BUS_ADDRESS; systemctl --user restart hypridle.service'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'")
    hl.exec_cmd("kitty --class kitty-scratchpad", { workspace = "special:scratchpad silent" })
    hl.exec_cmd("waybar") --ehe this waybar

    -- Add these two lines for clipboard history:
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)

hl.env("XCURSOR_SIZE", "18")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "18")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("GLFW_IM_MODULE", "ibus")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("GTK_APPLICATION_PREFER_DARK_THEME", "1")
hl.env("QT_STYLE_OVERRIDE", "kvantum")

hl.permission({
    binary = "/usr/(bin|local/bin)/hyprpm",
    type = "plugin",
    mode = "allow",
})

hl.config({
    general = {
        gaps_in = 0,
        gaps_out = {
            top = 0,
            right = 0,
            bottom = 0,
            left = 0
        },
        border_size = 0,
        -- col = {
        --     active_border = color4,
        --     inactive_border = color0,
        -- },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 0,
        rounding_power = 4,

        active_opacity = 1,
        inactive_opacity = 1,

        -- shadow = {
        --     enabled = true,
        --     range = 12,
        --     render_power = 3,
        --     color = "rgba(00000040)",
        -- },

        blur = {
            enabled = true,
            size = 8,
            passes = 3,
            new_optimizations = true,
            ignore_opacity = false,
            vibrancy = 0.1696,
            special = false,
        },
    },

    cursor = {
        no_hardware_cursors = false,
        zoom_factor = 1,
        zoom_rigid = false,
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },

    input = {
        kb_layout = "us",
        accel_profile = "flat", -- Changed from "adaptive"
        follow_mouse = 1,
        sensitivity = 0.1,      -- Slightly increased (range is -1.0 to 1.0)

        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.50,
        },
    },
})

hl.layer_rule({
    name = "blur-rofi",
    match = {
        namespace = "rofi"
    },
    blur = true,
    ignore_alpha = 0.5,
})

hl.layer_rule({
    name = "blur-mako-notification-window",
    match = {
        namespace = "mako"
    },
    blur = true,
    ignore_alpha = 0.1,
})

-- ============================================================
-- ANIMATION CURVES (Unified macOS Physics)
-- ============================================================

hl.curve("appleEaseOut", {
    type = "bezier",
    points = {
        { 0.25, 1 },
        { 0.5,  1 }
    }
})

hl.curve("appleFade", {
    type = "bezier",
    points = {
        { 0.3, 0 },
        { 0.5, 1 }
    }
})

-- ============================================================
-- ANIMATIONS (Harmonized at ~400ms)
-- ============================================================

hl.animation({
    leaf = "global",
    enabled = true,
    speed = 4.0,
    bezier = "appleEaseOut"
})

-- Windows
hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 4.0,
    bezier = "appleEaseOut",
    style = "slide"
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 3.5,
    bezier = "appleEaseOut",
    style = "slide"
})

hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 4.0,
    bezier = "appleEaseOut"
})

-- Workspaces
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 4.2,
    bezier = "appleEaseOut",
    style = "slide"
})

hl.animation({
    leaf = "specialWorkspace",
    enabled = true,
    speed = 4.0,
    bezier = "appleEaseOut",
    style = "slidevert"
})

-- Fading & UI Layers
hl.animation({
    leaf = "border",
    enabled = false,
    speed = 4.0,
    bezier = "appleEaseOut"
})

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 4.0,
    bezier = "appleFade"
})

hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 4.0,
    bezier = "appleEaseOut"
})

hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 4.0,
    bezier = "appleFade",
    style = "fade"
})

hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 3.5,
    bezier = "appleFade",
    style = "fade"
})

-- ============================================================
-- TOUCHPAD GESTURES
-- ============================================================

-- 3-finger horizontal swipe = workspace switching
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

-- 3-finger swipe up = scratchpad
hl.gesture({
    fingers = 3,
    direction = "up",
    disable_inhibit = true,
    action = "special",
    workspace_name = "scratchpad",
})

-- 3-finger swipe down = scratchpad
hl.gesture({
    fingers = 3,
    direction = "down",
    disable_inhibit = true,
    action = "special",
    workspace_name = "scratchpad",
})

-- ============================================================-- ANIMATION CURVES-- ============================================================hl.curve("easeOutQuint", {    type = "bezier",    points = {        { 0.23, 1 },        { 0.32, 1 }    }})hl.curve("easeInOutCubic", {    type = "bezier",    points = {        { 0.65, 0.05 },        { 0.36, 1 }    }})hl.curve("linear", {    type = "bezier",    points = {        { 0, 0 },        { 1, 1 }    }})hl.curve("almostLinear", {    type = "bezier",    points = {        { 0.5, 0.5 },        { 0.75, 1 }    }})hl.curve("quick", {    type = "bezier",    points = {        { 0.15, 0 },        { 0.1, 1 }    }})hl.curve("myBezier", {    type = "bezier",    points = {        { 0.05, 0.9 },        { 0.1, 1.05 }    }})hl.curve("moveCurve", {    type = "bezier",    points = {        { 0.16, 1 },        { 0.3, 1 }    }})hl.curve("popCurve", {    type = "bezier",    points = {        { 0.22, 1 },        { 0.36, 1 }    }})-- ============================================================-- ANIMATIONS-- ============================================================hl.animation({    leaf = "global",    enabled = true,    speed = 10,    bezier = "default"})-- Smooth, simple window animationhl.animation({    leaf = "windowsIn",    enabled = true,    speed = 4,    bezier = "easeOutQuint",    style = "slide"})hl.animation({    leaf = "windowsOut",    enabled = true,    speed = 4,    bezier = "linear",    style = "slide"})hl.animation({    leaf = "windowsMove",    enabled = true,    speed = 4,    bezier = "easeInOutCubic"})-- Bordershl.animation({    leaf = "border",    enabled = true,    speed = 4,    bezier = "easeOutQuint"})-- Fadinghl.animation({    leaf = "fadeIn",    enabled = true,    speed = 3,    bezier = "almostLinear"})hl.animation({    leaf = "fadeOut",    enabled = true,    speed = 3,    bezier = "almostLinear"})hl.animation({    leaf = "fade",    enabled = true,    speed = 4,    bezier = "quick"})-- Layershl.animation({    leaf = "layers",    enabled = true,    speed = 4,    bezier = "easeOutQuint"})hl.animation({    leaf = "layersIn",    enabled = true,    speed = 4,    bezier = "easeOutQuint",    style = "fade"})hl.animation({    leaf = "layersOut",    enabled = true,    speed = 3,    bezier = "easeOutQuint",    style = "fade"})-- Workspace animation-- LEFT UNCHANGEDhl.animation({    leaf = "workspaces",    enabled = true,    speed = 5,    bezier = "myBezier",    style = "slide"})hl.animation({    leaf = "specialWorkspace",    enabled = true,    speed = 8,    bezier = "myBezier",    style = "slidevert"})-- DISABLED: 2-finger pinch zoom-- hl.animation({--     leaf = "zoomFactor",--     enabled = true,--     speed = 7,--     bezier = "quick"-- })-- ============================================================-- TOUCHPAD GESTURES-- ============================================================-- 3-finger horizontal swipe = workspace switchinghl.gesture({    fingers = 3,    direction = "horizontal",    action = "workspace",})-- 3-finger swipe up = scratchpadhl.gesture({    fingers = 3,    direction = "up",    disable_inhibit = true,    action = "special",    workspace_name = "scratchpad",})-- 3-finger swipe down = scratchpadhl.gesture({    fingers = 3,    direction = "down",    disable_inhibit = true,    action = "special",    workspace_name = "scratchpad",})-- DISABLED: 2-finger pinch-to-zoom-- hl.gesture({--     fingers = 2,--     direction = "pinch",--     action = "cursorZoom",--     zoom_level = 1,--     mode = "live",-- })
-- ============================================================
-- DEVICES
-- ============================================================

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})


-- ============================================================
-- KEYBINDS
-- ============================================================

hl.bind(
    main_mod .. " + SHIFT + S",
    hl.dsp.exec_cmd(
        [=[sh -c 'mkdir -p "$HOME/Pictures/Screenshots" && file="$HOME/Pictures/Screenshots/screenshot-$(date +%F_%H-%M-%S).png" && grim -g "$(slurp)" "$file" && wl-copy -t image/png < "$file" && notify-send "Screenshot" "Saved and copied to clipboard"']=])
)

hl.bind(
    "Print",
    hl.dsp.exec_cmd(
        [=[sh -c 'mkdir -p "$HOME/Pictures/Screenshots" && file="$HOME/Pictures/Screenshots/screenshot-$(date +%F_%H-%M-%S).png" && grim "$file" && wl-copy -t image/png < "$file" && notify-send "Screenshot" "Full screen saved and copied to clipboard"']=])
)

hl.bind(
    main_mod .. " + C",
    hl.dsp.exec_cmd(
        [=[sh -c 'cliphist list | grep -vF "[[ binary data" | rofi -dmenu -p "Text" -theme-str "window {width: 500px; border-radius: 10px; border: 1px; border-color: #313244;} listview {lines: 8;}" | cliphist decode | wl-copy']=])
)

hl.bind(
    main_mod .. " + I",
    hl.dsp.exec_cmd(
        [=[sh -c 'cliphist list | grep -F "[[ binary data" | rofi -dmenu -p "Images" -theme-str "window {width: 500px; border-radius: 10px; border: 1px; border-color: #313244;} listview {lines: 8;}" | cliphist decode | wl-copy']=])
)

-- [Add this block to Wipe Clipboard History]
hl.bind(
    main_mod .. " + SHIFT + C",
    hl.dsp.exec_cmd([=[sh -c 'cliphist wipe && notify-send "Clipboard" "History cleared"']=])
)

hl.bind(main_mod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + X", hl.dsp.window.close())
hl.bind(main_mod .. " + M", hl.dsp.exec_cmd(home .. "/.local/bin/powermenu"))
hl.bind(main_mod .. " + E", hl.dsp.exec_cmd(file_manager))
hl.bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + P", hl.dsp.window.pseudo())
hl.bind(main_mod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(
    main_mod .. " + slash",
    hl.dsp.exec_cmd(
        "rofi -show drun -show-icons -theme " ..
        home .. "/.config/rofi/config_app_luancher.rasi"
    )
)
hl.bind(main_mod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(main_mod .. " + W", hl.dsp.exec_cmd(home .. "/.local/bin/wallpaper-switch.sh"))

hl.bind(main_mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(main_mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(main_mod .. " + down", hl.dsp.focus({ direction = "down" }))

-- for trackpad
hl.bind(
    main_mod .. " + ALT + mouse:272",
    hl.dsp.window.resize(),
    { mouse = true }
)


for i = 1, 10 do
    local key = i % 10

    hl.bind(
        main_mod .. " + " .. key,
        hl.dsp.focus({ workspace = i })
    )

    hl.bind(
        main_mod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i })
    )
end


hl.bind(
    main_mod .. " + grave",
    hl.dsp.workspace.toggle_special("scratchpad")
)

hl.bind(
    main_mod .. " + F",
    hl.dsp.workspace.toggle_special("fullScreen")
)

hl.bind(
    main_mod .. " + mouse_down",
    hl.dsp.focus({ workspace = "e+1" })
)

hl.bind(
    main_mod .. " + mouse_up",
    hl.dsp.focus({ workspace = "e-1" })
)

hl.bind(
    main_mod .. " + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true }
)

hl.bind(
    main_mod .. " + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true }
)


-- ============================================================
-- MEDIA / HARDWARE KEYS
-- ============================================================

hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true }
)

hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl set 1%+"),
    { locked = true, repeating = true }
)

hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl set 1%-"),
    { locked = true, repeating = true }
)

-- hl.bind(
--     "F3",
--     hl.dsp.exec_cmd("brightnessctl set 1%+")
-- )

-- hl.bind(
--     "F2",
--     hl.dsp.exec_cmd("brightnessctl set 1%-")
-- )

hl.bind(
    "XF86AudioNext",
    hl.dsp.exec_cmd("playerctl next"),
    { locked = true }
)

hl.bind(
    "XF86AudioPause",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true }
)

hl.bind(
    "XF86AudioPlay",
    hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true }
)

hl.bind(
    "XF86AudioPrev",
    hl.dsp.exec_cmd("playerctl previous"),
    { locked = true }
)


-- ============================================================
-- WINDOW RULES
-- ============================================================

hl.window_rule({
    name = "suppress-maximize-events",
    match = {
        class = ".*"
    },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "kitty-scratchpad-rules",
    match = {
        class = "^(kitty-scratchpad)$"
    },
    float = true,
    workspace = "special:scratchpad silent",
    size = "80% 55%",
    move = "10% 40",
    rounding = 14,
    opacity = "0.90 0.90",
})

hl.window_rule({
    name = "qimgv-float",
    match = {
        class = "^(qimgv)$"
    },
    float = true,
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = {
        class = "hyprland-run"
    },
    move = "20 monitor_h-120",
    float = true,
})
