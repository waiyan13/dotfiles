# macOS-only shell setup. conf.d runs before config.fish, so PATH lands early.
if test (uname) = Darwin
    if test -x /opt/homebrew/bin/brew
        /opt/homebrew/bin/brew shellenv fish | source
    end

    # k9s defaults to ~/Library/Application Support/k9s here. Point it at the
    # XDG path so it picks up .config/k9s, the same as on Linux.
    set -gx K9S_CONFIG_DIR $HOME/.config/k9s
end
