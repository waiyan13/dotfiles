function docker-build
    set build_args

    for line in (cat .env)
        set --append build_args --build-arg $line
    end

    argparse 'f/force' 'l/lang=' 'v/version=' -- $argv
    or return

    set required_flags _flag_lang _flag_version

    for f in $required_flags
        if not set -q $f
            echo "Missing required flags: "(string replace '_flag_' '--' $f)
            return 1
        end
    end

    set build_extra
    if set -q _flag_force
        set build_extra --no-cache
    end

    docker buildx build \
        --file Dockerfile-{$_flag_lang} \
        --tag dev_env_{$_flag_lang}_{$_flag_version}:latest \
        $build_args \
        $build_extra \
        .
end
