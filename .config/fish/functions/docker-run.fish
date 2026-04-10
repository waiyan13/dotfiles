function docker-run
    set projects_dir $HOME/Projects

    set -l opts \
        'b/label=' \
        'i/ip=' \
        'o/org=' \
        'l/lang=' \
        'n/network=' \
        'p/project=' \
        'r/port=' \
        'v/version=' \

    argparse $opts -- $argv
    or return

    for f in _flag_org _flag_lang _flag_network _flag_project _flag_port _flag_version
        if not set -q $f
            echo "Missing required flag: $f"
            return 1
        end
    end

    docker run \
        --interactive \
        --tty \
        --mount type=bind,source=$projects_dir,target=/home/dev/Projects \
        --name dev_{$_flag_org}_{$_flag_project}_{$_flag_lang}_{$_flag_version} \
        --network $_flag_network \
        --ip $_flag_ip \
        --label $_flag_label \
        --entrypoint /usr/bin/zsh \
        --publish $_flag_port:$_flag_port/tcp \
        dev_env_{$_flag_lang}_{$_flag_version}:latest
end
