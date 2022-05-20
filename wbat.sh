#!/bin/sh
if [ $# -lt 1 ]; then
    echo "Usage: $(basename $0) EXE [EXE]..."
    exit 1
fi

while [ $# -ne 0 ]; do
    bat "$(which "$1")" || exit 1
    shift
done
