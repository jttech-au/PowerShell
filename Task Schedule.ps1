# Start Date
$date = Get-Date "22/06/2017 5:00PM"
$action = New-ScheduledTaskAction "D:\Backup\Backup.cmd" 
$trigger = New-ScheduledTaskTrigger -Weekly -WeeksInterval 2 -DaysOfWeek Thursday -At $date
$principal = New-ScheduledTaskPrincipal -UserID DOMAIN\Backup$ -LogonType Password

Register-ScheduledTask "Windows Backup" -Action $action -Trigger $trigger -Principal $principal