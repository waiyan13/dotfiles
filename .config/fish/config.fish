# Shared shell setup. Per-OS bits live in conf.d/10-linux.fish and
# conf.d/10-macos.fish, which fish sources before this file.

fish_add_path $HOME/.local/bin

# starship — prompt
if type -q starship
    starship init fish | source
end

# mise — runtimes, per-project tool versions, env and tasks
if type -q mise
    if status is-interactive
        mise activate fish | source
    else
        mise activate fish --shims | source
    end
end

# direnv — per-directory env
if type -q direnv
    direnv hook fish | source
end

# opencode
if test -d $HOME/.opencode/bin
    fish_add_path $HOME/.opencode/bin
end

# Added by the Hunk installer (https://hunk.dev)
if test -d $HOME/.hunk/bin
    fish_add_path $HOME/.hunk/bin
end
