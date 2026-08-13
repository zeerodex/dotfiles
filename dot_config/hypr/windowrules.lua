-- Popups blur around fix
hl.window_rule({
    match   = { class = "^$", title = "^$" },
    no_blur = true,
})

-- Polkit
hl.window_rule({
    name         = "polkit",
    match        = { class = "^(polkit-.*)$" },
    float        = true,
    center       = true,
    stay_focused = true,
    dim_around   = true,
    size         = { 420, 320 },
    animation    = "popin",
})

-- Rofi
hl.window_rule({ match = { class = "^(Rofi)$" }, stay_focused = true })

-- Browsers → named workspace
hl.window_rule({
    match     = { class = "^(zen-alpha|zen-beta|zen|firefox|Firefox|chromium|Chromium|google-chrome|brave-browser)$" },
    workspace = "name:web silent",
})

-- Picture-in-Picture
hl.window_rule({
    name              = "pip",
    match             = { title = "^(Picture-in-Picture|Picture in picture)$" },
    float             = true,
    pin               = true,
    no_dim            = true,
    keep_aspect_ratio = true,
    opacity           = "1 override",
    idle_inhibit      = "focus",
    size              = { 480, 270 },
    move              = { 1420, 43 },
})

-- Thunar main window
hl.window_rule({ match = { class = "^(thunar|Thunar)$" }, float = true, center = true, size = { 900, 600 } })

-- Thunar dialogs (rename, properties, etc.)
hl.window_rule({
    match        = { class = "^(thunar|Thunar)$", title = "^(Properties|Preferences|Create.*|Rename.*|Confirm.*)$" },
    float        = true,
    center       = true,
    stay_focused = true,
    dim_around   = true,
    size         = { 480, 320 },
    animation    = "popin",
})

-- Thunar progress
hl.window_rule({
    match  = { class = "^(thunar|Thunar)$", title = "^(File Operation Progress|Copying|Moving|Deleting).*$" },
    float  = true,
    center = true,
    size   = { 480, 160 },
})

-- Archive manager
hl.window_rule({ match = { class = "^(xarchiver)$" }, float = true, center = true, size = { 700, 500 } })

-- File picker portal
hl.window_rule({ match = { class = "^(xdg-desktop-portal-gtk)$" }, float = true, center = true, size = { 900, 600 } })

-- Image viewers
hl.window_rule({
    match             = { class = "^(imv|feh|sxiv|nsxiv|eog|org.gnome.eog|gwenview|org.kde.gwenview)$" },
    float             = true,
    center            = true,
    keep_aspect_ratio = true,
    opacity           = "1 override",
    size              = { 1366, 768 },
})

-- mpv
hl.window_rule({
    match             = { class = "^(mpv|vlc)$" },
    float             = true,
    center            = true,
    keep_aspect_ratio = true,
    no_dim            = true,
    opacity           = "1 override",
    idle_inhibit      = "focus",
    size              = { 1366, 768 },
})



-- Zoom
hl.window_rule({
    match = { class = "^(zoom|us.zoom.Zoom)$" },
    workspace = "5 silent",
    no_dim = true,
    idle_inhibit = "focus",
    focus_on_activate = false
})
hl.window_rule({ match = { class = "^(zoom|us.zoom.Zoom)$", title = "^(zoom)$" }, float = true })
hl.window_rule({
    match = { class = "^(zoom|us.zoom.Zoom)$", title = "^(Settings|Participants|Chat|Breakout Rooms)$" },
    float = true,
    size  = { 800, 600 },
})

-- Teams
hl.window_rule({
    match = { class = "^(teams|microsoft teams|teams-for-linux)$" },
    workspace = "5 silent",
    idle_inhibit =
    "focus"
})

-- Document viewers → workspace 3
hl.window_rule({ match = { class = "^(evince|org.gnome.Evince|okular|org.kde.okular|zathura)$" }, workspace = "3 silent" })

-- Office suites → workspace 3
hl.window_rule({ match = { class = "^(libreoffice.*|ONLYOFFICE)$" }, workspace = "3 silent", opacity = "1 override" })
-- OnlyOffice modal dialog
hl.window_rule({ match = { class = "^(DesktopEditors|onlyoffice-desktopeditors)$" }, float = true, center = true })
-- LibreOffice no maximize
hl.window_rule({ match = { class = "^(libreoffice.*)$" }, suppress_event = "maximize" })

-- Editors / IDEs
hl.window_rule({ match = { class = "^(code-oss|Code|code|VSCodium|cursor|zeditor)$" }, workspace = "name:code silent" })

-- Steam, Lutris
hl.window_rule({ match = { class = "^(steam|lutris)$" }, workspace = "4 silent" })
hl.window_rule({
    match  = { class = "^(steam)$", title = "^(Steam - News|Friends List|Steam Settings|Screenshot Uploader)$" },
    float  = true,
    center = true,
    size   = { 900, 700 },
})

-- Games → workspace 4, fullscreen
hl.window_rule({ match = { class = "^(steam_app_.*)$" }, workspace = "4 silent", fullscreen = true })
hl.window_rule({ match = { class = "^(factorio)$" }, workspace = "4 silent", fullscreen = true })

-- CS2: reduce input latency
hl.window_rule({ match = { class = "^(cs2)$" }, workspace = "4 silent", immediate = true })

-- Music
hl.window_rule({ match = { class = "^(Spotify|spotify|ncspot)$" }, workspace = "name:home silent" })

-- Audio/network/bluetooth utilities
hl.window_rule({
    match  = { class = "^(org.pulseaudio.pavucontrol|pavucontrol|blueman-manager|nm-connection-editor)$" },
    float  = true,
    center = true,
    size   = { 800, 700 },
})

-- LocalSend
hl.window_rule({
    match  = { class = "^(localsend)$" },
    float  = true,
    center = true,
    size   = { 600, 700 },
})

-- Calculator
hl.window_rule({ match = { class = "^(qalculate-gtk)$" }, float = true, center = true })

-- Generic modal dialogs
hl.window_rule({
    name         = "modal-dialog",
    match        = { title = "^(Confirm.*|Warning.*|Error.*|Information.*|Question.*|Alert.*)$" },
    float        = true,
    center       = true,
    stay_focused = true,
    dim_around   = true,
    size         = { 400, 200 },
    animation    = "popin",
})

-- Workspace rules
hl.workspace_rule({ workspace = "5", monitor = "DP-1" })
hl.workspace_rule({ workspace = "name:home", monitor = "DP-1" })
hl.workspace_rule({ workspace = "name:web", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1" })
