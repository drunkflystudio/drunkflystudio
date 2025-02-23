@echo off

echo ========= Pulling base-common...
git pull || exit /B 1
cd /D "%~dp0base-common" || exit /B 1

echo ========= Pulling base-compiler...
git pull || exit /B 1
cd /D "%~dp0base-compiler" || exit /B 1

echo ========= Pulling base-runtime...
git pull || exit /B 1
cd /D "%~dp0base-runtime" || exit /B 1

echo ========= Pulling server-core...
git pull || exit /B 1
cd /D "%~dp0server-core" || exit /B 1

echo ========= Pulling main repo...
git pull || exit /B 1
