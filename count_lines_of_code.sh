#!/bin/sh
set -e
cd $(dirname "$0")
perl _tools/cloc/cloc-2.04.pl --config=_tools/cloc/cloc.cfg .
