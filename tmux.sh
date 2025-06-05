#!/bin/bash

SESH="staticsite_sesh"

tmux has-session -t $SESH 2>/dev/null

if [ $? != 0 ]; then
    tmux new-session -d -s $SESH -n "editor"

    # setup main editor
    tmux send-keys -t $SESH:editor "cd ~/Projects/ArnoCuyvers/staticSite" C-m
    tmux send-keys -t $SESH:editor "nvim ." C-m

    # setup liveserver
    tmux new-window -t $SESH -n "live-server"
    tmux send-keys -t $SESH:live-server "cd ~/Projects/ArnoCuyvers/staticSite" C-m
    tmux send-keys -t $SESH:live-server "live-server ." C-m

    # normal cli
    tmux new-window -t $SESH -n "cli"
    tmux send-keys -t $SESH:cli "cd ~/Projects/ArnoCuyvers/staticSite" C-m
    
    tmux select-window -t $SESH:editor
fi

tmux attach-session -t $SESH
