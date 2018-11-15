
# Get Disk Information
$diskInfo=wmic logicaldisk get size,freespace,caption | findstr $args[0]
#$diskInfo=$diskInfo -replace "`n|`r|`t",""
$caption,[string]$diskFree,[string]$diskSize=$diskInfo -split '\s+'
$diskSize = $diskSize.Substring(0,$diskSize.length-1)
[double] $diskUsed = [double]$diskSize - [double]$diskFree

#write-host "diskused : $diskused zzz`ndisksize : ($diskSize)aaa`n"
$diskUsage = [math]::Round([double] $diskUsed / [double] $diskSize * 100,2)
write-host -NoNewline $diskUsage

# write-host "{"
# write-host " `"data`":[`n"

    # $line= "{ `"{#DISK_FREE}`" : `"" + $diskFree + "`",
              # `"{#DISK_SIZE}`" : `"" + $diskSize + "`",
              # `"{#DISK_USED}`" : `"" + $diskUsed + "`",
              # `"{#DISK_USAGE}`" : `"" + $diskUsage + "`"}"
    # write-host $line
        
# # Write our closing JSON brackets
 # write-host
# write-host " ]"
# write-host "}"
 
