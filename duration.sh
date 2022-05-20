if [ $# -eq 0 ]; then
    echo "Usage $(basename $0) FILE [FILE]..."
    exit 1
fi

for i in $*; do
    ffprobe "$i" 2>&1 | awk '/Duration/ {print $2}' | cut -d',' -f 1
done
