function docker-build
    set build_args

    for line in (cat .env)
        set --append build_args --build-arg $line
    end

    docker buildx build \
        --file Dockerfile-$argv[1] \
        --tag dev_env_$argv[1]_$argv[2]:latest \
        $build_args \
        .

end
