@echo off
call "%~dp0_build\win32_html5_debug.cmd" || exit /B 1
cd /D "%~dp0_build\html5" || exit /B 1
set /a port=(%RANDOM%*(32767-1000+1)/32768)+1000
set datadir=%~dp0_build\html5\Debug\ie\%port%
start /MIN "http.server" "%~dp0_tools\python3\python.exe" -m http.server %port% -b 127.0.0.1 || exit /B 1
echo Waiting for browser to exit...
start "" /wait msedge.exe ^
    --remote-debugging-port=9222 ^
    --no-first-run ^
    --auto-open-devtools-for-tabs ^
    --user-data-dir="%datadir%" ^
    "http://127.0.0.1:%port%/Debug/t_compil.html" ^
    || exit /B 1
echo Stopping server...
wmic process where "name like '%%python.exe%%' and commandline like '%%-m http.server %port% -b%%'" delete
rmdir /S/Q "%datadir%"
