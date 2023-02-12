#!/bin/sh
___CORENAME=$(\ls /var/lib/systemd/coredump -tr | head -n2 | tail -n 1)
___LOCAL_CORENAME=$(echo "$___CORENAME" | rev | cut -d'.' -f 2- | rev)

zstd "/var/lib/systemd/coredump/$___CORENAME" -d -o  "$___LOCAL_CORENAME"
