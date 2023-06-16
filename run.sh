#!/bin/sh
echo "run is deprecated and will soon be removed"
if [ $# -ne 1 ];then
    echo "Usage: $(basename "$0") PROGRAM"
    exit 1
fi
eval nohup "$1" 1>/dev/null 2>/dev/null </dev/null  &
kill "$(awk '{print $4}' "/proc/$PPID/stat")"

