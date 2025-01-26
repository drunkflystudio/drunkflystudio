@echo off
setlocal enabledelayedexpansion
set WATCOM=%~dp0
set WATCOM=!WATCOM:~0,-1!
for %%i in (!WATCOM!) do set WATCOM=%%~dpi
set WATCOM=!WATCOM:~0,-1!
for %%i in (!WATCOM!) do set WATCOM=%%~dpi
set WATCOM=!WATCOM:~0,-1!
for %%i in (!WATCOM!) do set WATCOM=%%~dpi
set WATCOM=!WATCOM:~0,-1!\_tools\watcom10
set args=
:loop
if "%~1"=="" goto end
set "f=%~1"
set "f=!f:/=\!"
set "f=!f:`==!"
set "args=!args! !f!"
shift
goto loop
:end
"%WATCOM%\binnt\wlink" %args% || exit /B 1
