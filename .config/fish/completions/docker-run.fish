complete -c docker-run -s b -l label -r -f -d "Label" \
    -n "not __fish_seen_argument -o label" \
    -a "logging=promtail"

complete -c docker-run -s i -l ip -r -f -d "IP address" \
    -n "not __fish_seen_argument -o ip" \
    -a "10.101.1.0"

complete -c docker-run -s o -l org -r -f -d "Organization" \
    -n "not __fish_seen_argument -o org" \
    -a "ventra vaudit"

complete -c docker-run -s l -l lang    -r -f -d "Language" \
    -n "not __fish_seen_argument -l lang" \
    -a "go node python"

complete -c docker-run -s n -l network -r -d "Docker network" \
    -n "not __fish_seen_argument -n network" \
    -a "ventra vaudit"

complete -c docker-run -s p -l project -r -d "Project name" \
    -n "not __fish_seen_argument -p project" \
    -a "account_api"

complete -c docker-run -s r -l port    -r -d "Port to expose" \
    -n "not __fish_seen_argument -r port" \
    -a "8080 3000"

complete -c docker-run -s v -l version -r -d "Language version" \
    -n "not __fish_seen_argument -v version" \
    -a "1.26.1 24.14.1"
