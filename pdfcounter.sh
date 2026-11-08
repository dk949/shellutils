#!/bin/sh
help() {
    echo "Usage: $(basename "$0") [-s] FILE

    -s, --simple            only print the number, with no extra text
    -h, --help              print this message
"
}

SIMPLE=
FILE=
while [ $# -ne 0 ]; do
    case "$1" in
        "-h"|"--help")
            help
            exit 1
            ;;
        "-s"|"--simple")
            SIMPLE=1
            shift
            ;;
        *)
            [ -n "$FILE" ] && { echo "only 1 file can be specified"; exit 1; }
            FILE="$1"
            shift
            ;;
    esac
done

[ -z "$FILE" ] && { help; exit 1; }
command -v pdftotext >/dev/null || { echo "$(basename "$0"): pdftotext is required" >&2; exit 1; }

# BSD wc pads the count with spaces
COUNT=$(pdftotext "$FILE" - | wc -w | tr -d ' ')
if [ -n "$SIMPLE" ]; then
    echo "$COUNT"
else
    echo "$COUNT words"
fi
