-- Catppuccin Macchiato palette.
--
-- This module gives a table. Require it, then index a color:
--   local theme = require("themes.macchiato")
--   hl.config({ general = { col = { inactive_border = theme.surface0 } } })
--
-- The `rgba` table holds the same colors with a full alpha channel.
-- hyprlock reads themes/macchiato.conf, because hyprlock keeps the
-- hyprlang format. Keep the two files in step.

return {
    base     = "rgb(24273a)",
    mantle   = "rgb(1e2030)",
    crust    = "rgb(181926)",

    surface0 = "rgb(363a4f)",
    surface1 = "rgb(494d64)",
    surface2 = "rgb(5b6078)",

    overlay0 = "rgb(6e738d)",
    overlay1 = "rgb(8087a2)",
    overlay2 = "rgb(939ab7)",

    text     = "rgb(cad3f5)",
    subtext0 = "rgb(a5adcb)",
    subtext1 = "rgb(b8c0e0)",

    blue     = "rgb(8aadf4)",
    sapphire = "rgb(7dc4e4)",
    sky      = "rgb(91d7e3)",
    teal     = "rgb(8bd5ca)",
    green    = "rgb(a6da95)",
    yellow   = "rgb(eed49f)",
    peach    = "rgb(f5a97f)",
    red      = "rgb(ed8796)",
    mauve    = "rgb(c6a0f6)",
    pink     = "rgb(f5bde6)",
    lavender = "rgb(b7bdf8)",

    rgba = {
        base     = "rgba(24273aff)",
        mantle   = "rgba(1e2030ff)",
        crust    = "rgba(181926ff)",

        surface0 = "rgba(363a4fff)",
        surface1 = "rgba(494d64ff)",
        surface2 = "rgba(5b6078ff)",

        overlay0 = "rgba(6e738dff)",
        overlay1 = "rgba(8087a2ff)",
        overlay2 = "rgba(939ab7ff)",

        text     = "rgba(cad3f5ff)",
        subtext0 = "rgba(a5adcbff)",
        subtext1 = "rgba(b8c0e0ff)",

        blue     = "rgba(8aadf4ff)",
        sapphire = "rgba(7dc4e4ff)",
        sky      = "rgba(91d7e3ff)",
        teal     = "rgba(8bd5caff)",
        green    = "rgba(a6da95ff)",
        yellow   = "rgba(eed49fff)",
        peach    = "rgba(f5a97fff)",
        red      = "rgba(ed8796ff)",
        mauve    = "rgba(c6a0f6ff)",
        pink     = "rgba(f5bde6ff)",
        lavender = "rgba(b7bdf8ff)",
    },

    transparent = "rgba(00000000)",
}
