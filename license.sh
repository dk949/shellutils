#!/bin/sh

die() {
    # shellcheck disable=2059
    printf "$*"
    echo
    exit 1
}
___LICENSES_URL="https://github.com/dk949/LICENSES.git"
___CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}"
[ -z "$___CACHE_DIR" ] && die "could not locate cache directory"
___LICENSES_DIR="$___CACHE_DIR/LICENSES"
___YEAR=$(date +'%Y')
___USER=$(git config user.name)
[ -z "$___USER" ] && ___USER="$USER"
[ -z "$___USER" ] && die "could not determine username"


[ $# -ne 1 ] \
    && die "Usage: $(basename "$0") LICENSE"

[ -f "LICENSE" ] \
    && die '"LICENSE" already exists. Back it up and try again.'

[ ! -d "$___LICENSES_DIR" ] \
    && git clone "$___LICENSES_URL" "$___LICENSES_DIR"

[ ! -f "$___LICENSES_DIR/$1" ] \
    && die "No such license $1\nAvailable licenses are:\n\n$(ls "$___LICENSES_DIR")"

sed "s/=YEAR=/$___YEAR/;s/=AUTHOR=/$___USER/" < "$___LICENSES_DIR/$1"  > ./LICENSE
