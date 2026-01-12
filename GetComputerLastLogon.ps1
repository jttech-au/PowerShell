$DaysInactive = 365 
$time = (Get-Date).Adddays(-($DaysInactive)) 
  
# Get all AD computers with lastLogonTimestamp less than our time 
# Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} -Properties LastLogonTimeStamp 

#Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} -Properties LastLogonTimeStamp | Format-Table -Property Name

Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} -Properties LastLogonTimeStamp | Move-ADObject -TargetPath "OU=Inactive,OU=Computers,OU=SchoolName,DC=subdomain,DC=example,DC=com,DC=au"