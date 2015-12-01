# Files will be created with these permissions:
# files 644 -rw-r--r-- (666 minus 022)
# dirs  755 drwxr-xr-x (777 minus 022)
umask 002

export LS_COLORS='di=33:ln=01;32:pi=40;33:bd=40;33:cd=33;01:ow=40;33:ex=35;01:'
alias ls="command ls --color"
alias info="info --vi-keys"
# alias lesser="less -MF~ +G" # less with page break etc.
function lesser(){
  lesserin=$(cat) # Input from pipe
  win_height=$(tput lines)
  input_height=$(echo -e "$lesserin" | wc -l)
  if [[ $win_height -ge $input_height ]]; then
    echo -e "$lesserin"
  else
    # echo -e "$lesserin" > ~/.lessertmp
    # less -MX +Gg ~/.lessertmp
    echo -e "$lesserin" | less -MX +Gg
    # rm ~/.lessertmp
  fi
}
function LL() {
  ls -AlFh --time-style=+"%Y-%m-%d %H:%M" "$@"
}

function ll() {
LL "$@" |\
    awk '
BEGIN {
lsformat = "%s [%4.4s:%4.4s] %4.4s [%s] %s %s\n"
gsub(/\[/, "\033[0;49;93m", lsformat)
gsub(/\]/, "\033[0m", lsformat)}
{if (NR!=1){
    printf lsformat,
    $1,$3,$4,$5,$6,$7,substr($0, index($0,$8))}
}' | lesser
}

alias lsd='CLICOLOR_FORCE=1 ll | grep --color=never "^d"'
alias tree="tree -CF --dirsfirst"
function tre(){
  tree -L 2 $@ --filelimit 100 | lesser
}

# Easier navigation: .., ..., -
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

# File size
alias fs="stat -c '%s bytes'"
alias df="df -h"

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}

# Fast directory switching
_Z_NO_PROMPT_COMMAND=1
_Z_DATA=$DOTFILES/caches/.z
. $DOTFILES/libs/z/z.sh
