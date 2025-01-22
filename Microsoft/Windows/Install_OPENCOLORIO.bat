@echo off


REM Grab the repo name, default is ocio_rw
set repo_name=ocio_rw
if not %1.==. set repo_name=%1


set CYGWIN=nodosfilewarning

set CMAKE_PATH=D:\OpenSource\cmake-3.9.3
set PYTHON_PATH=C:\Python27
set BOOST_ROOT=D:\SolidAngle\boost_1_55_0

set PATH=D:\Tools\cygwin64\bin;%CMAKE_PATH%\bin;%PYTHON_PATH%;%PATH%

call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" amd64


set OCIO_PATH=D:\OpenSource\%repo_name%


@doskey ne="D:\Tools\Notepad++\notepad++.exe" -nosession -multiInst $*
@doskey sub="D:\Tools\Sublime Text 3\subl.exe" --project %OCIO_PATH%_project.sublime-project


REM Decompose the directory change to avoid problems...
D:

IF NOT EXIST %OCIO_PATH% (
echo %OCIO_PATH% does not exist
exit /b
)
cd %OCIO_PATH%


set CMAKE_BUILD_TYPE=Release

echo *******
echo *********************************************
echo ******* Building %OCIO_PATH%
echo **
echo **
set are_you_sure = Y
set /P are_you_sure=Build in %CMAKE_BUILD_TYPE% ([Y]/N)?
if not %are_you_sure%==Y set CMAKE_BUILD_TYPE=Debug


set BUILD_PATH=_build_rls
if not %CMAKE_BUILD_TYPE%==Release set BUILD_PATH=_build_dbg

IF NOT EXIST %BUILD_PATH% ( mkdir %BUILD_PATH% )
cd %BUILD_PATH%


echo **
echo **

cmake -G "NMake Makefiles" ^
    -DCMAKE_BUILD_TYPE=%CMAKE_BUILD_TYPE% ^
    -DCMAKE_INSTALL_PREFIX=%OCIO_PATH%\_install ^
    -DOCIO_BUILD_TESTS=ON ^
    %OCIO_PATH%

set PATH=%OCIO_PATH%\%BUILD_PATH%\src\core;%PATH%


REM Find the current branch
set GITBRANCH=
for /f %%I in ('git.exe rev-parse --abbrev-ref HEAD 2^> NUL') do set GITBRANCH=%%I

if not "%GITBRANCH%" == ""  prompt $C%GITBRANCH%$F $P$G


echo *******
echo *********************************************
echo boost    = %BOOST_ROOT%
echo cmake    = %CMAKE_PATH%
echo *******
if not "%GITBRANCH%" == "" echo branch  = %GITBRANCH%
echo *******
echo Mode    = %CMAKE_BUILD_TYPE%
echo path    = %OCIO_PATH%\%BUILD_PATH%
echo compile = nmake all
echo test    = nmake test
echo *********************************************
echo *******