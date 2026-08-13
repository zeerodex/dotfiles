hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})
hl.gesture({ fingers = 4, direction = "down", action = "special", workspace_name = "scratchpad", disable_inhibit = true })
hl.gesture({
    fingers = 4,
    direction = "up",
    action = function()
        hl.exec_cmd("foot")
    end,
})
hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = 1, mode = "live" })
