#!/bin/sh
set -e
dir="$(cd $(dirname "$0"); pwd -P)"
cd "$dir"
cmake \
    "-DXCODE=debug;release" \
    -P "$dir/../_buildtool/buildtool.cmake"
echo == SUCCESS! ==
