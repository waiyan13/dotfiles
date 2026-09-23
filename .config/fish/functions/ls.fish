function ls --wraps='eza --icons=auto' --description 'alias ls=eza --icons=auto'
    if type -q eza
        eza --icons=auto $argv
    else
        command ls $argv
    end
end
