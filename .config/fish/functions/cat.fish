function cat
    if isatty stdin
        set argc (count $argv)
        if test $argc -eq 0
            command cat
        else
            bat --paging=never $argv
        end
    else
        command cat
    end
end
