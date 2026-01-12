import-csv 1557-Students.csv| foreach-object {


$OldServerPath = "\\server\Student users$" + "\" + $_.sAMAccountName
$NewServerPath = "D:\Users\Student Users" + "\" + $_.sAMAccountName.ToLower() + "\Backup"

$CheckOldServerPath = Test-Path $OldServerPath
$CheckNewServerPath = Test-Path $NewServerPath
$LogFile = "/LOG:logs\" + $_.sAMAccountName + ".txt"

#Write-host "-------------"
#Write-host $CheckOldServerPath " User " $_.sAMAccountName " Folders do not exsist"
#Write-host "-------------"

# copy-item -recurse -Path $OldServerPath -Destination $NewServerPath

If ($CheckOldServerPath -ne $False) 
	{
    if ($CheckNewServerPath -ne $true)
        {
        New-Item -Name $NewServerPath -ItemType directory
        }
	robocopy $OldServerPath $NewServerPath /S /V /ZB /256 /R:0 /W:0 /ETA /TEE /COPY:DAT /XD $RECYCLE.BIN "Plants vs Zombies" /XF ~*.* *.exe *.dll *.ocx Thumbs.db .DS_Store *.tmp *.ini *.z64 *.au *.lnk *.m4a $LogFile
	}


# copy-item -recurse -Path c:\tmp -Destination c:\tmp2

# remove-item -recurse c:\tmp3

}
