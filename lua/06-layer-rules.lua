-- Layer rules for blur and overlay windows
hl.layer_rule({
    name = "blur-rofi",
    match = { namespace = "rofi" },
    blur = true,
    ignore_alpha = 0.5,
})

hl.layer_rule({
    name = "blur-swaync-notification-window",
    match = { namespace = "swaync-notification-window" },
    blur = true,
    ignore_alpha = 0.1,
})
