#!/bin/bash
# TODO: this one needs a big overhaul or scrapping
out=("")
for i in $(ls -pA | grep -v / | tr '\n' ' ')
do
    out+="$(head -n 1 $i | awk -F"/" '/#!/ {print $NF}')\t${i}\n"

done

printf "$(printf "$out" | sort | sed 's/^\t/0\t/')\n"
