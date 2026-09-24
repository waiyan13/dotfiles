#!/bin/sh
# Copy the configs in this repo into place, skipping what the OS cannot use.
set -eu

cd "$(dirname "$0")"

# Configs that work on both Linux and macOS.
shared="bat delta fish ghostty git k9s mise nvim starship.toml"

# Wayland/Hyprland desktop configs. Linux only.
linux_only="hypr rofi waybar xdg-desktop-portal"

os=$(uname)

case "$os" in
    Linux)  ghostty_os=os-linux.conf  ;;
    Darwin) ghostty_os=os-macos.conf  ;;
    *)      ghostty_os=""             ;;
esac

mkdir -p "$HOME/.config"

for c in $shared; do
    cp -R ".config/$c" "$HOME/.config/"
    echo "installed .config/$c"
done

# ghostty's config.ghostty includes ?os.conf, which overrides it.
if [ -n "$ghostty_os" ]; then
    cp ".config/ghostty/$ghostty_os" "$HOME/.config/ghostty/os.conf"
    echo "installed .config/ghostty/os.conf from $ghostty_os"
fi

if [ "$os" = Linux ]; then
    for c in $linux_only; do
        cp -R ".config/$c" "$HOME/.config/"
        echo "installed .config/$c"
    done

    # home/ holds only .docker/config.json, and its credsStore is pass, the
    # Linux password store. macOS uses osxkeychain and Docker writes its own
    # context and plugin paths into that file, so leave it alone there.
    cp -R home/. "$HOME/"
    echo "installed home/"
else
    echo "skipped (Linux only): $linux_only home/"
fi

if [ "$os" = Darwin ]; then
    echo
    ./macos-defaults.sh
fi
