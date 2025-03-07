@ECHO OFF

SET "R2V=5.8.4"
SET ARCH=x64

SETLOCAL ENABLEDELAYEDEXPANSION

IF "%VisualStudioVersion%" == "14.0" ( IF NOT DEFINED Platform SET "Platform=X86" )
FOR /F %%i IN ('powershell -c "\"%Platform%\".toLower()"') DO SET PLATFORM=%%i
powershell -c "if ('%PLATFORM%' -notin ('x86', 'x64')) {Exit 1}"
IF !ERRORLEVEL! NEQ 0 (
    ECHO Unknown platform: %PLATFORM%
    EXIT /B 1
)

SET "PATH=%CD%;%PATH%"
SET "R2DIST=radare2"

@REM ECHO Downloading radare2 (%PLATFORM%)
@REM rem powershell -command "Invoke-WebRequest 'https://github.com/radareorg/radare2/releases/download/5.1.0/radare2-5.1.0_windows.zip' -OutFile 'radare2-5.1.0_windows.zip'"
@REM pip install wget
@REM python -m wget -o r2.zip https://github.com/radareorg/radare2/releases/download/%R2V%/radare2-%R2V%-w64.zip
@REM unzip r2.zip
@REM RENAME radare2-%R2V%-w64 radare2
@REM RMDIR /S /Q %R2DIST%
@REM ECHO prepping rdist %R2DIST%
@REM XCOPY radare2\ %R2DIST%\

MKDIR build_%ARCH%"
dir build_%ARCH%"
SET "PATH=%CD%\%R2DIST%\bin;%PATH%"
pwd
dir .
ECHO setting build enviornment
call "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" %ARCH%

rem ECHO Building radare2 (%PLATFORM%)
rem CD radare2
rem git clean -xfd
rem RMDIR /S /Q ..\%R2DIST%
rem meson -C src r2_builddir
rem meson.exe r2_builddir --buildtype=release --prefix=%CD%\..\%R2DIST% || EXIT /B 1
rem ninja -C r2_builddir install || EXIT /B 1
rem IF !ERRORLEVEL! NEQ 0 EXIT /B 1
