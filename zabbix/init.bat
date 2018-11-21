@echo off
:: #DIRECTORY_PATH
SET dir=%cd%

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: user defined data
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: #ZABBIX_SERVER_IP
SET ip=192.168.3.85
:: #ZABBIX_PROXY_IPPORT
SET proxy=192.168.3.85:10052
:: #HOSTNAME
SET hostname=LC_125



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: make config file(%cd%\conf)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
copy %dir%\conf\example\userparameter_ndream.example.conf %dir%\conf\userparameter_ndream.conf
copy %dir%\conf\example\zabbix_agentd.win.example.conf    %dir%\conf\zabbix_agentd.win.conf

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: replace string
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

call :REPLACE_STRING conf\zabbix_agentd.win.conf #DIRECTORY_PATH %dir%
call :REPLACE_STRING conf\zabbix_agentd.win.conf #ZABBIX_SERVER_IP %ip%
call :REPLACE_STRING conf\zabbix_agentd.win.conf #HOSTNAME %hostname%
call :REPLACE_STRING conf\zabbix_agentd.win.conf #ZABBIX_PROXY_IPPORT %proxy%

call :REPLACE_STRING conf\userparameter_ndream.conf #DIRECTORY_PATH %dir%

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: make mssql dbconfig file
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
SET fname=%dir%\conf\ndream_db.conf
SET script=%dir%\scripts\ndream_mssql_make_configfile.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File "%script%" > %fname%

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: make ndream_info file
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
SET script=%dir%\scripts\make_ndream_info.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File "%script%"

goto :EOF

: REPLACE_STRING
SET textFile=%1
SET search=%2
SET replace=%3
:: remove double quotes
SET replace=%replace:"=%

:: replace string in %textFile%
for %%j in ("%dir%\%textFile%") do (
    for /f "delims=" %%i in ('type "%%~j" ^& break ^> "%%~j"') do (
        set "line=%%i"
        setlocal EnableDelayedExpansion
        set "line=!line:%search%=%replace%!"
        >>"%%~j" echo(!line!
        endlocal
    )
)