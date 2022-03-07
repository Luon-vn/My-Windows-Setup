@echo off
if [%1] == [-r] (
	python.exe "%~dp0\..\sqlmap\sqlmap.py" --delay 0.5 --batch --level 5 --risk 3 --random-agent %*
) else (
	python.exe "%~dp0\..\sqlmap\sqlmap.py" --delay 0.5 --batch --level 5 --risk 3 --random-agent -u %*
)
