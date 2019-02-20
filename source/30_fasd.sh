# Fasd (pronounced similar to "fast") is a command-line productivity booster.
# Fasd offers quick access to files and directories for POSIX shells. It is
# inspired by tools like autojump, z and v. Fasd keeps track of files and
# directories you have accessed, so that you can quickly reference them in the
# command line.
unalias z
z() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
  else
    _last_z_args="$@"
    _z "$@"
  fi
}

zz() {
  cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")"
}
