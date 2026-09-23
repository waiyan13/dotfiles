# Linux-only shell setup. conf.d runs before config.fish, so PATH lands early.
if test (uname) = Linux
    if test -f /usr/share/cachyos-fish-config/cachyos-config.fish
        source /usr/share/cachyos-fish-config/cachyos-config.fish
    end

    fish_add_path /opt/nvim-linux-x86_64/bin
    fish_add_path /opt/google-cloud-sdk/bin

    # The next line updates PATH for the Google Cloud SDK.
    if test -f /opt/google-cloud-sdk/path.fish.inc
        source /opt/google-cloud-sdk/path.fish.inc
    end
end
