# Editing
if which nvim > /dev/null; then
  export EDITOR="nvim"
else
  export EDITOR="vim"
fi
export LESSEDIT="$EDITOR %f"
export VISUAL="$EDITOR"
# export BROWSER="/usr/bin/w3m"

set -o vi # vi keybindings in bash
