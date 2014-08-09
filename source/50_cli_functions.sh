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
  # sets tmux session title
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
    if [[ $1 ]]; then
      case $1 in
        "-r")
          unset GOOGLE_USER GOOGLE_PASSWORD
          echo Your username and password have been cleared.
          return 0
          ;;
        *)
          echo "Display a summary of unread gmail. Enter 'gmail -r' to reset username and password."
          return 1
        ;;
      esac
    fi

    if [[ -z $GOOGLE_USER ]]; then
      read -p 'username:  ' GOOGLE_USER
    fi

    if [[ ! $GOOGLE_USER =~ @ ]]; then
      GOOGLE_USER="$GOOGLE_USER"@gmail.com
    fi

    if [[ -z $GOOGLE_PASSWORD ]]; then
      read -p 'password:  ' GOOGLE_PASSWORD # to hide password input use "read -s -p"
    fi

    LOGIN="$GOOGLE_USER":"$GOOGLE_PASSWORD"
    echo -e "\nFetching new mail from $GOOGLE_USER\n"

    OUTPUT=$(curl -u $LOGIN --silent "https://mail.google.com/mail/feed/atom")

    LOGIN_FAILED=$(echo $OUTPUT | grep -i '<TITLE>Unauthorized</TITLE>')
    if [[ $LOGIN_FAILED ]]; then
      echo "ERROR: Login failed. Please check your username and password."
      unset GOOGLE_USER GOOGLE_PASSWORD
      return 1
    fi

    OUTPUT=$(
      echo "$OUTPUT" \
      | awk '
          BEGIN {
            FS="[<>]"                                        # FS = Field separator
            RS="(</entry>)?<entry>"                          # RS = Record separator
          }
          NR!=1{
            print "\033[0;93m" $27 "   \033[0;32m(" $31 ")"  # $27 = Name $31 = Email
            print "\033[1;37m" $3                            # $3 = Subject
            print "\033[0;96m" $7  " [...] \033[0m"          # $7 = Body extract
          }
      '
    )

  if [[ -z $OUTPUT ]]; then
    echo 'No new email'
  elif (( $(echo "$OUTPUT" | wc -l ) > 20 )); then
    echo -e "$OUTPUT" | less
  else
    echo -e  "$OUTPUT"
  fi
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


function wp(){
  COLUMNS=`tput cols`
  dig +short txt ${1}.wp.dg.cx | sed -e 's/" "//g' -e 's/^"//g' -e 's/"$//g' -e 's/ http:/\n\nhttp:/' | fmt -w $COLUMNS
}