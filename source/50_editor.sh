# Editing
export EDITOR='subl -w'
export LESSEDIT='subl %f'
alias q='subl'
export VISUAL="$EDITOR"
alias q.='q .'

function qs() {
  pwd | perl -ne"s#^$(echo ~/.dotfiles)## && exit 1" && cd ~/.dotfiles
  q ~/.dotfiles
}
