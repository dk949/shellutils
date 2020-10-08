#!/bin/sh
gpg -o tmp.tar.gz -d "${1:?}"&&
    tar -xf tmp.tar.gz  &&
    rm tmp.tar.gz &&
    rm -r "${1:?}"
