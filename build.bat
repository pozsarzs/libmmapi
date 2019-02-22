@echo off
rem ----------------------------------------------------------------------------
rem  MMClient v0.1 * Growing house remote monitoring application
rem  Copyright (C) 2019 Pozsár Zsolt pozsar.zsolt@.szerafingomba.hu
rem  build.bat
rem  Utility for build/install/uninstall application on Windows
rem ----------------------------------------------------------------------------

set PPC=c:\lazarus\fpc\2.6.4\bin\i386-win32\ppc386.exe
set LAZ=c:\lazarus\
set NAME=mmclient
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
echo Check Lazarus IDE folder: %LAZ%
if not exist "%LAZ%" ( set /p LAZ=Enter component units folder: )
if not exist "%LAZ%" ( echo Error: Folder not found! & goto end )
set FPFLAG1=-TWin32 -MObjFPC -Scgi -O1 -ve -WG
set FPFLAG2=-Fu%LAZ%\lcl\units\%ARCH%-%OS% -Fu%LAZ%\lcl\units\%ARCH%-%OS%\%OS%
set FPFLAG3=-Fu%LAZ%\components\lazutils\lib\%ARCH%-%OS% -Fu. -Fu.\lib\%ARCH%-%OS%
set FPFLAG4=-FE.\lib\%ARCH%-%OS% -dLCL -dLCLwin32 -Fu.\synapse -Fu.\modules
set FPFLAG5=-Fu%LAZ%\components\printers\lib\%ARCH%-%OS%\%OS%
set FPFLAG6=-Fu%LAZ%\components\cairocanvas\lib\%ARCH%-%OS%\%OS%
set FPFLAG7=-Fu%LAZ%\packager\units\%ARCH%-%OS%

cd source
echo Compiling source code...
copy config.inc.in config.inc
echo.
%PPC% %FPFLAG1% %FPFLAG2% %FPFLAG3% %FPFLAG4% %FPFLAG5% %FPFLAG6% %FPFLAG7% mmclient.lpr
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
set INSTDIR=%PROGRAMFILES(X86)%
if "%INSTDIR%"=="" ( set INSTDIR=%PROGRAMFILES% )
echo Default target folder: %INSTDIR%
set ANSWER=
set /p "ANSWER=Enter target folder or leave empty to use default and press Enter: "
if not "%ANSWER%"=="" set INSTDIR=%ANSWER%
if not exist "%INSTDIR%" ( echo Error: target directory not found! & goto end )
set INSTDIR=%INSTDIR%\%NAME%
echo Selected target folder: %INSTDIR%
echo %INSTDIR% > install.log
if not exist "source\lib\%ARCH%-%OS%\tubes2oe.exe" ( echo Error: firstly run "build.bat" to compile source code! & goto end )
echo Installing application...
md %INSTDIR%
if not errorlevel 0 ( echo Error: cannot install application! & goto end )
md %INSTDIR%\documents
copy /y documents\*.* %INSTDIR%\documents\
ren %INSTDIR%\documents\COPYING COPYING.txt
del /q %INSTDIR%\documents\Makefile
md %INSTDIR%\documents\hu
copy /y documents\hu\*.* %INSTDIR%\documents\hu\
del /q %INSTDIR%\documents\hu\Makefile
md %INSTDIR%\languages
copy /y languages\*.pot %INSTDIR%\languages\
md %INSTDIR%\languages\hu
copy /y languages\%NAME%_hu.mo %INSTDIR%\languages\hu\%NAME%.mo
del /q %INSTDIR%\languages\Makefile
md %INSTDIR%\library
md %INSTDIR%\library\base
md %INSTDIR%\library\library_en
md %INSTDIR%\library\library_hu
copy /y library\base\*.* %INSTDIR%\library\base\
copy /y library\library_en\*.* %INSTDIR%\library\library_en\
copy /y library\library_hu\*.* %INSTDIR%\library\library_hu\
copy /y library\*.csv %INSTDIR%\library\
copy /y library\*.dat %INSTDIR%\library\
del /q %INSTDIR%\library\Makefile
md %INSTDIR%\help
md %INSTDIR%\help\help_en
copy /y help\help_en\*.html %INSTDIR%\help\help_en\
copy /y help\help_en\*.css %INSTDIR%\help\help_en\
md %INSTDIR%\help\help_hu
copy /y help\help_hu\*.html %INSTDIR%\help\help_hu\
copy /y help\help_hu\*.css %INSTDIR%\help\help_hu\
copy /y README*.* %INSTDIR%\
copy /y source\lib\%ARCH%-%OS%\*.exe %INSTDIR%\
config\mkshortcut.vbs /target:%INSTDIR%\%NAME%.exe /shortcut:%USERPROFILE%\desktop\Tubes2oe"
echo.
echo Run 'build.bat uninstall' if you remove this application.
goto end

rem - uninstall application
:uninstall
if not exist "install.log" ( echo Error: install.log file not found, cannot uninstall application! & goto end )
set /p %INSTDIR%=<install.log
echo Check application's folder: %INSTDIR%
if not exist "%INSTDIR%" ( echo Error: bad folder name in install.log file, cannot uninstall application! & goto end )
echo Removing application...
rd /s %INSTDIR%
del /q %USERPROFILE%\desktop\Tubes2oe.lnk
goto end

:end
pause