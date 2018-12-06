$isFind = 0

$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
write-host $scriptPath

$temp_file="$scriptPath\temp_network_counter.txt"

# 1. create $temp_file for write Network Interface list
typeperf -qx "\Network Interface" | findstr Bytes | findstr Total/sec > $temp_file

# 2. Read Network Interface & Check value of perfcounter
foreach($line in Get-Content $temp_file) {
    $ret = (Get-Counter -Counter $line).CounterSamples.CookedValue
    if ($ret -gt 0) {
		$isFind = 1
        # remove 19 charactor of "\Network Interface("
        $line = $line.Remove(0,19)
        $line = $line.TrimEnd(")\Bytes Total/sec")
        break
        #return $line
    }
}

# 3. write config file to send to the zabbix server
if ($isFind -eq 1) {
$filewrite=@"
{
	"data": [{
        "{#NETWORK_INTERFACE}": "$line",
        "{#PAGING_FILE}":"_Total",
        "{#PHYSICAL_DISK}":"_Total",
        "{#LOGICAL_DISK}":"_Total",
        "{#PROCESSOR}":"_Total"
	}]
}
"@
} else {
$filewrite=@"
{
	"data": [{
        "{#NETWORK_INTERFACE}": "_Total",
        "{#PAGING_FILE}":"_Total",
        "{#PHYSICAL_DISK}":"_Total",
        "{#LOGICAL_DISK}":"_Total",
        "{#PROCESSOR}":"_Total"
	}]
}
"@
}

# 4. delete $temp_file
Remove-Item -Path $temp_file

# 5. file write $ZABBIX_DIRECTORY\conf\ndream_info.conf
$filewrite | Out-File -FilePath $scriptPath\..\conf\ndream_info.conf