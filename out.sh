#!/bin/sh
if [ $# -lt 2 ];  then
    echo "Usage: $(basename "$0") TTY CMD"
    exit 1
fi
# Temporarily change which tty the output goes to (Does not support &, &&, |, ||)

# Save curernt tty
TTY=$(tty)

# start directing all output from this tty to the first argument to the function
# (Linux: /dev/pts/N, macOS: /dev/ttysNNN, the number as `tty` prints it)
case $(uname) in
    Darwin) exec 1>/dev/ttys"$1" ;;
    *) exec 1>/dev/pts/"$1" ;;
esac

shift
# execute the rest of the arguments
eval "$*"

# return to outputing to the current tty
exec 1>"$TTY"
