#!/bin/bash
cd projects/frontiir/local-dev-setup
dcp up -d mongo nginx python node

tmux new-session -s dev -d -n git
tmux new-window -t dev:2 -n mongo
tmux new-window -t dev:3 -n nginx
tmux new-window -t dev:4 -n python
tmux new-window -t dev:5 -n node

tmux select-window -t dev:1
tmux -2 attach-session -t dev
