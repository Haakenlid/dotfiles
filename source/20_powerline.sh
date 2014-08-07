# Enables powerline support for tmux and bash
export POWERLINE_NO_BASH_PROMPT="True"

if [ -z "$PROMPT_COMMAND_CHANGED" ]; then
  # Maintain a per-execution call stack.
  export PROMPT_COMMAND="$PROMPT_COMMAND powerline_command;"
  # export PROMPT_COMMAND_CHANGED=1
  source /home/haakenlid/.local/lib/python3.4/site-packages/powerline/bindings/bash/powerline.sh
fi

function powerline_command(){
  # add powerline tmux support for updated virtualenv and shit.
  # set timeout and suppress error warnings :)
  timeout -k 3 1 _powerline_tmux_set_pwd 2>/dev/null
}
