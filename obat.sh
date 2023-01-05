#!/bin/sh

if [ "$#" -eq 0 ]; then
    echo "Usage: $(basename "$0") FILE [OPTS]"
    exit 1
fi

ARGS=
LEVEL="-d"

while [ "$#" -ne 0 ]; do
    case "$1" in
        "-d")
            LEVEL="-d"
            shift
            ;;
        "-D")
            LEVEL="-D"
            shift
            ;;
        *)
            ARGS="$ARGS $1"
            shift
            ;;
    esac
done


objdump -M intel "$LEVEL" $ARGS | c++filt | bat --language=asm
