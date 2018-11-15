# get all sql instances, defaults to local machine, '.'

Function Get-SqlInstances {
  Param($ServerName = '.')

  $localInstances = @()
  [array]$captions = gwmi win32_service -computerName $ServerName | ?{$_.Name -match "mssql*" -and $_.PathName -match "sqlservr.exe"} | %{$_.Caption}
  foreach ($caption in $captions) {
    if ($caption -eq "MSSQLSERVER") {
      $localInstances += "MSSQLSERVER"
    } else {
      $temp = $caption | %{$_.split(" ")[-1]} | %{$_.trimStart("(")} | %{$_.trimEnd(")")}
      $localInstances += "$temp"
    }
  }
  $localInstances
}


$idx = 1
$instances = Get-SqlInstances
write-host "{"
write-host " `"data`":[`n"
foreach ($name in $instances)
{
    if ($idx -lt $instances.Count)
        {
            $line= "{ `"{#INST}`" : `"" + $name + "`", "  + "`"{#DBNAME}`" : `"_Total`", `"{#DBLOCK}`" : `"_Total`" },"
            write-host $line
        }
    # If this is the last row, we print a slightly different string - one without the trailing comma
    # Although I don't think the trailing comma would technically break JSON, this is the right way
    # to do it.
    elseif ($idx -ge $instances.Count)
        {
            $line= "{ `"{#INST}`" : `"" + $name + "`", "  + "`"{#DBNAME}`" : `"_Total`", `"{#DBLOCK}`" : `"_Total`" }"
            write-host $line
        }
    $idx++;
}
# Write our closing JSON brackets
 write-host
write-host " ]"
write-host "}"
 
