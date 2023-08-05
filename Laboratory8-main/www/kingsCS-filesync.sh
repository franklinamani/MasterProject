#!/bin/bash
SLEEPTIME=60

WAITCMD="inotifywait -t $SLEEPTIME -qq -r -e modify,create,delete $1"
inotifywait -qq -t1 / &>/dev/null

if [ $? -ne 2 ]; then
  WAITCMD="sleep $SLEEPTIME"
fi

while true; do
  $WAITCMD
  rsync -aq $1 $2 --delete-after &>/dev/null &
done