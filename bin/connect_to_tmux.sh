#!/bin/bash

# Don't run unless it's an interactive shell
# This tests if file descriptor 0 (stdin) is open
# if it's not open, we exit.
[[ -t 0 ]] || exit 0

# Also exit if the TMUX variable is set, which means that 
# the current shell session is already in tmux
[[ $TMUX ]] && exit 0

#checks if tmux is installed
which tmux > /dev/null || exit 1

# Try to attach to an existing tmux session. It that fails, we start a new one. 
# (I added s short delay, because this didn't work consistently without it) 
tmux a 2>/dev/null || { sleep 0.1; tmux; }
