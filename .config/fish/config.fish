source /usr/share/cachyos-fish-config/cachyos-config.fish

set PATH "$PATH:/opt/nvim-linux-x86_64/bin:/opt/google-cloud-sdk/bin:$HOME/.local/bin"
set CLAUDE_CODE_ENABLE_TELEMETRY 1
set OTEL_METRICS_EXPORTER "otlp"
set OTEL_LOGS_EXPORTER "otlp"
set OTEL_EXPORTER_OTLP_PROTOCOL "http/protobuf"
set OTEL_EXPORTER_OTLP_ENDPOINT "https://api.honeycomb.io"
# OTEL_EXPORTER_OTLP_HEADERS holds the Honeycomb API key.
# Set it in conf.d/secrets.fish. Git ignores that file.

# Optional but recommended — see tool details in Honeycomb
set OTEL_LOG_TOOL_DETAILS 1

starship init fish | source
mise activate fish | source

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.fish.inc' ]; . '/opt/google-cloud-sdk/path.fish.inc'; end

direnv hook fish | source

# opencode
fish_add_path $HOME/.opencode/bin

# Added by the Hunk installer (https://hunk.dev)
fish_add_path $HOME/.hunk/bin
