#!/bin/sh
if [ $# -eq 0 ]; then
    echo "Usage $(basename "$0") FILE [FILE]..."
    exit 1
fi
command -v ffprobe >/dev/null || { echo "$(basename "$0"): ffprobe is required" >&2; exit 1; }

for i in "$@"; do
    ffprobe "$i" 2>&1 | awk '/Duration/ {print $2}' | cut -d',' -f 1
done
