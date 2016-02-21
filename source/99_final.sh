# Remove duplicates in PATH and PYTHONPATH
PATH=$(echo $PATH | sed s/:/\\n/g | sort --unique | tr '\n' ':')
PYTHONPATH=$(echo $PYTHONPATH | sed s/:/\\n/g | sort --unique | tr '\n' ':')

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
# start tmux or attach to existing session
[[ $TMUX ]] || tmux a 2>/dev/null || { sleep 0.1; tmux; }
