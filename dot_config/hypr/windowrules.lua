-- Global
hl.window_rule({
    name = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
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

-- Dialogs
hl.window_rule({
    name = "portal-dialogs",
    match = { class = "xdg-desktop-portal-gtk" },
    float = true,
    center = true,
})

hl.window_rule({
    match = {
        class = "(DesktopEditors|[T|t]hunar)",
        title =
        "^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to [open|save].*|[C|c]hoose.*|[R|r]ename.*)"
    },
    float = true
})

hl.window_rule({
    name = "picture-in-picture",
    match = { title = "^(Picture-in-Picture|Picture in picture)$" },
    float = true,
    pin = true,
    no_initial_focus = true,
    keep_aspect_ratio = true,
})

-- Floating apps
hl.window_rule({
    name = "small-utilities",
    match = { class = "^(org.gnome.Calculator|gnome-calculator|qalculate-gtk|org.kde.kcalc|org.pulseaudio.pavucontrol|pavucontrol|blueman-manager|nm-connection-editor|org.localsend.localsend_app)$" },
    float = true,
})

hl.window_rule({
    name = "media-viewers",
    match = { class = "^(imv|feh|sxiv|nsxiv|eog|org.gnome.eog|gwenview|org.kde.gwenview|mpv|vlc)$" },
    float = true,
    center = true,
})

hl.window_rule({
    name = "file-manager",
    match = { class = "^([T|t]hunar|org.gnome.Nautilus|dolphin|pcmanfm|nemo|org.kde.dolphin)$" },
    float = true,
    size = { 900, 600 }
})

-- Workspaces
hl.window_rule({
    name = "browsers",
    match = { class = "^(zen.*|[Ff]irefox|[Cc]hromium|google-chrome|brave.*)$" },
    workspace = "name:web silent",
})

hl.window_rule({
    name = "editors",
    match = { class = "^(code-oss|Code|code|VSCodium|cursor|zeditor|dev.zed.Zed)$" },
    workspace = "name:code silent",
})

hl.window_rule({
    name = "music",
    match = { class = "^(Spotify|spotify|ncspot)$" },
    workspace = "name:home silent",
})

hl.window_rule({
    name = "document-readers",
    match = { class = "^(evince|org.gnome.Evince|okular|org.kde.okular|org.pwmt.zathura)$" },
    workspace = "3 silent",
})

hl.window_rule({
    name = "office-suites",
    match = { class = "^(libreoffice.*|ONLYOFFICE)$" },
    workspace = "3 silent",
})

hl.window_rule({
    name = "zoom",
    match = { class = "^(Zoom)$" },
    workspace = "5 silent",
    focus_on_activate = false,
    idle_inhibit = "focus",
})

-- Games
hl.window_rule({
    name = "game-launchers",
    match = { class = "^(steam|lutris)$" },
    workspace = "4 silent",
})

hl.window_rule({
    name = "games",
    match = { class = "^(steam_app_.*|factorio|cs2)$" },
    workspace = "4 silent",
    fullscreen = true,
    idle_inhibit = "fullscreen",
})

-- Overrides
hl.window_rule({
    name = "zoom-popups",
    match = { class = "^(zoom)$", title = "^(zoom)$" },
    float = true,
})

hl.window_rule({
    name = "steam-dialogs",
    match = { class = "^(steam)$", title = "^(Steam - News|Friends List|Steam Settings|Screenshot Uploader)$" },
    float = true,
    size = { 900, 600 },
})

hl.window_rule({
    name = "noctalia-settings",
    match = { class = "dev.noctalia.Noctalia" },
    float = true,
    size = { 1080, 920 },
})

-- Smart gaps
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]" }, rounding = 0 })

-- Layer rules
hl.layer_rule({
    name = "noctalia",
    match = {
        namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
    },
    no_anim = true,
    ignore_alpha = 0.5,
    blur = true,
    blur_popups = true,
})
