#!/bin/sh
grep -E '^#+ ' "$@" | python3 -c 'print(*map(lambda x: x[0] + f"[{x[1]}](#" + x[1].lower().replace(" ", "-") + ")", map(lambda x: (x[0][1:].replace("#", "  ") + "* ", " ".join(x[1:])), map(lambda x: x.strip().split(" "), __import__("sys").stdin.readlines()))), sep="\n")'
