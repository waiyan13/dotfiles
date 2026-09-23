source /usr/share/cachyos-fish-config/cachyos-config.fish

set PATH "$PATH:/opt/nvim-linux-x86_64/bin:/opt/google-cloud-sdk/bin:$HOME/.local/bin"

starship init fish | source
mise activate fish | source

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.fish.inc' ]; . '/opt/google-cloud-sdk/path.fish.inc'; end

direnv hook fish | source

# opencode
fish_add_path $HOME/.opencode/bin

# Added by the Hunk installer (https://hunk.dev)
fish_add_path $HOME/.hunk/bin
