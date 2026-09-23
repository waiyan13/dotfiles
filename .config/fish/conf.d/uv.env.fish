# The uv installer writes this file. Guarded so a machine without uv still starts.
if test -f "$HOME/.local/bin/env.fish"
    source "$HOME/.local/bin/env.fish"
end
