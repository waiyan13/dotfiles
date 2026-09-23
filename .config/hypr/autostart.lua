---------------------
----- AUTOSTART -----
---------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
--
-- The "hyprland.start" event replaces exec-once. The callback runs one
-- time, after the compositor starts.

hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("hyprpaper & mako")
end)
