# Load pyenv automatically by adding
# the following to ~/.bashrc:

export PYENV_ROOT="$HOME/.pyenv"

if [[ -e $PYENV_ROOT ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

