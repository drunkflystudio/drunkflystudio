#!/bin/sh
set -e
dir="$(cd $(dirname "$0"); pwd -P)"
cd "$dir"
cmake -DXCODE=release -P "$dir/../_buildtool/buildtool.cmake"
echo == SUCCESS! ==
