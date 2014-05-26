#!/bin/bash

# Time and date
TIME=$(date +"%Y-%m-%d_%H%M%S")

# Delay before starting
DELAY=5

# Standard screencast folder
FILENAME="GIFrecord_$TIME.gif"

FOLDER="$HOME/Pictures"

# Default recording duration
DEFDUR=10

# Sound notification to let one know when recording is about to start (and ends)
beep() {
	paplay /usr/share/sounds/freedesktop/stereo/message-new-instant.oga &
}

# Duration and output file
if [ $# -gt 0 ]; then
	D="--duration=$@"
else
	echo Default recording duration 10s to /tmp/recorded.gif
	DURATION="--duration=10" 
fi

# xrectsel from https://github.com/lolilolicon/ffcast2/blob/master/xrectsel.c
ARGUMENTS=$(xrectsel "--x=%x --y=%y --width=%w --height=%h") || exit -1

FULLPATH="$FOLDER/GIFrecord_$TIME.gif"

echo Delaying $DELAY seconds. After that, byzanz will start
for (( i=$DELAY; i>0; --i )) ; do
	echo $i
	sleep 1
done
beep
byzanz-record --verbose --delay=0 ${ARGUMENTS} $DURATION "$FULLPATH"
beep
echo Screencast saved to $FULLPATH
