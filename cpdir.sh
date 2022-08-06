#!/bin/sh
if [ $# -ne 2 ]; then
    echo "Usage: $(basename "$0") DIR DEST"
    exit 1
fi

DIR="$1"
DEST="$2"

DIRLIST=$(find "$DIR" -type d -exec realpath --relative-to "$DIR" {} \; | grep -vx "\.git\(/.*\)\?\|\.")

cd "$DEST" || exit 1

IFS="
"
mkdir $DIRLIST
