@echo off
python.exe "%~dp0\..\dirsearch\dirsearch.py" -b -e php,js,jsp,asp,aspx,ini,sql,sql.gz,gz,zip,tar,tar.gz,html,txt,json,rb -t 1 -s 0.1 -u %*