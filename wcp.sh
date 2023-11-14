#!/bin/sh

die() {
    exit_code=$1
    shift
    echo "$@"
    exit "$exit_code"
}
usage(){
    die "$1" "Usage: $(basename "$0") URL [FILENAME]"
}

case " $@ " in ' -h '|' --help ') usage 0 ;; esac

flags="-sL"
if [ $# -eq 1 ];then
    flags="${flags}O"
elif [ $# -eq 2 ]; then
    flags="${flags}o $2"
else
    usage 1
fi

flags="${flags} $1"

eval "curl $flags"
