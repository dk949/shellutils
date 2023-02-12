#!/bin/sh
die()  {
    echo "$*"
    exit 1
}

[ $# -eq 1 ] || die "Usage $(basename "$0") FILE"

[ -d "$1" ] && die "\`$1\` is a directory, use rmdir"

[ -f "$1" ] || die "File \`$1\` does not exist"

[ -s "$1" ] && die "File \`$1\` is not empty"

rm "$1"
