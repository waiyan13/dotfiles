#!/bin/sh
# Copy the configs in this repo into place, skipping what the OS cannot use.
set -eu

cd "$(dirname "$0")"

# Configs that work on both Linux and macOS.
shared="bat delta fish ghostty git k9s mise nvim starship.toml"

# Wayland/Hyprland desktop configs. Linux only.
linux_only="hypr rofi waybar xdg-desktop-portal"

os=$(uname)

mkdir -p "$HOME/.config"

for c in $shared; do
    cp -R ".config/$c" "$HOME/.config/"
    echo "installed .config/$c"
done

if [ "$os" = Linux ]; then
    for c in $linux_only; do
        cp -R ".config/$c" "$HOME/.config/"
        echo "installed .config/$c"
    done
else
    echo "skipped (Linux only): $linux_only"
fi

cp -R home/. "$HOME/"
echo "installed home/"
