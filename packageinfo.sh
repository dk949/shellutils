#!/bin/sh
case $(uname) in
    Linux) ;;
    *) echo "$(basename "$0"): only works on Linux" >&2; exit 1 ;;
esac

set -e
if [ $# -ne 1 ]; then
    echo "Usage: $(basename "$0") PACKAGE"
    exit 1
fi

PACK="$1"


echo "$PACK"
pacman -Qi "$PACK" |  grep -E '(Required By)|(Description)'
pactree -r "$PACK"
