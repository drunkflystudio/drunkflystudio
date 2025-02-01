@echo off
cd /D "%~dp0" || exit /B 1
call "%~dp0..\..\_build\win32_mingw32_440_release.cmd" || exit /B 1
"%~dp0..\..\_build\win32\mingw440\Release\lua.exe" "%~dp0ci-windows.lua" > "%~dp0ci-windows.yml" || exit /B 1
"%~dp0..\..\_build\win32\mingw440\Release\lua.exe" "%~dp0ci-linux.lua" > "%~dp0ci-linux.yml" || exit /B 1
