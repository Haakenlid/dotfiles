# Ubuntu-only stuff. Abort if not Ubuntu.
[[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1

# Package management
alias update="sudo apt -q update && sudo apt upgrade"
alias install="sudo apt install"
alias remove="sudo apt remove"
alias search="apt-cache search"
alias show="apt-cache show"

# Make 'less' more.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
