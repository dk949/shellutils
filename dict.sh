#!/bin/sh
if [ $# -ne 1 ]; then
    echo "Usage $(basename "$0") WORD"
    exit 1
fi
curl -s dict://dict.org/d:"${1}" | awk '!/[0-9]/'
