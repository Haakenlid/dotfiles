export PROMPT_COMMAND=""

function path_remove() {
  IFS=:
  # convert it to an array
  t=($PATH)
  unset IFS
  # perform any array operations to remove elements from the array
  t=(${t[@]%%$1})
  IFS=:
  # output the new array
  echo "${t[*]}"
}

if [ "$TERM" == "xterm" ]; then
  export TERM=screen-256color
fi

