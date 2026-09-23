function ls --wraps='eza -al --color=always --group-directories-first --icons' --wraps='eza --icons=auto' --description 'alias ls=eza --icons=auto'
    eza --icons=auto $argv
end
