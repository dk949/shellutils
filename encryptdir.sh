#!/bin/sh
if [ $# -ne 1 ]; then
    echo "Usage: $(basename $0) DIR"
    exit 1
fi
# shellcheck disable=SC2002 # don't be mean to the cat
FILE_NAME="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)".gpg

tar -cf tmp.tar.gz "${1}"/ &&
    gpg -o "$FILE_NAME" -c tmp.tar.gz &&
    rm tmp.tar.gz &&
    rm -r "${1}"
