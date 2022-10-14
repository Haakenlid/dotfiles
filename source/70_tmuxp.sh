_tmuxp_completion() {
  local IFS=$'\n'
  local response

  response=$(env COMP_WORDS="${COMP_WORDS[*]}" COMP_CWORD=$COMP_CWORD _TMUXP_COMPLETE=bash_complete tmuxp)

  for completion in $response; do
    IFS=',' read type value <<< "$completion"

    if [[ $type == 'dir' ]]; then
      COMREPLY=()
      compopt -o dirnames
    elif [[ $type == 'file' ]]; then
      COMREPLY=()
      compopt -o default
    elif [[ $type == 'plain' ]]; then
      COMPREPLY+=($value)
    fi
  done

  return 0
}

_tmuxp_completion_setup() {
  complete -o nosort -F _tmuxp_completion mux
}


if command -v tmuxp > /dev/null; then
  export TMUXP_CONFIGDIR="$HOME/.mux/"
  _tmuxp_completion_setup tmuxp;

  # alias function. Allows shorthand loading similart to tmuxinator
  # mux foobar -> tmux load -y foobar
  # mux edit foobar -> tmux edit foobar
  mux() {
    if [[ $# -eq 1 ]] && tmuxp ls | grep -qx "$1"; then
      tmuxp load -y $1
    else
      tmuxp "$@"
    fi
  }
fi
