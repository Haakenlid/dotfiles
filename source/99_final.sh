# Remove duplicates in PATH and PYTHONPATH
export GOPATH="$HOME/.go"
PATH="$PATH:$HOME/.npm-packages/bin/:$GOPATH"
PATH=$(echo $PATH | sed s/:/\\n/g | sort --unique | tr '\n' ':')
PYTHONPATH=$(echo $PYTHONPATH | sed s/:/\\n/g | sort --unique | tr '\n' ':')

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
