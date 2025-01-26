@echo off
cd /D "%~dp0" || exit /B 1
if exist "%~dp0_build\win64\msvc2022\cmake\Studio.sln" goto exist
call "%~dp0_tools\cmake-3.31.4.cmd" -DMSVC2022_64=generate-only -P "%~dp0_buildtool/buildtool.cmake" || exit /B 1
:exist
start %~dp0_build\win64\msvc2022\cmake\Studio.sln || exit /B 1
