$DaysInactive = 365 
$time = (Get-Date).Adddays(-($DaysInactive))

$OUInactive = "OU=Inactive,OU=Primary School,DC=curric,DC=school-ps,DC=wan"

Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} -Properties LastLogonTimeStamp | Move-ADObject -targetpath $OUInactive | Disable-ADAccount

# | Format-Table Name, Description, logonCount, LastLogonTimestamp
# | Disable-ADAccount
# | Move-ADObject -targetpath $OUInactive