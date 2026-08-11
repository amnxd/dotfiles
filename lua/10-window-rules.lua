-- Window rules for common window behaviors
hl.window({
    name = "kitty-scratchpad-rules",
    match = { class = "^(kitty-scratchpad)$" },
    float = true,
    workspace = "special:scratchpad silent",
    size = "80% 55%",
    move = "10% 40",
    rounding = 14,
    opacity = { 0.90, 0.90 },
})

hl.window({
    name = "fix-xwayland-drags",
    match = { class = "^$", title = "^$", xwayland = true },
    float = true,
    fullscreen = false,
    pin = false,
    no_focus = true,
})

hl.window({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = "20 monitor_h-120",
    float = true,
})
