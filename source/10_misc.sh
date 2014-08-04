export PROMPT_COMMAND=""

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
<<<<<<< HEAD
	# To restart unity when hacking settings.
	killall unity-panel-service
	setsid unity
}

alias tree="tree -AF --dirsfirst -L 5 --filelimit 100"
=======
	killall unity-panel-service
	setsid unity
}
>>>>>>> origin
