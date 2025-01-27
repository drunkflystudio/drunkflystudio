#!/bin/sh
set -e
dir="$(dirname -- "$(readlink -f -- "$0")")" #"
"$dir/_build/linux_all.sh"
