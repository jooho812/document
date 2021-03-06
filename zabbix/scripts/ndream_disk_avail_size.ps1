﻿
# Get Disk Information
$diskInfo=wmic logicaldisk get size","freespace","caption | findstr $args[0]
$caption,[string]$diskFree,[string]$diskSize=$diskInfo -split '\s+'
$diskSize = $diskSize.Substring(0,$diskSize.length-1)
[double] $diskUsed = [double]$diskSize - [double]$diskFree
$diskFreeGB = [math]::Round([double] $diskFree / ([double] (1024 * 1024)),2)

write-host -NoNewline $diskFreeGB