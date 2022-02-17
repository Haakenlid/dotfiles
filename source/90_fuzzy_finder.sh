# where fzf files should be
FZFPATH="$HOME/.fzf"

# return if fzf is not installed
if [[ ! -d  $FZFPATH ]]; then
  function fzf() {
    read -n 1 -p "Install fzf? (y/n) " answer
    [[ $answer == "y" ]] || return
    echo
    unset -f fzf  # remove this function
    git clone --depth 1 https://github.com/junegunn/fzf.git $FZFPATH
    $FZFPATH/install --bin  # install binary only
    echo 'Install complete! run `src` to source config'
  }
else
  # Setup fzf
  # ---------
  if [[ ! "$PATH" =~ "$FZFPATH/bin" ]]; then
    export PATH="$PATH:$FZFPATH/bin"
  fi
  # Auto-completion
  # ---------------
  [[ $- == *i* ]] && source "$FZFPATH/shell/completion.bash" 2> /dev/null

  # Key bindings
  # ------------
  source "$FZFPATH/shell/key-bindings.bash"
  export FZF_DEFAULT_COMMAND='rg -g !.git -g !*.pyc -g !__pycache__ -g !node_modules --no-ignore --files --hidden --follow 2> /dev/null'
  PREVIEW='file {}; [[ $(file -L --mime {}) =~ binary ]] &&  hd -n1024 {} ||
    highlight --failsafe -O ansi {} 2> /dev/null | head -100'
  export FZF_DEFAULT_OPTS="--reverse --inline-info --height=40"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_CTRL_T_OPTS="--preview '${PREVIEW}'"
fi

