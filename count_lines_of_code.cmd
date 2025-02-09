@echo off
setlocal
if exist "%~dp0_tools\win32-perl-5.12.3.0\perl\bin\perl.exe" goto installed
git clone https://github.com/thirdpartystuff/win32-perl-5.12.3.0 "%~dp0_tools\win32-perl-5.12.3.0" || exit /B 1
:installed
cd /D "%~dp0"
_tools\win32-perl-5.12.3.0\perl\bin\perl.exe -X ^
    _tools\cloc\cloc-2.04.pl ^
    --config=_tools\cloc\cloc.cfg ^
    --stat ^
    . ^
    || exit /B 1
