#!/bin/sh

# TODO: this needs a rework
helpText() {
    printf "Usage: rmphdup [TEST] KEEP REMOVE

    If 2 files exist with teh same name but different extensions the one with .[REMOVE] extension will be removed.

        e.g. when running rmphdup png jpg on photo1.png photo1.jpg photo2.png photo3.jpg,
        the result will be: photo1.png photo2.png photo3.jpg

        -t, --test            will output all of the rm commands that will be run

        -h, --help            will bring up this message

        for bug reports email dkatz488@gmail.com\n"
            exit 0
        }

        TEST=0
        KEEP=""
        REMOVE=""
        if [ -z "$1" ]; then
            echo "Usage: $(basename "$0") [KEEP] [REMOVE]"
            exit 1
        fi

# Main argument collecting loop
while [ -n "$1" ]; do # loop over all arguments

    # Check which arg was passed
    case "$1" in
        -h|--help)
            helpText
            ;;

        -t|--test)
            TEST=1
            shift
            ;;

        -*)
            echo "Option $1 not recognized"
            exit 1
            ;;
        *)

            [ -n "$1" ] && KEEP="$1"
            shift
            [ -n "$1" ] && REMOVE="$1"
            shift
            ;;
    esac
done

if [ $TEST -gt 0 ]; then
    for f in *."$REMOVE"; do
        [ -e "${f%.*}.$KEEP" ] && echo rm -- "$f"
    done
else
    for f in *."$REMOVE"; do
        [ -e "${f%.*}.$KEEP" ] && rm -- "$f"
    done
fi
