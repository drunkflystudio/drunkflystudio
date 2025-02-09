#!/bin/sh
set -e
cd $(dirname "$0")
cd ..
perl _tools/cloc/cloc-2.04.pl --config=_tools/cloc/cloc.cfg --md --out=_build/CLOC.md .
lines=`perl _tools/cloc/cloc-2.04.pl --config=_tools/cloc/cloc.cfg --csv . | grep SUM | awk -F, '{OFS=",";print $5;}'`
wget "https://img.shields.io/badge/$lines-green?style=flat" -O _build/CLOC.svg
