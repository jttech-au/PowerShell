$DaysInactive = 365 
$time = (Get-Date).Adddays(-($DaysInactive))

$OU = "OU=Accounts,OU=Primary School,DC=curric,DC=school-ps,DC=wan"
$OUInactive = "OU=Inactive,OU=Primary School,DC=curric,DC=school-ps,DC=wan"

Get-ADUser -SearchScope Subtree -SearchBase  $OU -Properties LastLogonTimestamp, PwdLastSet `
-filter {(LastLogonTimeStamp -lt $time -or LastLogonTimeStamp -notlike "*") -and (pwdlastset -lt $time -or pwdlastset -eq 0)} `
| Move-ADObject -targetpath $OUInactive

Get-ADUser -SearchBase  $OUInactive -Filter * | Disable-ADAccount