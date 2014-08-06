export PROMPT_COMMAND=""
unset PROMPT_COMMAND_CHANGED

function path_remove() {
  IFS=:
  # convert it to an array
  t=($PATH)
  unset IFS
  # perform any array operations to remove elements from the array
  t=(${t[@]%%$1})
  IFS=:
  # output the new array
  echo "${t[*]}"
}

if [ "$TERM" == "xterm" ]; then
    export TERM=screen-256color
fi

function tit() {
	# sets terminal window title
	TITLE=${1:-`pwd`}
	echo -en "\033]0;$TITLE\a"
	# echo $TITLE
}

function wtit() {
	# sets tmux window title
	TITLE=${1:-`pwd`}
	printf '\033k'$TITLE'\033\\'
	# echo $TITLE
}

function stit() {
	# sets tmux window title
	TITLE=${1:-`pwd`}
	tmux rename-session $TITLE
	# echo $TITLE
}

#Vim-style exit
alias :q=exit

function unity-restart(){
	# To restart unity when hacking settings.
	killall unity-panel-service
	setsid unity
}

#Show gmail inbox headers
function gmail(){
    curl -u $GMU:$GPW --silent "https://mail.google.com/mail/feed/atom"\
    | awk 'BEGIN{
    FS="[<>]";
    RS="(</entry>)?<entry>"}
    NR!=1{print\
        "\n\033[1;32m"$27"   \033[0;32m("$31")"\
        "\n\033[1;37m"$3\
        "\n\033[0;37m"$7"\033[0m"}'\
    | less
}


function colormap(){
    #Background
    for clbg in {40..47} {100..107} 49 ; do
        #Foreground
        for clfg in {30..37} {90..97} 39 ; do
            #Formatting
            for attr in 0 1 2 4 5 7 ; do
                #Print the result
                echo -en "\e[${attr};${clbg};${clfg}m ^[${attr};${clbg};${clfg}m \e[0m"
            done
            echo #Newline
        done
    done
}
