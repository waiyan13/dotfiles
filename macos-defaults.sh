#!/bin/sh
# macOS preferences. These are defaults(1) writes rather than config files, so
# they have no Linux counterpart and do not live under .config. install.sh runs
# this on macOS; it is safe to run on its own, and safe to run twice.
set -eu

if [ "$(uname)" != Darwin ]; then
    echo "macos-defaults.sh: not macOS, nothing to do"
    exit 0
fi

# Keep screenshots out of the Desktop.
mkdir -p "$HOME/Pictures/Screenshots"
defaults write com.apple.screencapture location "$HOME/Pictures/Screenshots"
echo "screenshots -> ~/Pictures/Screenshots"

# Window screenshots carry a wide drop-shadow that costs several megabytes.
defaults write com.apple.screencapture disable-shadow -bool true
echo "screenshot drop-shadow off"

# Gregorian calendar. A Thai region otherwise dates everything in the Buddhist
# era, so a file made in 2026 is named 2569. Keep whatever region is set and
# override only the calendar.
locale=$(defaults read NSGlobalDomain AppleLocale 2>/dev/null || echo en_US)
defaults write NSGlobalDomain AppleLocale -string "${locale%%@*}@calendar=gregorian"
echo "calendar -> gregorian (${locale%%@*})"

killall SystemUIServer 2>/dev/null || true

echo
echo "Log out and back in for the calendar change to reach every app."
