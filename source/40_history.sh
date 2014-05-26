# History settings

# Allow use to re-edit a faild history substitution.

export HISTTIMEFORMAT="[%F %T] "
export HISTCONTROL=ignoreboth	 # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
export HISTIGNORE="cd *:df *:exit:fg:bg:file *:ll:ls:mc:top:clear:?q:z *"

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# KEY
#    -c   Clear the history list. This may be combined with 
#         the other options to replace the history list completely.
#    -d offset 
#         Delete the history entry at position offset. 
#         offset should be specified as it appears when the history is displayed. 
#    -a   Append the new history lines (history lines entered since 
#         the beginning of the current Bash session) to the history file. 
#    -n   Append the history lines not already read from the history file 
#         to the current history list. These are lines appended to the 
#    -r   Read the current history file and append its contents to the history list. 
#    -w   Write out the current history to the history file. 
#    -p   Perform history substitution on the args and display the result 
#         on the standard output, without storing the results in the history list. 
#    -s   The args are added to the end of the history list as a single entry. 

# http://ss64.com/bash/history.html

# Easily re-execute the last history command.
alias r="fc -s"

function clean_history() {
cat ~/.bash_history > .bash_history.backup
cat ~/.bash_history|nl|sort -k2 -k1|uniq -f1|sort -n|cut -f2|grep ".\{10,20\}"|tac|uniq -w2|tac> ~/tmp/temp_history
cat ~/tmp/temp_history > ~/.bash_history
}

