# dotfiles

Configs for a CachyOS + Hyprland (Lua config) desktop and a macOS machine,
both with the fish shell.

## Layout

| Path | Target on the machine |
|---|---|
| `.config/` | `~/.config/` |
| `home/` | `~/` |

Tools with a config here: bat, delta, fish, ghostty, git, hypr (Hyprland, hypridle,
hyprlock, hyprpaper), k9s (skin only), mise, nvim, rofi, starship, waybar,
xdg-desktop-portal, and docker.

## Platforms

Most configs work on both machines. The split is handled in two places:

- **Whole configs that only Linux uses** — hypr, rofi, waybar and
  xdg-desktop-portal are Wayland/Hyprland, so `install.sh` skips them on macOS.
  `home/` is skipped there too: it holds only the docker config, whose
  `credsStore` is `pass`, the Linux password store. macOS uses `osxkeychain`,
  and Docker writes its own context and plugin paths into that file.
- **Per-OS ghostty settings** — `config.ghostty` ends with
  `config-file = ?os.conf`, and `install.sh` writes `os.conf` from
  `os-linux.conf` or `os-macos.conf`. An included file loads after the file
  that includes it, so `os.conf` overrides the shared values. Linux drops the
  decorations for Hyprland; macOS keeps them, because native fullscreen needs
  them, and bumps the font size.
- **Per-OS shell setup** — `.config/fish/conf.d/10-linux.fish` and
  `10-macos.fish` guard on `uname`. Fish sources `conf.d/` before `config.fish`,
  so PATH is set before the shared file runs. `config.fish` itself is shared and
  guards every tool with `type -q`, so a machine missing a tool still starts.

## Install on a new machine

1. Run the installer. It copies the shared configs, adds the Linux-only ones on
   Linux, and copies `home/` into `~/`:

   ```sh
   ./install.sh
   ```

2. Run `gh auth login`. The git config uses `gh` as the credential helper for GitHub.

## Secrets

Do not commit secrets. Git ignores `.config/fish/conf.d/secrets.fish` and
`.config/fish/fish_variables`. The docker config keeps only `credsStore` and
`psFormat`, with no `auths` block.
