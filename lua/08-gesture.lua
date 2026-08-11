-- Gesture and device configuration
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.gesture({
    fingers = 3,
    direction = "up",
    disable_inhibit = true,
    action = "special",
    workspace_name = "scratchpad",
})

hl.gesture({
    fingers = 3,
    direction = "down",
    disable_inhibit = true,
    action = "special",
    workspace_name = "scratchpad",
})

hl.gesture({
    fingers = 2,
    direction = "pinch",
    action = "cursorZoom",
    zoom_level = 1,
    mode = "live",
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})
