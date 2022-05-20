#!/bin/sh
if [ $# -ne 0 ];then
    echo "Usage: $(basename $0)"
    exit 1
fi
xprop | awk '
	/^WM_CLASS/{sub(/.* =/, "instance:"); sub(/,/, "\nclass:"); print}
	/^WM_NAME/{sub(/.* =/, "title:"); print}'
