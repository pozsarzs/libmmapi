@echo off
rem ----------------------------------------------------------------------------
rem  LibMMAPI v0.1 * Application programming interface for MMxD device
rem  Copyright (C) 2019 Pozsár Zsolt pozsar.zsolt@szerafingomba.hu
rem  build.bat
rem  Utility for build/install/uninstall application on Windows
rem ----------------------------------------------------------------------------

set PPC=c:\lazarus\fpc\3.0.4\bin\i386-win32\ppc386.exe
set NAME=libmmapi
set /p VERSION=<documents\VERSION
set OS=win32
set ARCH=i386

rem - check parameters
echo %NAME% v%VERSION% - builder/installer utility
if "%~1" == "" goto build
if "%~1" == "clean" goto clean
if "%~1" == "install" goto install
if "%~1" == "uninstall" goto uninstall
if "%~1" == "/?" goto usage
:usage
echo Usage: build.bat [clean ^| install ^| uninstall]
echo.
echo        build.bat             compile source code
echo        build.bat clean       clean source code
echo        build.bat install     install application
echo        build.bat uninstall   uninstall application
echo.
goto end

rem - build source
:build
echo Check FreePascal compiler: %PPC%
if not exist "%PPC%" ( set /p PPC=Enter compiler with full path: )
if not exist "%PPC%" ( echo Error: compiler not found! & goto end )
set FPFLAG1=-TWin32 -MObjFPC -Scgi -O1 -ve -WR
set FPFLAG2=-Fu. -Fu.\lib\%ARCH%-%OS% -FE.\lib\%ARCH%-%OS% -Fu.\synapse

cd source
echo Compiling source code...
echo.
%PPC% %FPFLAG1% %FPFLAG2% mmapi.pas
echo.
if errorlevel 0 echo Run 'build.bat install' to install application.
cd ..
goto end

rem - clean source
:clean
echo Cleaning source code...
del /q source\lib\%ARCH%-%OS%\*.*
goto end

rem - install application
:install
set INSTDIR=%SYSTEMROOT%\SYSTEM32
echo Default target folder: %INSTDIR%
if not exist "source\lib\%ARCH%-%OS%\mmapi.dll" ( echo Error: firstly run "build.bat" to compile source code! & goto end )
echo Installing library...
copy /y source\lib\%ARCH%-%OS%\mmapi.dll %INSTDIR%\
echo.
echo Run 'build.bat uninstall' if you remove this application.
goto end

rem - uninstall application
:uninstall
echo Removing application...
del /q %SYSTEMROOT%\SYSTEM32\mmapi.dll
goto end

:end
pause
