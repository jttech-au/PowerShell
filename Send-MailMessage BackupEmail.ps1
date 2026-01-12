$enddate = Get-Date
$startdate = (Get-Date).AddDays(-2)
$date = Get-ChildItem 'D:\Backup\BackupLogs' -recurse -filter *.txt | Where-Object { $_.CreationTime -ge $startdate -and $_.CreationTime -le $enddate }
$BackupLog = "D:\Backup\BackupLogs\" + $date.name

$string1 = "The backup operation successfully completed."
$string2 = "completed successfully"
$string3 = "Error"
$result = get-content $BackupLog | select-string -pattern $string1,$string2,$string3 | Select-Object -Last 5

$From = "from@email.com"
$To = "to@email.com"
$Attachment = $BackupLog
$Subject = "Primary School"
$Body = @"
MPPS Backup has finished.

$result


"@
$SMTPServer = "smtp.email.com"
$SMTPPort = "25"

Send-MailMessage -From $From -to $To -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl `
-Attachments $Attachment