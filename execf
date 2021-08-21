#!/bin/sh
if [ $# -ne 1 ]; then
    echo "Usage $0 DIR"
    exit 1
fi
if ! [ -d "$!" ]; then
    echo "$0: no such directory $1"
    exit 1
fi

CURRENT=$PWD
cd "$1" || exit 1
eval "$(echo "$@" | sed 's/[\/\.\_a-zA-Z0-9\-]* \(.*\)/\1/')"

if cd "$CURRENT"
then
    exit 0
else
    echo soemthing went very very wrong
    exit 1
fi

