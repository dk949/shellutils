#!/bin/sh
if [ $# -lt 2 ];  then
    echo "Usage: $(basename "$0") TTY CMD"
    exit 1
fi
# Temporarily change which tty the output goes to (Does not support &, &&, |, ||)

# Save curernt tty
TTY=$(tty)
TTY=${TTY##*/}

# start directing all output from this tty to the first argument to the function
exec 1>/dev/pts/"$1"

shift
# execute the rest of the arguments
eval "$*"

# return to outputing to the current tty
exec 1>/dev/pts/"$TTY"
