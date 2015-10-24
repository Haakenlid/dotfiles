# Remote servers
alias UIO='ssh -t haakenl@login.uio.no "cd /uio/kant/div-universitas-desken/; bash"'
alias grep='grep --color=auto'

# Keyboard changes
function nor() {
  setxkbmap -layout no -option caps:escape
  echo 'norwegian keyboard'
}
function eng() {
  xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/en-improved $DISPLAY >& /dev/null
  echo 'english (improved) keyboard'
}

program_exists () {
  # test that program exists
  type "$1" &> /dev/null ;
}

# Spotify shortcuts
if program_exists spotify; then
  alias sv='sptfy volume'  # usage v [+, ++, --, 0, 3, 4, max]
  alias sn='sptfy next'
  alias sb='sptfy back'
  alias sp='sptfy play'  # plauy / pause
fi

alias nocolor='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'

mcd () {
  mkdir -p $1 && cd $1
}
