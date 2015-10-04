# Enables powerline support for tmux and bash
# must be started before prompt.
export POWERLINE_NO_BASH_PROMPT="True"
export POWERLINE_PATH="$HOME/.dotfiles/libs/powerline"
source "$POWERLINE_PATH/powerline/bindings/bash/powerline.sh"
export PATH="$POWERLINE_PATH/scripts:$PATH"
