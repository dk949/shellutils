#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage $) DIR"
    exit 1
fi
if ! [ -d "$1" ]; then
    echo "$1 is not a directory"
    exit 1
fi


T="$(awk '{print $2}' "/proc/$PPID/stat" | sed 's/(\|)//g')"
case $T in
    urxvt)
        CMD="-cd"
        ;;
    alacritty|gnome-terminal|xfce4-terminal|terminator)
        CMD="--working-directory"
        ;;
    konsole)
        CMD="--workdir"
        ;;
    kitty)
        CMD="--directory"
        ;;
    xterm|st)
        echo "If $T supports launching to a specific directory please let me know"
        exit 1
        ;;

    *)
        echo "Unsupported terminal $T"
        CMD="--working-directory" # this is most likely to work
        ;;
esac

set +m
eval nohup "$T" "$CMD" "$1" 1>/dev/null 2>/dev/null </dev/null  &
eval nohup "$T" "$CMD" "$1" 1>/dev/null 2>/dev/null </dev/null  &
kill "$(awk '{print $4}' "/proc/$PPID/stat")"
