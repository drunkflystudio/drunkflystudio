#!/bin/sh
set -e

cd $(dirname "$0")
cd ..

mkdir -p _build/CLOC

git submodule update --init --recursive

echo Code Line Count > _build/CLOC/CLOC.md
echo =============== >> _build/CLOC/CLOC.md
echo Totals >> _build/CLOC/CLOC.md
echo ------ >> _build/CLOC/CLOC.md
perl _tools/cloc/cloc-2.04.pl --config=_tools/cloc/cloc.cfg --md . >> _build/CLOC/CLOC.md
echo Per File >> _build/CLOC/CLOC.md
echo -------- >> _build/CLOC/CLOC.md
perl _tools/cloc/cloc-2.04.pl --config=_tools/cloc/cloc.cfg --by-file --md . >> _build/CLOC/CLOC.md

str=`perl _tools/cloc/cloc-2.04.pl --config=_tools/cloc/cloc.cfg --csv . | grep SUM`
files=`echo $str | awk -F, '{OFS=",";print $1;}'`
blank=`echo $str | awk -F, '{OFS=",";print $3;}'`
comment=`echo $str | awk -F, '{OFS=",";print $4;}'`
code=`echo $str | awk -F, '{OFS=",";print $5;}'`

wget "https://img.shields.io/badge/CLOC-${files}_Files_/_${code}_Lines-8957E5?style=flat" -O _build/CLOC/CLOC.svg
