$enddate = Get-Date
$startdate = (Get-Date).AddDays(-2)
$date = Get-ChildItem 'D:\Backup\BackupLogs' -recurse -filter *.txt | Where-Object { $_.CreationTime -ge $startdate -and $_.CreationTime -le $enddate }
$BackupLog = "D:\Backup\BackupLogs\" + $date.name

$string1 = "The backup operation successfully completed."
$string2 = "completed successfully"
$string3 = "Error"
$result = get-content $BackupLog | select-string -pattern $string1,$string2,$string3 | Select-Object -Last 5

$From = "from@subdomain.example.com.au"
$To = "to@subdomain.example.com.au"
$Attachment = $BackupLog
$Subject = "Backup"
$Body = @"
Backup has finished.

$result


"@
$SMTPServer = "smtp.subdomain.example.com.au"
$SMTPPort = "25"

Send-MailMessage -From $From -to $To -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl `
-Attachments $Attachment