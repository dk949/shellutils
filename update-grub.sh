#!/bin/sh
case $(uname) in
    Linux) ;;
    *) echo "$(basename "$0"): only works on Linux" >&2; exit 1 ;;
esac
if [ $# -ne 0 ]; then
    echo "Usage: $(basename "$0")"
    exit 1
fi

set -e
exec grub-mkconfig -o /boot/grub/grub.cfg "$@"
