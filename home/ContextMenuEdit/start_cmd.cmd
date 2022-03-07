@echo off
:: Chuyển đến thư mục hiện tại

set "arg1=%~1"
if "%arg1%."=="." (
  set "vecho=Howdy, Admin"
  set "arg1=%~dp0"
  goto Run
)
CD /D "%arg1%"
if %ERRORLEVEL% NEQ 0 (
  cls
  set "thisdir="
  if exist "%arg1%" (
    set "thisdir=%~dp$PATH:1"
    set vecho="%~nx1" is a file; Parent dir: "%~dp$PATH:1"
    cd /D "%~dp$PATH:1"
  ) else (
    set vecho="%arg1%" does not exist
    cd /D "%~dp0"
  )
) else (
  set vecho="%~nx1" is a folder
  set "thisdir=%~nx1"
)
set "thisdir="

:Run

set "NODE_PATH=%~dp0\..\nodejs\node_modules"
set "GOROOT=%~dp0\..\go"
set "GOPATH=%~dp0\..\go-packages"
set "PATH=%PATH%;C:\msys64\usr\bin;%~dp0\..\bin;%~dp0\..\nodejs;%~dp0\..\jdk-14\bin;%~dp0\..\go\bin;%~dp0\..\rubyinstaller\bin;%~dp0\..\go-packages\bin"

type "%~dp0\logo.txt"
echo.
echo %vecho%
set "vecho="

echo.
set "prompt_str=PROMPT %username%@%computername%$S$P$_#$S"
if "%username:~-1%." == "$." (
  set "prompt_str=PROMPT %username:~0,-1%@%computername%$S$P$_#$S"
)
if "%username%" == "%computername%$" (
  rem set "prompt_str=PROMPT nt authority\system@%computername%$S$P$_#$S"
  set "prompt_str=PROMPT system@%computername%$S$P$_#$S"
)
%SYSTEMROOT%\system32\cmd.exe /s /k "%prompt_str%"
exit 0