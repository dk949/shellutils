#!/bin/sh
if [ $# -ne 1 ];  then
    echo "Usage: $(basename $0) TTY"
    exit 1
fi
# Temporarily change which tty the output goes to (Does not support &, &&, |, ||)

# Save curernt tty
TTY=$(tty)
TTY=${TTY##*/}

# start directing all output from this tty to the first argument to the function
exec 1>/dev/pts/"$1"

# execute the second argument
eval "$(echo "$@" | sed 's/[0-9]* \(.*\)/\1/')"

# return to outputing to the current tty
exec 1>/dev/pts/"$TTY"
