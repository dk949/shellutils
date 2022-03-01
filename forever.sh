#!/bin/sh
if [ $# -lt 1 ]; then
    echo "Usage: $(basename "$0") CMD [ARGS...]"
    exit 1
fi
rep () {
    echo "y"
    echo "$*"
    $*; rep
}
rep $*
