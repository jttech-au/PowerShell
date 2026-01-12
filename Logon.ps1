$dom = $env:UserDomain
$computer = $env:computername
$username = $env:username

$date = Get-Date -format MM-yyyy
$filename = "\\XXXXhv01\Staff public$\ICT\ComputerLogon\$date.txt"

$Logon = $computer + ", " + $username 

$Logon | Out-File -Append $filename
