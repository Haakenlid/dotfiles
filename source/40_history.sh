# History settings

export HISTTIMEFORMAT="[%F %T] "
export HISTCONTROL=ignoreboth            # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
export HISTIGNORE="cd *:df *:exit:fg:bg:file *:ll:ls:mc:top:clear:?q:z *:\?\?"

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

# up and down arrow searches history from input.

# bind '"\e[A": history-search-backward'
# bind '"\e[B": history-search-forward'

alias timestamp="date -d 'today' +'%Y-%m-%d_%H:%M:%S'"

function cleanhistory() {
    local HISTORY="$HOME/.bash_history"
    local BACKUP="$HOME/.backup/.bash_history_$(timestamp).backup"
    local NEW_HISTORY=$(cat $HISTORY)
    for REMOVETERM in $@; do
        NEW_HISTORY=$(echo "$NEW_HISTORY" | grep -vi "$REMOVETERM")
    done
    NEW_HISTORY=$(echo "$NEW_HISTORY"|sed 's/ *$//'|tac|nl -n rz|sort -k2 -k1|uniq -f1|sort -n|cut -f2|grep "^.\{10,200\}$"|uniq -w2|tac )
    mkdir -p $HOME/.backup
    cp "$HISTORY" "$BACKUP"
    echo "$NEW_HISTORY" > "$HISTORY"

    echo -e "$(wc -l $BACKUP $HISTORY | sed -e '$d')"
    echo -e "History logs have been streamlined."
}

function undo_cleanhistory() {
    local HISTORY="$HOME/.bash_history"
    local NEWEST_BACKUP=$(ls $HOME/.backup/.bash_history_* -1t|head -n 1)

    echo -e "$(wc -l $NEWEST_BACKUP $HISTORY | sed -e '$d')"
    mv "$NEWEST_BACKUP" "$HISTORY"
    echo -e "History cleanup rolled back."
}

function search_for_terms_in_history {
    local HISTORY_FILE="$HOME/.bash_history"
    local TEMP_HISTORY_FILE="/tmp/.bash_history"
    local MATCH_COLORS=( '01;49;33' '01;49;31' '01;49;32' '01;49;35' '01;49;34' '01;49;36' )
    local LINENUMBERCOLOR='01;49;39'
    local COLOR_INDEX=0
    local SEARCHTERMS=''
    local HITS_LENGTH=0
    local DELIMITER='#CACHE'
    # lists command history, purging duplicates and stripping space at end of lines.
    local RESULT=$(HISTTIMEFORMAT='' history | sed 's/^ *[0-9]*//'| nl -n rz | sed 's/ \+$//' | sort -k2 | tac | uniq -f2 | sort | tac )
    # prepares history for searching.
    local HITS=$(echo "$RESULT" | sed 's/\s*[0-9]*\s\+//' | grep -v '^??' )
    for SEARCHTERM in $@; do
        # uses different color for each search term.
        local COLOR=${MATCH_COLORS[COLOR_INDEX]}
        (( COLOR_INDEX = (COLOR_INDEX + 1) % ${#MATCH_COLORS[@]} ))
        # searches and highlights searchterm with color
        HITS=$(echo "$HITS" | GREP_COLOR=$COLOR grep -Pi --color=always "$SEARCHTERM")
        # uses same color for summary.
        SEARCHTERMS+=' \e['$COLOR'm'$SEARCHTERM
    done

    if [ -z $1 ]; then
        # no searchterm - lets just display last ten entries.
        RESULT=$(history | tail -n 10 )
    else
        RESULT=$( echo "$HITS" | nl --number-width=3 --number-separator='  ' | tac )
        # prepend to .bash_history so you can type !1 instead of !3412 to replay.
        echo "$HITS" | sed -r 's/\x1b\[[0-9;]*[Km]//g' > "$TEMP_HISTORY_FILE"
        echo "$DELIMITER" >> "$TEMP_HISTORY_FILE"
        if [[ $(grep "$DELIMITER" "$HISTORY_FILE") ]]; then
            cat "$HISTORY_FILE" | sed "0,/^$DELIMITER$/d" >> "$TEMP_HISTORY_FILE"
        else
            cat "$HISTORY_FILE" >> "$TEMP_HISTORY_FILE"
        fi
        mv -f "$TEMP_HISTORY_FILE" "$HISTORY_FILE"
        # shows same numbers in output
    fi
    # highlight line numbers
    RESULT=$(echo "$RESULT" | sed 's/\([1-9]\)/!\1/' | GREP_COLOR=$LINENUMBERCOLOR grep -P --color=always '^ *[0-9!]+')
    if [ -z $1 ]; then
        echo -e "Search in bash command history."
        echo -e "Usage: ?? [terms to look for]"
        echo -e "With no arguments lists 10 newest commands from history."
        echo
        echo -e "$RESULT"
    else
        if [[ $RESULT != "" ]]; then
            HITS_LENGTH=$(echo "$RESULT" | wc -l )
            echo -e "\e["$LINENUMBERCOLOR"m"
            echo -e "$RESULT"
        fi
        echo -e "\nSearch for$SEARCHTERMS\e[0m returned $HITS_LENGTH hits."
    fi
}

alias ??='search_for_terms_in_history'
