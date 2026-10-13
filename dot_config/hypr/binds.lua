local term         = "foot"
local file_manager = "thunar"
local code_editor  = "zeditor"
local ipc          = "noctalia msg "
local ocr          = "~/.config/hypr/scripts/ocr.sh"
local qr           = "~/.config/hypr/scripts/qr.sh"
local picker       = "~/.config/hypr/scripts/picker.sh"

-- Window management
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.kill())
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + P", hl.dsp.window.pin())

-- Window focus
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + space", function()
    local window = hl.get_active_window()
    if not window then return end
    hl.dispatch(hl.dsp.window.cycle_next({
        floating = not window.floating,
        tiled = window.floating,
    }))
end, { description = "Switch focus between tiled and floating windows" })

-- Window movement
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Scrolling layout
hl.bind("SUPER + period", hl.dsp.layout("move +col"))
hl.bind("SUPER + comma", hl.dsp.layout("move -col"))
hl.bind("SUPER + mouse_down", hl.dsp.layout("move +col"))
hl.bind("SUPER + mouse_up", hl.dsp.layout("move -col"))

hl.bind("SUPER + SHIFT + period", hl.dsp.layout("swapcol r"))
hl.bind("SUPER + SHIFT + comma", hl.dsp.layout("swapcol l"))

hl.bind("SUPER + R", hl.dsp.layout("colresize +conf"))
hl.bind("SUPER + SHIFT + R", hl.dsp.layout("colresize -conf"))

hl.bind("SUPER + SHIFT + F", hl.dsp.layout("fit active"))
hl.bind("SUPER + SHIFT + E", hl.dsp.layout("fit expand"))


-- Applications
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(term))
hl.bind("SUPER + SHIFT + RETURN", hl.dsp.exec_cmd(term, { float = true, size = { 900, 600 } }))
hl.bind("SUPER + E", hl.dsp.exec_cmd(file_manager))
hl.bind("SUPER + Y", hl.dsp.exec_cmd("EDITOR=vim " .. term .. " -e yazi"))
hl.bind("SUPER + N", hl.dsp.exec_cmd(code_editor))
hl.bind("XF86Calculator", hl.dsp.exec_cmd("qalculate-gtk"))
hl.bind("SUPER + T", hl.dsp.exec_cmd("localsend"))

-- Session
hl.bind("SUPER + ESCAPE", hl.dsp.exec_cmd(ipc .. "panel-toggle session"))
hl.bind("SUPER + SHIFT + ESCAPE", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind("SUPER + SHIFT + CTRL + ESCAPE", hl.dsp.exit(), { locked = true })

-- Utilities
hl.bind("SUPER + D", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind("SUPER + SEMICOLON", hl.dsp.exec_cmd(ipc .. "panel-toggle clipboard"))

-- Screenshots & Capture
hl.bind("PRINT", hl.dsp.exec_cmd(ipc .. "screenshot-fullscreen"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd(ipc .. "screenshot-region"))

hl.bind("SUPER + S", hl.dsp.submap("screenshot"))

hl.define_submap("screenshot", function()
    hl.bind("F", hl.dsp.exec_cmd(ipc .. "screenshot-fullscreen"))
    hl.bind("R", hl.dsp.exec_cmd(ipc .. "screenshot-region"))
    hl.bind("A", hl.dsp.exec_cmd(ipc .. "screenshot-annotate"))

    hl.bind("Q", hl.dsp.exec_cmd(qr))
    hl.bind("P", hl.dsp.exec_cmd(picker))
    hl.bind("C", hl.dsp.exec_cmd(picker))

    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- OCR
hl.bind("SUPER + O", hl.dsp.submap("ocr"))

hl.define_submap("ocr", function()
    hl.bind("E", hl.dsp.exec_cmd(ocr .. " eng"))
    hl.bind("U", hl.dsp.exec_cmd(ocr .. " ukr"))
    hl.bind("R", hl.dsp.exec_cmd(ocr .. " rus"))
    hl.bind("A", hl.dsp.exec_cmd(ocr .. " all"))
    hl.bind("O", hl.dsp.exec_cmd(ocr .. " all"))
    hl.bind("SPACE", hl.dsp.exec_cmd(ocr .. " all"))

    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- Volume controls
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })

-- Media controls
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), { locked = true })

-- Brightness controls
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true })

-- Numbered workspaces
for i = 1, 9 do
    hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
end

for i = 1, 9 do
    hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i, follow = true }))
end

for i = 1, 9 do
    hl.bind("SUPER + ALT + " .. i, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Named workspaces
hl.bind("SUPER + C", hl.dsp.focus({ workspace = "name:code" }))
hl.bind("SUPER + W", hl.dsp.focus({ workspace = "name:web" }))
hl.bind("SUPER + A", hl.dsp.focus({ workspace = "name:home" }))
hl.bind("SUPER + Z", hl.dsp.focus({ workspace = "name:memo" }))
hl.bind("SUPER + SHIFT + C", hl.dsp.window.move({ workspace = "name:code", follow = true }))
hl.bind("SUPER + SHIFT + W", hl.dsp.window.move({ workspace = "name:web", follow = true }))
hl.bind("SUPER + SHIFT + A", hl.dsp.window.move({ workspace = "name:home", follow = true }))
hl.bind("SUPER + SHIFT + Z", hl.dsp.window.move({ workspace = "name:memo", follow = true }))
hl.bind("SUPER + ALT + C", hl.dsp.window.move({ workspace = "name:code", follow = false }))
hl.bind("SUPER + ALT + W", hl.dsp.window.move({ workspace = "name:web", follow = false }))
hl.bind("SUPER + ALT + A", hl.dsp.window.move({ workspace = "name:home", follow = false }))
hl.bind("SUPER + ALT + Z", hl.dsp.window.move({ workspace = "name:memo", follow = false }))

-- Special workspace
hl.bind("SUPER + GRAVE", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind("SUPER + SHIFT + GRAVE", hl.dsp.window.move({ workspace = "special:scratchpad", follow = true }))
hl.bind("SUPER + ALT + GRAVE", hl.dsp.window.move({ workspace = "special:scratchpad", follow = false }))

-- Workspace navigation
hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "previous" }))

-- Mouse binds
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
