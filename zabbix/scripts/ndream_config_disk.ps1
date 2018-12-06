# This function converts from one encoding to another.
function convertto-encoding ([string]$from, [string]$to){
    begin{
        $encfrom = [system.text.encoding]::getencoding($from)
        $encto = [system.text.encoding]::getencoding($to)
    }
    process{
        $bytes = $encto.getbytes($_)
        $bytes = [system.text.encoding]::convert($encfrom, $encto, $bytes)
        $encto.getstring($bytes)
    }
}

# Get Disk Information
$diskInfo=Get-WmiObject -Class Win32_LogicalDisk | Where-Object {$_.DriveType -ne 5}| findstr DeviceID
$diskInfo=$diskInfo -replace " ","" -replace "DeviceID:",""

write-host "{"
write-host " `"data`":[`n"
for ($idx=0;$i -le $diskInfo.length - 1; $i++)
{
    if ($idx -lt $diskInfo.length - 1)
    {
        $line="{ `"{#DISK_NAME}`" : `"" + $diskInfo[$idx] + "`"}, " | convertto-encoding "cp866" "utf-8"
        write-host $line
    }
    else
    {
        $line="{ `"{#DISK_NAME}`" : `"" + $diskInfo[$idx] + "`"}" | convertto-encoding "cp866" "utf-8"
        write-host $line
    }
    $idx++
}
write-host " ]"
write-host "}"