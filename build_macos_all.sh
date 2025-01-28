#!/bin/sh
set -e
dir="$(cd $(dirname "$0"); pwd -P)"
"$dir/_build/macos_all.sh"
