#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage $) DIR"
    exit 1
fi
if ! [ -d "$1" ]; then
    echo "$1 is not a directory"
    exit 1
fi


TPID="$(ps -o ppid= $PPID | tr -d ' ')" # Terminal PID
T="$(awk '{print $2}' "/proc/$TPID/stat" | sed 's/(\|)//g')" # Terminal name

set +m
CMD="sh -c cd $1;$T"


eval nohup "$CMD" 1>/dev/null 2>/dev/null </dev/null &
eval nohup "$CMD" 1>/dev/null 2>/dev/null </dev/null &

kill "$TPID"
