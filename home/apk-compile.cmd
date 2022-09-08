@echo off
setlocal enableDelayedExpansion

set "output="
set "dirPath=%1"

for /F "delims=" %%J in ("%dirPath%") do for /F "delims=" %%I in ("%%~fJ.") do set "output=%%~fI"

if "!output:~-1!"=="\" set "output=app"

echo Compiling into !output!-unsigned.apk..
call "%~dp0\apktool.cmd" b -f -r -o "!output!-unsigned.apk" %*

@REM Generate keystore
set KEYSTORE_FILE=D:\home\my-release-key.keystore
set KEYSTORE_ALIAS=my-key-alias
set KEYSTORE_PASSWORD=12345678
@REM keytool -genkey -v -keystore "%KEYSTORE_FILE%" -alias "%KEYSTORE_ALIAS%" -keyalg RSA -keysize 2048 -validity 10000 -storetype pkcs12

echo Signing !output!-unsigned.apk..
@REM jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore your-release-key.keystore android-release-unsigned.apk alias -storepass password
jarsigner -keystore "%KEYSTORE_FILE%" -storepass "%KEYSTORE_PASSWORD%" "!output!-unsigned.apk" "%KEYSTORE_ALIAS%"

del /S /Q "!output!.apk" >.\NUL 2>&1
echo Zipaligning !output!-unsigned.apk..
@REM sdkmanager "platforms;android-30" "build-tools;30.0.0" --sdk_root=D:\home\android-sdk\
zipalign 4 "!output!-unsigned.apk" "!output!.apk"

@REM del /S /Q "!output!-unsigned.apk" >.\NUL 2>&1
echo Run:
echo adb install !output!.apk
