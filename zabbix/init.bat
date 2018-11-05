@echo off
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: variable
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: #DIRECTORY_PATH
SET dir=%cd%
:: #ZABBIX_SERVER_IP
SET ip=192.168.1.172
:: #HOSTNAME
SET hostname=LC_01

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: make config file(%cd%\conf)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
copy %dir%\conf\example\userparameter_ndream.example.conf %dir%\conf\userparameter_ndream.conf
copy %dir%\conf\example\zabbix_agentd.win.example.conf %dir%\conf\zabbix_agentd.win.conf

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: replace string
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: replace zabbix_agentd.win.conf
call :REPLACE_STRING conf\zabbix_agentd.win.conf #DIRECTORY_PATH %dir%
call :REPLACE_STRING conf\zabbix_agentd.win.conf #ZABBIX_SERVER_IP %ip%
call :REPLACE_STRING conf\zabbix_agentd.win.conf #HOSTNAME %hostname%

:: replace userparameter_ndream.conf(only replace directory_path)
call :REPLACE_STRING conf\userparameter_ndream.conf #DIRECTORY_PATH %dir%




goto :EOF

: REPLACE_STRING
SET textFile=%1
SET search=%2
SET replace=%3

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