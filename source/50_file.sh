# Files will be created with these permissions:
# files 644 -rw-r--r-- (666 minus 022)
# dirs  755 drwxr-xr-x (777 minus 022)
umask 002

export LS_COLORS='di=33:ln=01;32:pi=40;33:bd=40;33:cd=33;01:ow=40;33:ex=35;01:'
alias ls="command ls --color"
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
    echo -e "$lesserin" | less -MX +G
    # rm ~/.lessertmp
  fi
}
function LL() {
  ls -AlFh --time-style=+"%Y-%m-%d %H:%M" "$@"
}

function ll() {
LL "$@" | sed "s/^\([dlrwxst-]*\)[ 0-9]\+\(\S...\).* \(\S...\).*\?\(....\) \(....-..-..\) \(..:..\)"\
"/\x1b[0m\1  \x1b[97m\2 \x1b[0m\3  \x1b[97m\4  \x1b[0m\5 \x1b[97m\6\x1b[0m/"\
| lesser
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
