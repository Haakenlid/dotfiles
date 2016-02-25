#!/bin/bash

#checks if tmux is installed
which tmux > /dev/null || exit 1

# starts tmux if needed
[[ $TMUX ]] || tmux a 2>/dev/null || { sleep 0.1; tmux; }
