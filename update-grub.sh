#!/bin/sh
if [ $# -ne 0 ]; then
    echo "Usage: $0"
    exit 1
fi

set -e
exec grub-mkconfig -o /boot/grub/grub.cfg "$@"
