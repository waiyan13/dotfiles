-- ######################################################################
-- HYPRLAND CONFIG.
-- EDIT THIS CONFIG ACCORDING TO THE WIKI INSTRUCTIONS.
-- https://wiki.hypr.land/Configuring/
-- ######################################################################

-- This config splits into modules. Hyprland puts this directory on the
-- Lua search path, so require() finds each sibling file by name.
-- A dot is a directory separator: "themes.macchiato" is themes/macchiato.lua

require("input")
require("bindings")
require("lookandfeel")
require("autostart")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- The Acer stays on the left of the laptop panel.
-- Hyprland does not use a direction on the first output, so eDP-1 must come first.
-- eDP-1 keeps the origin, and "auto-left" gives the Acer a negative x.
-- The mode does not change the layout, so the 4K line below needs no new position.
local ACER = "desc:Acer Technologies VG270 P6 1612007893S00"

hl.monitor({ output = "eDP-1", mode = "1920x1080@144",    position = "0x0",       scale = 1 })
hl.monitor({ output = ACER,    mode = "1920x1080@143.99", position = "auto-left", scale = 1 })
--hl.monitor({ output = ACER,  mode = "3840x2160@59.94",  position = "auto-left", scale = 1.25 })


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")


---------------------
---- PERMISSIONS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/ for workspace rules

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
