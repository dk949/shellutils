EXT_LIST="aux bcf log"
TEST=

while [ -n "$1" ]; do # loop over all arguments

    # Check which arg was passed
    case "$1" in
        -h|--help)
            echo "Usage: $(basename "$0") [-p|--pdf -t|--test] BASENAME"
            exit 0
            ;;

        -p|--pdf)
            EXT_LIST="$EXT_LIST pdf"
            shift
            ;;
        -t|--test)
            TEST=1
            shift
            ;;

        -*)
            echo "Option $1 not recognized"
            exit 1
            ;;
        *)
            if [ -n "$BASENAME" ]; then
                echo "expected 1 basename, got more"
                exit 1
            else
                BASENAME="$1"
            fi
            shift
            ;;
    esac
done

if [ -z "$BASENAME" ]; then
    echo "expected 1 basename, got none"
    exit 1
fi

cmd() {
    if [ -z $TEST ];then
        $*
    else
        echo "$*"
    fi
}

 for ext in $EXT_LIST; do
    cmd rm "${BASENAME}.${ext}" -f
 done
