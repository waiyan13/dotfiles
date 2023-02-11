#!/bin/sh

userresources=$HOME/.Xresources
sysresources=/etc/X11/xinit/.Xresources

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

betterlockscreen -w dim
feh --bg-fill --no-fehbg --randomize --recursive ~/Pictures/wallpaper
exec i3
