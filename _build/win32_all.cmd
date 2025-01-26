@echo off
cd /D "%~dp0.." || exit /B 1
call "%~dp0..\_tools\cmake-3.5.2.cmd" ^
    -DBORLAND_4_5=debug;release ^
    -DHTML5=debug;release ^
    -DLINUX64=debug;release ^
    -DMINGW810_32=debug;release ^
    -DMINGW810_64=debug;release ^
    -DWATCOM10=debug;release ^
    -P "%~dp0../_buildtool/buildtool.cmake" || exit /B 1
call "%~dp0..\_tools\cmake-3.31.4.cmd" ^
    -DMSVC2022_32=debug;release ^
    -DMSVC2022_64=debug;release ^
    -P "%~dp0../_buildtool/buildtool.cmake" || exit /B 1
echo == SUCCESS! ==
