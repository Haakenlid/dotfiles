export PROMPT_COMMAND=""
export LOCATE_PATH="$HOME/.mlocate.db"
alias updatedb="updatedb -l 0 -o $LOCATE_PATH -U $HOME"

if [ "$TERM" == "xterm" ]; then
  export TERM=screen-256color
fi

