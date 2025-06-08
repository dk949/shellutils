#!/bin/sh
set -e

license_url="https://github.com/dk949/LICENSES.git"
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}"
year=$(date +'%Y')

die() {
    #shellcheck disable=SC2059 # all args are forwarded to printf
    printf "$@"
    echo
    exit 1
}

help() {
    echo "Usage: $(basename "$0") LICENSE"
    echo
    echo "  -l|--list       List available licences"
    echo "  -c|--cache      Ensure list of licenses is cached"
    echo "  -u|--update     Update cached list of license files"
    echo "  -h|--help       Print help message"

}

cache() {
    [ -z "$cache_dir" ] && die "could not locate cache directory"
    license_dir="$cache_dir/LICENSES"
    if [ ! -d "$license_dir" ]; then
        git clone "$license_url" "$license_dir"
    fi
}


list() {
    cache
    \find "$license_dir" -maxdepth 1 -type f -exec "basename" "{}" ";"
}

update() {
    cache
    git -C "$license_dir" pull
}

[ $# -ne 1 ] && die "%s" "$(help)"

case $1 in
    "-l"|"--list")
        list
        exit 0
        ;;
    "-c"|"--cache")
        cache
        echo "Licenses have been cached"
        exit 0
        ;;
    "-u"|"--update")
        update
        echo "Licenses cache is up to date"
        exit 0
        ;;
    "-h"|"--help")
        help
        exit 0
        ;;
esac

cache


___USER=$(git config user.name)
[ -z "$___USER" ] && ___USER="$USER"
[ -z "$___USER" ] && die "could not determine username"


[ -f "LICENSE" ] && die '"LICENSE" already exists. Back it up and try again.'

[ ! -f "$license_dir/$1" ] && die "No such license %s
Available licenses are:

%s" "$1" "$(list)"

sed "s/=YEAR=/$year/;s/=AUTHOR=/$___USER/" < "$license_dir/$1"  > ./LICENSE
