hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.gesture({
    fingers = 3,
    direction = "down",
    action = "special",
    workspace_name = "scratchpad",
})
hl.gesture({
    fingers = 3,
    direction = "up",
    action = function()
        hl.dispatch(hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))
    end,
})

hl.gesture({
    fingers = 4,
    direction = "up",
    action = function()
        hl.exec_cmd("foot")
    end,
})
hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = 1, mode = "live" })
