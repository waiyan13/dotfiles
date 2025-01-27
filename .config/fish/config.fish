if status is-interactive
    # Commands to run in interactive sessions can go here
    eval (zellij setup --generate-auto-start fish | string collect)
end

function cls
    builtin history clear && history -c && reset
end

function nvim
    /opt/nvim/nvim.appimage --appimage-extract-and-run
end

starship init fish | source
