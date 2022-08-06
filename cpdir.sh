#!/bin/sh
if [ $# -ne 2 ]; then
    echo "Usage: $(basename "$0") DIR DEST"
    exit 1
fi
cd "$2" || exit 1
find "$1" -type d -exec realpath --relative-to "$1" {} \; | grep -vx "\.git\(/.*\)\?\|\." | xargs mkdir || exit 1
