@echo off
setlocal
set PATH=%~dp0win32-cmake-3.31.4\bin;%PATH%
if exist "%~dp0win32-cmake-3.31.4\bin\cmake.exe" goto installed
git clone https://github.com/thirdpartystuff/win32-cmake-3.31.4 || exit /B 1
:installed
"%~dp0win32-cmake-3.31.4\bin\cmake.exe" %* || exit /B 1
