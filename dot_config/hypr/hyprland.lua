require("autostart")
require("environment")
require("windowrules")
require("binds")
require("monitors")
require("gestures")
require("animation")

require("noctalia").apply_theme()

hl.config({
    general = {
        border_size = 1,
        gaps_in = 2,
        gaps_out = 3,

        snap = {
            enabled = true,
            window_gap = 5,
        },

        layout = "scrolling",

        allow_tearing = true
    },
    decoration = {
        rounding = 0,

        active_opacity = 1,
        inactive_opacity = 1,
        fullscreen_opacity = 1,

        dim_inactive = false,

        blur = {
            enabled = false,
        },

        shadow = {
            enabled = false,
        },
    },
    input = {
        kb_layout = "us,ru,ua",
        kb_options = "grp:caps_toggle",

        follow_mouse = true,
        sensitivity = 0,
        accel_profile = "flat",

        touchpad = {
            natural_scroll = true,
            scroll_factor = 1.0,
        },
    },
    xwayland = {
        force_zero_scaling = true,
    },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        initial_workspace_tracking = false,
        focus_on_activate = true,
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
    dwindle = {
        preserve_split = true,
    },
})
