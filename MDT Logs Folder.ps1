New-Item -Path D:\Logs -ItemType directory
New-SmbShare -Name Logs$ -Path D:\Logs -ChangeAccess EVERYONE
icacls D:\Logs /grant '"MDT_BA":(OI)(CI)(M)'