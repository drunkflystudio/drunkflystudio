@echo off

echo ========= Pushing base-common...
cd /D "%~dp0base-common" || exit /B 1
git push || exit /B 1

echo ========= Pushing base-compiler...
cd /D "%~dp0base-compiler" || exit /B 1
git push || exit /B 1

echo ========= Pushing main repo...
cd /D "%~dp0" || exit /B 1
git push || exit /B 1
