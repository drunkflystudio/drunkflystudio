#!/bin/sh
set -e
dir="$(cd $(dirname "$0"); pwd -P)"
if [ ! -d "$dir/_build/macosx/xcode/cmake/Studio.xcodeproj" ]; then
    cmake -DXCODE=generate-only -P "$dir/_buildtool/buildtool.cmake"
fi
open "$dir/_build/macosx/xcode/cmake/Studio.xcodeproj"
