#!/bin/sh
set -e
dir="$(dirname -- "$(readlink -f -- "$0")")" #"
"$dir/../../_build/linux_gcc32_release.sh"
"$dir/../../_build/linux32/Release/lua" "$dir/ci-windows.lua" > "$dir/ci-windows.yml"
"$dir/../../_build/linux32/Release/lua" "$dir/ci-linux.lua" > "$dir/ci-linux.yml"
