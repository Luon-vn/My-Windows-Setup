@echo off
setlocal enableDelayedExpansion

set "basename="
set "parentpath="
set "output="

for /F "delims=" %%i in ("%1") do (
  set "basename=%%~ni"
  set "parentpath=%%~dpi"
)

set "output=!parentpath!!basename!-out"

echo Decompiling !basename! into !output!..
"%~dp0\apktool.cmd" d -f -r -o "!output!" %*
