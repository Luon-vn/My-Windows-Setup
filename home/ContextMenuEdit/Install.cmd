@echo off
set "OUTTEXTFILE=%temp%\context-menu-edit.reg"

setlocal EnableExtensions EnableDelayedExpansion

set "INTEXTFILE=%~dp0\context-menu-edit.reg"
set "SEARCHTEXT={{cd}}"
set "REPLACETEXT=%~dp0"
set "REPLACETEXT=!REPLACETEXT:\=\\!"
type .\NUL > "%OUTTEXTFILE%"
for /f "delims=" %%A in ('type "%INTEXTFILE%"') do (
    set "string=%%A"
    set "modified=!string:%SEARCHTEXT%=%REPLACETEXT%!"
    echo !modified!>>"%OUTTEXTFILE%"
)

echo "%OUTTEXTFILE%"
endlocal

"%OUTTEXTFILE%"
del /S /Q "%OUTTEXTFILE%"
