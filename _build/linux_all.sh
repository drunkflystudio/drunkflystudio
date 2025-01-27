#!/bin/sh
set -e
dir="$(dirname -- "$(readlink -f -- "$0")")" #"
"$dir/../_tools/linux_install_deps.sh"
cd "$dir"
cmake \
    "-DLINUX32=debug;release" \
    "-DLINUX64=debug;release" \
    -P "$dir/../_buildtool/buildtool.cmake"
echo == SUCCESS! ==
