#!/bin/sh
set -e
dir="$(dirname -- "$(readlink -f -- "$0")")" #"
"$dir/../_tools/linux_install_deps.sh"
cd "$dir"
cmake -DCMAKE_HOST_SYSTEM_NAME=Linux -DLINUX64=release -P "$dir/../_buildtool/buildtool.cmake"
echo == SUCCESS! ==
