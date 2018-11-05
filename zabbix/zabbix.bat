SET dir=%cd%
SET zabbix=%cd%\zabbix_agentd.exe
call :%1

goto :EOF

: start
%zabbix% --start
goto :EOF

: stop
%zabbix% --stop
goto :EOF

: install
%zabbix% --config %cd%\conf\zabbix_agentd.win.conf --install
goto :EOF

: uninstall
%zabbix% --uninstall
goto :EOF