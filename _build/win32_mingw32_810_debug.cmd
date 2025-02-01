@echo off
set dir=%~dp0
cd /D "%dir%.." || exit /B 1
call "%dir%..\_tools\cmake-3.5.2.cmd" -DMINGW810_32=debug -P "%dir%../_buildtool/buildtool.cmake" || exit /B 1
echo == SUCCESS! ==
