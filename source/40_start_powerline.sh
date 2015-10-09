# Enables powerline support for tmux and bash
# must be started before prompt.
export POWERLINE_NO_BASH_PROMPT="True"
export POWERLINE_PATH="$DOTFILES/libs/powerline"
export PATH="$POWERLINE_PATH/scripts:$PATH"
source "$POWERLINE_PATH/powerline/bindings/bash/powerline.sh"
