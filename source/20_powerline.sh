# Enables powerline support for tmux and bash
export POWERLINE_NO_BASH_PROMPT="True"
export PROMPT_COMMAND="$PROMPT_COMMAND _powerline_tmux_set_pwd;"

source /home/haakenlid/.local/lib/python3.4/site-packages/powerline/bindings/bash/powerline.sh
