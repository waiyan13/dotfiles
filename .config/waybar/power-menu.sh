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
    hyprctl dispatch exit  # change if not using Hyprland
    ;;
esac
