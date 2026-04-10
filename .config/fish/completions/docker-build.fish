complete -c docker-build -s l -l lang    -r -f -d "Language" \
    -n "not __fish_seen_argument -l lang" \
    -a "go node python"

complete -c docker-build -s v -l version -r -d "Language version" \
    -n "not __fish_seen_argument -v version" \
    -a "1.26.1 24.14.1"
