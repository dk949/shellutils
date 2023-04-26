#!/bin/sh
set -e

___LICENSES_URL="https://github.com/dk949/LICENSES.git"
___CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
___YEAR=$(date +'%Y')

die() {
    # shellcheck disable=2059
    printf "$*"
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
    [ -z "$___CACHE_DIR" ] && die "could not locate cache directory" || true
    ___LICENSES_DIR="$___CACHE_DIR/LICENSES"
    [ ! -d "$___LICENSES_DIR" ] \
        && git clone "$___LICENSES_URL" "$___LICENSES_DIR" || true
}


list() {
    cache
    \find "$___LICENSES_DIR" -maxdepth 1 -type f -exec "basename" "{}" ";"
}

update() {
    cache
    git pull "$___LICENSES_DIR"
}

[ $# -ne 1 ] \
    && die "$(help)" || true

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
[ -z "$___USER" ] && ___USER="$USER" || true
[ -z "$___USER" ] && die "could not determine username" || true


[ -f "LICENSE" ] \
    && die '"LICENSE" already exists. Back it up and try again.' || true


[ ! -f "$___LICENSES_DIR/$1" ] \
    && die "No such license $1\nAvailable licenses are:\n\n$(list)" || true

sed "s/=YEAR=/$___YEAR/;s/=AUTHOR=/$___USER/" < "$___LICENSES_DIR/$1"  > ./LICENSE
