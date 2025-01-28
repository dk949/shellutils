#!/bin/sh


help(){
    echo "Usage: $(basename "$0") [DIR] [OPTIONS]

    Open another copy of the current terminal emulator.

    DIR                     Directory to open the new terminal in

    -h,--help               Show this message and exit
    -k,--kill               Kill the original terminal
"
    exit
}

dir="$PWD"
while [ $# -gt 0 ]; do
case $1 in
    -k|--kill)
        kill=1
        shift
        ;;
    -h|--help)
        help
        ;;
    *)
        dir=$1
        shift
        ;;
esac
done


tpid="$(ps -o ppid= $PPID | tr -d ' ')" # Terminal PID
tcmd="$(ps -p "$tpid" -o command=)" # terminal command


set +m
cmd="sh -c cd $dir;$tcmd"

eval nohup "$cmd" 1>/dev/null 2>/dev/null </dev/null &
[ -n "$kill" ] && kill "$tpid" || :
