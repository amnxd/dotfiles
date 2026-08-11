-- General layout and decoration settings
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = { top = 3, right = 10, bottom = 10, left = 10 },
        border_size = 0,
        col = {
            active_border = HYPR.color4,
            inactive_border = HYPR.color0,
        },
        resize_on_border = false,
        allow_tearing = true,
        layout = "dwindle",
    },

    decoration = {
        rounding = 15,
        rounding_power = 4,
        active_opacity = 1,
        inactive_opacity = 1,
        shadow = {
            enabled = true,
            range = 10,
            render_power = 3,
            color = "rgba(33333366)",
        },
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
        accel_profile = "flat",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.75,
        },
    },
})
