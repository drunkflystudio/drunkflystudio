@echo off
cd /D "%~dp0" || exit /B 1
call "%~dp0..\..\_build\win32_mingw32_release.cmd" || exit /B 1
"%~dp0..\..\_build\win32\mingw\Release\lua.exe" "%~dp0generate.lua" > "%~dp0ci.yml" || exit /B 1
