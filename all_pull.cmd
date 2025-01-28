@echo off
git pull || exit /B 1
cd /D "%~dp0base-common" || exit /B 1
git pull || exit /B 1
cd /D "%~dp0base-compiler" || exit /B 1
git pull || exit /B 1
