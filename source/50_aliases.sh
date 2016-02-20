# test that program exists
program_exists () {
  type "$1" &> /dev/null ;
}

# Remote servers
alias UIO='ssh -t haakenl@login.uio.no "cd /uio/kant/div-universitas-desken/; bash"'

# grep in glorious TECHNICOLOR
alias grep='grep --color=auto'

# Better python repl
alias pp="python3 $(which ptipython)"

# NEOVIM
program_exists /usr/bin/nvim && alias vim=/usr/bin/nvim

# Keyboard layout changes (only works if you have the keyboard layouts installed)
function nor() {  # Norwegian
  setxkbmap -layout no -option caps:escape
  echo 'norwegian keyboard'
}
function eng() {  # Like English – but better!
  xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/en-improved $DISPLAY >& /dev/null
  echo 'english (improved) keyboard'
}
function chromeng() {  # Like English – but better!
  xkbcomp -I$HOME/.xkb $HOME/.xkb/keymap/en-chromebook $DISPLAY >& /dev/null
  echo 'english (improved) keyboard for chromebook'
}

# print in nice color
p () {
  echo -e "\n    \e[1;33m$@\e[0m"
}

# Spotify shortcuts
if program_exists spotify; then
  alias sv='sptfy volume'  # usage v [+, ++, --, 0, 3, 4, max]
  alias sn='sptfy next'
  alias sb='sptfy back'
  alias sp='sptfy play'  # plauy / pause
fi

# remove ansi color codes. Nice for piping
alias nocolor='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'

# make a directory and cd into it
mcd () {
  mkdir -p $1 && cd $1
}

# You only live once
alias YOLO='git add -A && git commit -m "$(fortune -o | cowsay)" && git push --force'

