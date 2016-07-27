# ANSI CODES - SEPARATE MULTIPLE VALUES WITH ;
#
#  0  reset          4  underline
#  1  bold           7  inverse
#
# FG  BG  COLOR     FG  BG  COLOR
# 30  40  black     34  44  blue
# 31  41  red       35  45  magenta
# 32  42  green     36  46  cyan
# 33  43  yellow    37  47  white

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8


if [[ ! "${prompt_colors[@]}" ]]; then
  prompt_colors=(
    "36" # information color
    "37" # bracket color
    "31" # error color
    "33" # symbol color
  )

  if [[ "$SSH_TTY" ]]; then
    # connected via ssh
    prompt_colors[0]="34"
  elif [[ "$USER" == "root" ]]; then
    # logged in as root
    prompt_colors[0]="35"
  fi
fi

# Inside a prompt function, run this alias to setup local $c0-$c9 color vars.
alias prompt_getcolors='prompt_colors[9]=; local i; for i in ${!prompt_colors[@]}; do local c$i="\[\e[0;${prompt_colors[$i]}m\]"; done'

# Exit code of previous command.
function prompt_exitcode() {
  prompt_getcolors
  [[ $1 != 0 ]] && echo "$c1$END$c2$1$c9"
}

# Virtualenv
function prompt_virtualevn() {
if [[ $VIRTUAL_ENV != "" ]]
  then
      echo "$c3ⓔ $c0${VIRTUAL_ENV##*/}$c1$END"
fi
}

# Git status.
function prompt_git() {
  prompt_getcolors
  local status output flags
  status="$(git status 2>/dev/null)"
  [[ $? != 0 ]] && return;
  output="$(echo "$status" | awk '/# Initial commit/ {print "(init)"}')"
  [[ "$output" ]] || output="$(echo "$status" | awk '/# On branch/ {print $4}')"
  [[ "$output" ]] || output="$(git branch | perl -ne '/^\* (.*)/ && print $1')"
  flags="$(
    echo "$status" | awk 'BEGIN {r=""} \
      /Changes to be committed:$/        {r=r "+"}\
      /Changes not staged for commit:$/  {r=r "!"}\
      /Untracked files:$/                {r=r "?"}\
      END {print r}'
  )"
  if [[ "$flags" ]]; then
    output="$output$c3$flags"
  fi
  echo "$c3 $c0$output$c1$END"
}


function prompt_command() {
  local exit_code=$?
  local hourglass="⧗"
  #alternatives ⧖⌛
  # If the first command in the stack is prompt_command, no command was run.
  this_command=$(fc -ln -0)
  # this_command=$(history | tail -n1)
  [[ "$this_command" == "$that_command" ]] && exit_code=0
  that_command=$this_command

  # Manually load z here, after $? is checked, to keep $? from being clobbered.
  [[ "$(type -t _z)" ]] && _z --add "$(pwd -P 2>/dev/null)" 2>/dev/null

  END=" / "
  # While the simple_prompt environment var is set, disable the awesome prompt.
  [[ "$simple_prompt" ]] && PS1='\n$ ' && return

  prompt_getcolors
  # http://twitter.com/cowboy/status/150254030654939137
  PS1="\n" # empty line
  #
  PS1="$PS1$(prompt_virtualevn)"
  # ⓔ venv /
  PS1="$PS1$(prompt_git)"
  # ⓔ venv /  master /
  PS1="$PS1$c0\u$c3@$c0\h$c1"
  # ⓔ venv /  master / user@host
  PS1="$PS1:$c0\w/"
  # ⓔ venv /  master / user@host:/working/directiory/
  PS1="$PS1\n"  # line break
  #
  PS1="$PS1$c0$(date +"%H$c1:$c0%M$c1:$c0%S$c3 $hourglass $c0%Y$c1-$c0%m$c1-$c0%d")"
  # 12:49:29 ⧗ 2014-08-04
  PS1="$PS1$(prompt_exitcode "$exit_code")"
  # 12:49:29 ⧗ 2014-08-04 / 127
  PS1="$PS1 \[\e[0m\]$ "
  # PS1="$PS1 \[\e[0m\]\m " for bash 4.4
  # 12:49:29 ⧗ 2014-08-04 / 127 $
}

export PROMPT_COMMAND="prompt_command; $PROMPT_COMMAND"
