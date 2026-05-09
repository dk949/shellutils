#!/bin/sh


usage() {
    echo "Usage: $(basename "$0") LINERANGE [FILE]

    LINERANGE               Line range to print in the form \`X:Y\`.
                            1-based, both inclusive.
                            Omitting \`X\` implicitly sets it to 1.
                            Omitting \`Y\` implicitly sets it to (line_count+1).

    -h, --help              Print this message and exit
" 1>&2
    exit
}

die() {
    {
        echo "$@"
        echo ""
        echo "See -h for help"
    } 1>&2
    exit 1
}

echo " $* " | grep -qE "( -h )|( --help )" && usage

line_range=$1
fname=$2
[ -z "$line_range" ] && die "line range required"
sed_range=$(echo "$line_range" | awk -F: '
{   line_count = NR
    if ($1) from = +$1; else from = 1
    if ($2) to = +$2; else to = "$" }
END { err_start = "Line range error: "
    if (line_count != 1) {
        print err_start "Unexpected new line"
        exit(1)
    }
    if ((to != "$" && (to < 1 || int(to) != to)) || (from < 1 || int(from) != from)) {
        print err_start "Expected line range of the form [X]:[Y] where X and Y are integers >=1"
        exit(1)
    }
    if(to != "$" && to < from) {
        print err_start "Start range should be smaller than or equal to end range"
        exit(1)
    }
    print from "," to "p" }') || die "$sed_range"


if [ -z "$fname" ]; then
    exec sed -n "$sed_range"
else
    exec sed -n "$sed_range" "$fname"
fi
