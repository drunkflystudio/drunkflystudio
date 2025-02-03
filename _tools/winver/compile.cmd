@echo off
setlocal
set PATH=%~dp0..\borland45\bin;%PATH%
"%~dp0..\borland45\bin\bcc32" "-I%~dp0..\borland45\include" "-L%~dp0..\borland45\lib" winver.c
