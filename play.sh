#!/bin/sh

if [ -z "$1" ];then
    echo "USAGE: play FILE SPEED"
fi

if [ -z "$2" ]; then
    SPEED=1.5
else
    SPEED="$2"
fi


ffplay "$1" -af "atempo=$SPEED" -vf "setpts=(1/$SPEED)*PTS"
