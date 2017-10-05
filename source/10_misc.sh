export PROMPT_COMMAND=""
export LOCATE_PATH="$HOME/.mlocate.db"
alias updatedb="updatedb -l 0 -o $LOCATE_PATH -U $HOME"

# if [ "$TERM" == "xterm" ]; then
export TERM=xterm-256color
export BROWSER=sensible-browser
# fi

