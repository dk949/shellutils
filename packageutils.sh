#!/bin/sh

set -e
if [ $# -ne 1 ]; then
    echo "Usage: $(basename "$0") PACKAGE"
    exit 1
fi

PACK="$1"


echo "$PACK"
yay -Qi "$PACK" | awk  '/Required By/'
pactree -r "$PACK"
