#!/bin/sh

force=
FORCE=
file=
need_skip_flags=
usage() {
    exit_code=$1
    shift
    [ $# -ne 0 ] && { echo "$@"; echo; }
    echo "Usage: $(basename "$0") [OPTIONS]... FILE

        -f|--force      overwrite the backup file if it already exists
        -F|--FORCE      overwrite the backup file even if it is not a regular file
        --no-force      do not overwrite the backup file if it already exists (default)

        --              interpret the remaining arguments as a file name

        -h|--help       print this message and exit
        " >&$((exit_code + 1))
    exit "$exit_code"
}

die() {
    echo "$@"
    exit 1
}

get_file() {
    if [ -z "$file" ]; then
        file="$1"
    else
        usage 1 "Only one file can be specified"
    fi
}

skip_flags() {
    if [ -n "$need_skip_flags" ]; then
        get_file "$1"
        return 0
    fi
    return 1
}

while [ $# -ne 0 ]; do
    case "$1" in
        -h|--help)
            skip_flags "$1" || usage 0; shift;;
        -f|--force)
            skip_flags "$1" || force=1; shift;;
        -F|--FORCE)
            skip_flags "$1" || force=1; FORCE=1 shift;;
        --no-force)
            skip_flags "$1" || force=; FORCE=; shift;;
        --)
            skip_flags "$1" || need_skip_flags=1; shift;;
        -*)
            skip_flags "$1" || usage 1 "Unknown option $1"; shift;;
        *)
            get_file "$1"; shift;;
    esac
done

[ -z "$file" ] && usage 1 "No file specified"

[ ! -e "$file" ] && die "$file: no such file or directory"

bak_file="$file.bak"

if [ -e "$bak_file" ]; then
    if [ -f "$bak_file" ]; then
        [ -z "$force" ] && die "'$bak_file' already exists. Rename it first or use -f to overwrite."
    else
        [ -z "$FORCE" ] \
            && [ ! -f "$bak_file" ] \
            && die "'$bak_file' already exists and is not a regular file. Rename it or use -F to overwrite."
    fi
fi

[ -d "$bak_file" ] && rm -r -- "$bak_file"

\cp -r -- "$file" "$bak_file"
