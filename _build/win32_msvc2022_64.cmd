@echo off
set dir=%~dp0
cd /D "%dir%.." || exit /B 1
call "%dir%..\_tools\cmake-3.31.4.cmd" -DMSVC2022_64=debug;release -P "%dir%../_buildtool/buildtool.cmake" || exit /B 1
echo == SUCCESS! ==
