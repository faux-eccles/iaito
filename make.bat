SET "R2DIST=radare2"
SET "BUILDDIR=build_%PLATFORM%"

ECHO Preparing directory
RMDIR /S /Q %BUILDDIR%
MKDIR %BUILDDIR%
pwd
dir .
CD src
meson configure --buildtype=release --installation-prefix=..\%BUILDDIR% .
CD ..\%BUILDDIR%
ninja -v -j4
REM IF !ERRORLEVEL! NEQ 0 EXIT /B 1
CD ..

ECHO Deploying iaito
MKDIR iaito
COPY %BUILDDIR%\iaito.exe iaito\iaito.exe
XCOPY /S /I ..\%R2DIST%\share iaito\share
XCOPY /S /I ..\%R2DIST%\lib iaito\lib
DEL iaito\lib\*.lib
COPY ..\%R2DIST%\bin\*.dll iaito\
windeployqt iaito\iaito.exe
FOR %%i in (..\src\translations\*.qm) DO MOVE "%%~fi" iaito\translations

ENDLOCAL
