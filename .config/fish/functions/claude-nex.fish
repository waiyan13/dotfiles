function claude-nex --wraps claude --description 'claude with the nex account'
    # Each config home carries its own credentials, settings, MCP servers and
    # plugins. The desktop app keeps the default ~/.claude, so work stays put.
    set -lx CLAUDE_CONFIG_DIR $HOME/.claude-nex
    command claude $argv
end
