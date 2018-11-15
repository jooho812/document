# Get Memory Information
$memorySize = Get-WMIObject Win32_PhysicalMemory | Measure -Property capacity -Sum | %{$_.sum/1Mb}
$memoryAvail = (Get-Counter '\Memory\Available MBytes').CounterSamples.CookedValue

$memoryUsage = [math]::Round([double] $memoryAvail / [double] $memorySize * 100, 2)
write-host -NoNewline $memoryUsage

# write-host "{"
# write-host " `"data`":[`n"

    # $line= "{ `"{#MEM_AVAIL}`" : `"" + $memoryAvail + "`",
              # `"{#MEM_SIZE}`" : `"" + $memorySize + "`",
              # `"{#MEM_USAGE}`" : `"" + $memoryUsage + "`"}"

    # write-host $line
        
# # Write our closing JSON brackets
 # write-host
# write-host " ]"
# write-host "}"
 
