@echo off
cd /D "%~dp0.." || exit /B 1
call "%~dp0..\_tools\cmake-3.31.4.cmd" -DMSVC2022_64=debug;release -P "%~dp0../_buildtool/buildtool.cmake" || exit /B 1
echo == SUCCESS! ==
