@echo off
cd /D "%~dp0.." || exit /B 1
call "%~dp0..\_tools\cmake-3.5.2.cmd" -DHTML5=debug -P "%~dp0../_buildtool/buildtool.cmake" || exit /B 1
echo == SUCCESS! ==
