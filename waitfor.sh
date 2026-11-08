#!/bin/sh
case $(uname) in
    Linux) ;;
    *) echo "$(basename "$0"): only works on Linux" >&2; exit 1 ;;
esac

if [ "$1" = -h ] || [ "$1" = --help ]; then
    echo "Usage: $(basename "$0") FILE CMD...

    -h, --help    ptint this message and exit

    CMD will be passed directly to xargs.
    "
    exit 0
fi

file=$1
[ -z "$file" ] && { echo "File name expected see -h or --help for help"; exit 1; }
[ -z "$2" ] && { echo "Command expected see -h or --help for help"; exit 1; }
command -v inotifywait >/dev/null || { echo "$(basename "$0"): inotifywait is required (inotify-tools)" >&2; exit 1; }
shift


while true; do
    ___wait_For_file_name=$(inotifywait -e move_self --format '%w' "$file" 2>/dev/null)
    printf '\033[2J\033[%sT' "$LINES"
    echo '________________________________________________________________________________';
    echo "$___wait_For_file_name" | xargs "$@"
    unset ___wait_For_file_name
done

