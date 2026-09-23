# macOS-only shell setup. conf.d runs before config.fish, so PATH lands early.
if test (uname) = Darwin
    if test -x /opt/homebrew/bin/brew
        /opt/homebrew/bin/brew shellenv fish | source
    end
end
