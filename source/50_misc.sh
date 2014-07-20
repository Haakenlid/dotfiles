export GREP_OPTIONS='--color=auto'

# Prevent less from clearing the screen while still showing colors.
export LESS=-XR

# SSH auto-completion based on entries in known_hosts.
complete -W "$(echo $(cat ~/.bash_history | sed -n 's/^ssh \([^ ]*@[^ ]*\).*/\1/p'|sort -u))" ssh sshfs

# sets up virtualenvwrapper
export WORKON_HOME=/srv/virtual_enviroments
# export VIRTUALENVWRAPPER_LOG_DIR="$WORKON_HOME"
# export VIRTUALENVWRAPPER_HOOK_DIR="$WORKON_HOME"
source /usr/local/bin/virtualenvwrapper.sh

# export PYTHONPATH=$PYTHONPATH:/usr/bin/

# dont freeze terminal by pressing Ctrl-S
stty -ixon

# use tmux by default
# if which tmux 2>&1 >/dev/null; then
#     #if not inside a tmux session, and if no session is started, start a new session
#     test -z "$TMUX" && (tmux attach || tmux new-session)
# fi

