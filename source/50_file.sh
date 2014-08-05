# Files will be created with these permissions:
# files 644 -rw-r--r-- (666 minus 022)
# dirs  755 drwxr-xr-x (777 minus 022)
umask 022

alias ls="command ls --color"
export LS_COLORS='di=33:ln=01;32:pi=40;33:bd=40;33:cd=33;01:ow=40;33:ex=35;01:'

# Directory listing
# alias ll='tree -tapughDFiCL 1 --dirsfirst --timefmt "%Y-%m-%d %H:%M"'
alias ll='ls -alFh --time-style=+"%Y-%m-%d %H:%M"'
alias tree='tree -CFL 2 --dirsfirst'
alias lsd='CLICOLOR_FORCE=1 ll | grep --color=never "^d"'

# Easier navigation: .., ..., -
alias ..='cd ..'
alias ...='cd ../..'
alias -- -='cd -'

# File size
alias fs="stat -f '%z bytes'"
alias df="df -h"

# Recursively delete `.DS_Store` files
alias dsstore="find . -name '*.DS_Store' -type f -ls -delete"

# Aliasing eachdir like this allows you to use aliases/functions as commands.
alias eachdir=". eachdir"

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}

# Fast directory switching
_Z_NO_PROMPT_COMMAND=1
_Z_DATA=~/.dotfiles/caches/.z
. ~/.dotfiles/libs/z/z.sh
