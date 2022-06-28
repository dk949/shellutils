#!/bin/sh
if [ $# -ne 1 ]; then
    echo "Usage: $(basename "$0") PATH"
    exit 1
fi


___DIR=$(dirname "$1")
___FILE=$(basename "$1")

mkdir -p "$___DIR"
touch "$___DIR/$___FILE"
