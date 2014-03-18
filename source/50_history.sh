# History settings

# Allow use to re-edit a faild history substitution.
# shopt -s histreedit
# History expansions will be verified before execution.
# shopt -s histverify

export HISTTIMEFORMAT="[%F %T] "
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


# Easily re-execute the last history command.
alias r="fc -s"
