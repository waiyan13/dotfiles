function cat
    # bat for interactive file viewing; the real cat for pipes, for a bare
    # `cat` reading the terminal, and whenever bat is not installed.
    if isatty stdin; and type -q bat; and test (count $argv) -gt 0
        bat --paging=never $argv
    else
        command cat $argv
    end
end
