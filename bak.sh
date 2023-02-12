#!/bin/sh
if [ $# -ne 1 ]; then
    echo "Usage: $(basename "$0") FILE"
    exit 1
fi
cp -r "$1" "$1".bak
