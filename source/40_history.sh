# History settings

# Allow use to re-edit a faild history substitution.

export HISTTIMEFORMAT="[%F %T] "
export HISTCONTROL=ignoreboth            # no duplicate entries
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

# up and down arrow searches history from input.

# bind '"\e[A": history-search-backward'
# bind '"\e[B": history-search-forward'

alias timestamp="date -d 'today' +'%Y-%m-%d_%H:%M:%S'"

function cleanhistory() {
    mkdir -p $HOME/.backup
    BACKUP=$HOME/.backup/.bash_history_$(timestamp).backup
    cp $HOME/.bash_history $BACKUP
    NEW_HISTORY=$(cat $HOME/.bash_history)
    for REMOVETERM in $@; do
            NEW_HISTORY=$(echo "$NEW_HISTORY" | grep -vi "$REMOVETERM")
    done
    NEW_HISTORY=$(echo "$NEW_HISTORY" | sed 's/ $//' |nl|sort -k2 -k1|uniq -f1|sort -n|cut -f2|grep "^.\{10,100\}$"|tac|uniq -w2|tac)
    echo "$NEW_HISTORY" > $HOME/.bash_history
    echo -e "History logs have been streamlined."
    echo -e "$(wc -l $BACKUP $HOME/.bash_history | sed -e '$d')"
}

function undo_clean_history() {
    NEWEST_BACKUP=$(ls $HOME/.backup/.bash_history_* -1t|head -n 1)
    echo -e "History cleanup rolled back."
    echo -e "$(wc -l $NEWEST_BACKUP $HOME/.bash_history | sed -e '$d')"
    mv $NEWEST_BACKUP $HOME/.bash_history
}

function search_for_terms_in_history {
    HISTTIMEFORMAT="" # we don't want timestamps. Matches are chronological anyway.
    MATCH_COLORS=('01;96' '01;93' '01;95' '01;92' '01;91' '01;94')
    LINENUMBERCOLOR='01;49'
    LINENUMBERPATTERN='^.{7}' # change this if column count changes for line numbers
    number_of_colors=${#MATCH_COLORS[@]}
    # lists command history, purging duplicates and stripping space at end of lines.
    MATCHES=$(history | grep -v '  ??' | sed 's/ $//' | sort -k2 | tac | uniq -f1 | sort -n )
    color_index=0

    for SEARCHTERM in $@; do
        (( color_index = (color_index + 1) % ${#MATCH_COLORS[@]} ))
        COLOR=${MATCH_COLORS[color_index]}
        # fixes it so that you can use ^ regexp pattern.
        SEARCHTERM=$(echo $SEARCHTERM | sed "s/^\^/\(?<=$LINENUMBERPATTERN\)/" )
        # searches and highlights searchterm with color
        MATCHES=$(echo "$MATCHES" | GREP_COLOR=$COLOR grep -P --ignore-case --color=always "$SEARCHTERM")
    done

    if [ -z $1 ]; then
        MATCHES=$(echo "$MATCHES" | tail -n 10 )
    fi

    # highlight line numbers
    MATCHES=$(echo "$MATCHES" | GREP_COLOR=$LINENUMBERCOLOR grep -P --color=always "$LINENUMBERPATTERN")

    if [ -z $1 ]; then
        echo -e "Search in bash command history."
        echo -e "Usage: ?? [terms to look for]"
        echo -e "With no arguments lists 10 newest commands from history."
        echo -e "\n$MATCHES"
    else
        if [[ $MATCHES != "" ]]; then
            TREFF=$(echo "$MATCHES" | wc -l )
            echo -e "\n$MATCHES"
        else
            TREFF=0
        fi
        echo -e "\nSearch for $@ returned $TREFF results"
    fi
}

alias ??='search_for_terms_in_history'
