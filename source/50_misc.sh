# Prevent less from clearing the screen while still showing colors.
export LESS=-XRsiM
export PAGER=/bin/less
export MANPAGER=/bin/less
export CDPATH=.:$HOME:/srv

# SSH auto-completion based on entries in history.
complete -W "$(echo $(cat ~/.bash_history | sed -n 's/^ssh \([^ ]*@[^ ]*\).*/\1/p'|sort -u))" ssh sshfs

if [[ -e /usr/local/bin/virtualenvwrapper_lazy.sh ]]; then
  source /usr/local/bin/virtualenvwrapper_lazy.sh
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

