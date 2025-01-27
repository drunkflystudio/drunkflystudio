@echo off
set dir=%~dp0
cd /D "%dir%" || exit /B 1
if exist "%dir%_build\win32\msvc2022\cmake\Studio.sln" goto exist
call "%dir%_tools\cmake-3.31.4.cmd" -DMSVC2022_32=generate-only -P "%dir%_buildtool/buildtool.cmake" || exit /B 1
:exist
start %dir%_build\win32\msvc2022\cmake\Studio.sln || exit /B 1
