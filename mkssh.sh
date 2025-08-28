#!/bin/bash


usage() {
    [ -n "$2" ] && echo "
$2
"
    echo "Usage: $(basename "$0") REMOTE [LOCAL]

    REMOTE          address of the remote directory
    LOCAL           address of the local directory to mount to
    "
    exit "$1"
}

echo " $* " | grep -qE "( -h )|( --help )" && usage 0

[ -z "$1" ] && usage 1 "Must specify remote address"
remote=$1
local=${2:-$(basename "$remote")}
echo "Mapping $remote -> $local"
mkdir -p "$local"
sshfs -o allow_other "$remote" "$local"
trap "umount $local" EXIT
cwd=$(pwd)
cd "$local" || exit 1
"$SHELL"
cd "$cwd"
