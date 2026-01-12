$VMName = "W10_1803_x64"

Stop-VM -VMName $VMName -Turnoff:$true -Confirm:$False
Get-VM -VMName $VMName | Get-VMHardDiskDrive | Foreach { Remove-item -path $_.Path -Recurse -Force -Confirm:$False}
Remove-VM -VMName $VMName -force