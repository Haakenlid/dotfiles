# Remove duplicates in PATH and PYTHONPATH

function uniqpath() {
  printf $(printf ":$@:" | awk -v RS=: -v ORS=: 'NF && !a[$0]++')
}

export GOPATH="$HOME/.go"
PATH="$PATH:$HOME/.local/bin:$HOME/.npm/bin/:$GOPATH"
PATH=$(uniqpath $PATH)
PYTHONPATH=$(uniqpath $PYTHONPATH)

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# reset terminal settings in interactive session
if [[ $- == *i* ]]; then
  stty sane -ixon
  # -ixon = don't freeze terminal by pressing Ctrl-S
fi
