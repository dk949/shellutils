#!/bin/sh
if [ $# -ne 2 ]; then
    echo "Usage: $(basename "$0") FROM TO"
    exit 1
fi

FROM=$1  #  Find files that have names like something.text
TO=$2    #  Change the .text suffix TO .txt
find . -type f -name "*.$FROM" -exec sh -c 'mv "$3" "${3%.$1}.$2"' sh "$FROM" "$TO" {} ';'
