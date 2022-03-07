@if (1==1) @if(1==0) @ELSE
@echo off&setlocal DisableDelayedExpansion
set "tempFile=%temp%\%~nx0_%time::=.%.args.txt"
>nul 2>&1 "%SYSTEMROOT%\system32\icacls.exe" "%SYSTEMROOT%\system32\config\system"||(
  @rem echo.%tempFile%
  >"%tempFile%" echo.%1
  >>"%tempFile%" echo.%*
  >>"%tempFile%" echo.%cd%
  type "%tempFile%" | cscript //E:JScript //nologo "%~f0"
  >NUL 2>&1 del /S /Q "%tempFile%"
  @goto :EOF
)
echo.Performing admin tasks...
%*
@goto :EOF
@end @ELSE
var cmd = WScript.StdIn.ReadLine() || 'D:\\home\\ContextMenuEdit\\start_cmd.cmd'
var args = WScript.StdIn.ReadLine().substr(cmd.length)
var cd = WScript.StdIn.ReadLine()

// WScript.Echo(cmd)
// WScript.Echo(args)
// WScript.Echo(cd)

var ShA=new ActiveXObject("Shell.Application")
// ShA.ShellExecute(cmd, args, cd, "runas", 5)
ShA.ShellExecute("cmd.exe", "/c cd /d \""+cd+"\" & "+cmd+" "+args, cd, "runas", 5)
@end