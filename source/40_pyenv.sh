# Load pyenv automatically by adding
# the following to ~/.bashrc:
if [[ -e $HOME/.pyenv ]]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
