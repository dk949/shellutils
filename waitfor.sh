#!/bin/sh

if echo " $* " | grep -qE "( -h )|( --help )"; then
    echo "Usage: $(basename "$0") FILE CMD...

    -h, --help    ptint this message and exit

    CMD will be passed directly to xargs.
    "
    exit 0
fi

file=$1
[ -z "$file" ] && { echo "File name expected see -h or --help for help"; exit 1; }
[ -z "$2" ] && { echo "Command expected see -h or --help for help"; exit 1; }
shift


while true; do
    ___wait_For_file_name=$(inotifywait -e move_self --format '%w' "$file" 2>/dev/null)
    printf '\033[2J\033[%sT' "$LINES"
    echo '________________________________________________________________________________';
    echo "$___wait_For_file_name" | xargs "$@"
    unset ___wait_For_file_name
done

