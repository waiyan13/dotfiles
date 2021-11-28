#!/bin/bash

cvt 1368 768 
# xrandr only works in X11 sessions, not Wayland
[ "$XDG_SESSION_TYPE" = x11 ] || exit 0
xrandr --newmode "3440x1440_44.00"  299.75  3440 3664 4024 4608  1440 1443 1453 1479 -hsync +vsync
xrandr --addmode HDMI-2 3440x1440_44.00
xrandr --output HDMI-2 --mode 3440x1440_44.00 --right-of eDP-1

