export GREP_OPTIONS='--color=auto'

# Prevent less from clearing the screen while still showing colors.
export LESS=-XR

# SSH auto-completion based on entries in history.
complete -W "$(echo $(cat ~/.bash_history | sed -n 's/^ssh \([^ ]*@[^ ]*\).*/\1/p'|sort -u))" ssh sshfs

if [[ -e /usr/local/bin/virtualenvwrapper.sh ]]; then
  source /usr/local/bin/virtualenvwrapper.sh
  export WORKON_HOME=~/.virtualenvs/
  export VIRTUALENVWRAPPER_LOG_DIR="$WORKON_HOME"
  export VIRTUALENVWRAPPER_HOOK_DIR="$WORKON_HOME"
fi

export PYTHONPATH="$PYTHONPATH:/usr/bin/"

# access npm packages intalled in home
# npm config set prefix '~/.npm-packages'
export PATH="$PATH:$HOME/.npm-packages/bin"

# dont freeze terminal by pressing Ctrl-S
stty -ixon >& /dev/null

# use tmux by default
# if which tmux 2>&1 >/dev/null; then
#     #if not inside a tmux session, and if no session is started, start a new session
#     test -z "$TMUX" && (tmux attach || tmux new-session)
# fi

