# Fasd (pronounced similar to "fast") is a command-line productivity booster.
# Fasd offers quick access to files and directories for POSIX shells. It is
# inspired by tools like autojump, z and v. Fasd keeps track of files and
# directories you have accessed, so that you can quickly reference them in the
# command line.

# https://github.com/clvv/fasd

# alias a='fasd -a'        # any
# alias s='fasd -si'       # show / search / select
# alias d='fasd -d'        # directory
# alias f='fasd -f'        # file
# alias sd='fasd -sid'     # interactive directory selection
# alias sf='fasd -sif'     # interactive file selection
# alias z='fasd_cd -d'     # cd, same functionality as j in autojump
# alias zz='fasd_cd -d -i' # cd with interactive selection

fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

_fasd_bash_hook_cmd_complete z

if which nvim &> /dev/null; then
  alias v=nfasd
else
  alias v='fasd -f -t -b viminfo -e vim'
  alias vv='fasd -f -t -b viminfo -e vim -i'
fi
fasd_cd() {
  if [[ -z $1 ]] 
  then CD_DIR=$(fasd -d -i)
  else CD_DIR=$(fasd $@)
  fi
  [[ -n $CD_DIR ]] && cd $CD_DIR
}
alias z='fasd_cd'
alias zz='fasd_cd -d -i'
