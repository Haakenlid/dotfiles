# Editing
export EDITOR='vim -w'
export LESSEDIT='vim %f'
export GIT_EDITOR='vim'
export VISUAL='vim'
alias q='subl'
alias q.='q .'
set -o vi # vim keybindings in bash


function qs() {
  pwd | perl -ne"s#^$(echo ~/.dotfiles)## && exit 1" && cd ~/.dotfiles
  q ~/.dotfiles
}
