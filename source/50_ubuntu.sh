# Ubuntu-only stuff. Abort if not Ubuntu.
[[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1

# Package management
alias update="sudo apt -q update && sudo apt upgrade"
alias installit="sudo $HOME/.dotfiles/bin/install.sh"
alias uninstallit="sudo apt remove -y"
function search(){
  apt search $@ | less
}
alias show="apt-cache show"

# Make 'less' more.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
