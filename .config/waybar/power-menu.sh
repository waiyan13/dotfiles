#!/bin/bash

choice=$(printf "Shutdown\nReboot\nLock\nLogout" | rofi -dmenu -i -p "Power")

case "$choice" in
  Shutdown)
    systemctl poweroff
    ;;
  Reboot)
    systemctl reboot
    ;;
  Lock)
    loginctl lock-session
    ;;
  Logout)
    # Lua call form. The old `dispatch exit` form fails on a lua config.
    hyprctl dispatch 'hl.dsp.exit()'  # change if not using Hyprland
    ;;
esac
