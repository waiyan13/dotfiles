# dotfiles

Configs for a CachyOS + Hyprland (Lua config) desktop with the fish shell.

## Layout

| Path | Target on the machine |
|---|---|
| `.config/` | `~/.config/` |
| `home/` | `~/` |

Tools with a config here: bat, delta, fish, ghostty, git, hypr (Hyprland, hypridle,
hyprlock, hyprpaper), k9s (skin only), mise, nvim, rofi, starship, waybar,
xdg-desktop-portal, and docker.

## Install on a new machine

1. Copy `.config/` into `~/.config/`:

   ```sh
   cp -r .config/. ~/.config/
   ```

2. Copy `home/` into `~/`:

   ```sh
   cp -r home/. ~/
   ```

3. Run `gh auth login`. The git config uses `gh` as the credential helper for GitHub.

## Secrets

Do not commit secrets. Git ignores `.config/fish/conf.d/secrets.fish` and
`.config/fish/fish_variables`. The docker config keeps only `credsStore` and
`psFormat`, with no `auths` block.
