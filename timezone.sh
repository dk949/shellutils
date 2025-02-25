#!/bin/sh
set -e

die() {
    code=$1
    shift
    echo "$@"
    exit "$code"
}

help() {
    die "$1" "Usage: $(basename "$0") CITY"
}

echo " $* " | grep -qE "( -h )|( --help )" && help 0
[ $# -ne 1 ] && help 1

command -v timedatectl >/dev/null || die 1 "This script uses timedatectl"
#shellcheck disable=SC2016 # I don't want the backticks to expand
[ "$(id -u)" = 0 ] && echo 'WARNING: Do not execute the script as root. `timedatectl` will prompt for authentication if needed.'
city=$1
search_result=$(timedatectl list-timezones | grep "$city" -i) || die 1 "Could not find any matches for city '$city'"
[ "$(echo "$search_result" | wc -l)" -gt 1 ] && die 1 "Found multiple results for city '$city'. Choose one of the following:
$search_result"
echo setting timezone to "$search_result"
timedatectl set-timezone "$search_result"
