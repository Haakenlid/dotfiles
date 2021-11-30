export PROMPT_COMMAND=""
export LOCATE_PATH="$HOME/.mlocate.db"
alias updatedb="updatedb -l 0 -o $LOCATE_PATH -U $HOME"

export TERM=screen-256color
export BROWSER=sensible-browser

# Use uppercase V only for edit and execute
bind -m vi-command -r 'v' 2> /dev/null
bind -m vi-command 'V':edit-and-execute-command 2> /dev/null
