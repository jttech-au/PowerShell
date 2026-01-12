$bios = Get-WmiObject -Class win32_bios
$LocalSerial = $bios.SerialNumber
$CompName = $LocalSerial.Substring(0,6)

Rename-Computer -NewName RT-$CompName -Restart