# v1
$user ="user@email.com"
$pass = ConvertTo-SecureString -String "" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential $user, $pass


# $Date = Get-Date -format dd-MM-yyyy
# $BackupLog = "D:\Backup\BackupLogs\BackupEven_$Date.txt"
$BackupLog = "C:\Intel\Logs\IntelGFX.log"


$From = "from@email.com"
$To = "to@email.com"
$Subject = "School Backup"
$Body = "Backup has finished"
$Attachment = $BackupLog
$SMTPServer = "smtp.gmail.com"
$SMTPPort = 587

Send-MailMessage -From $From -to $To -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl `
-Attachments $Attachment -Credential $cred


<#
$userid='yourid@yourdoamin.com'
$creds=Get-Credential $userid
Send-MailMessage `
    -To 'someone@soemwhere.com' `
    -Subject 'Test' `
    -Body 'Test' `
    -UseSsl `
    -Port 587 `
    -SmtpServer 'smtp.office365.com' `
    -From $userid `
    -Credential $creds

$user = "me@gmail.com"
$pass = ConvertTo-SecureString -String "mypassword" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential $user, $pass


$gmailPwd = �P@ssw0rd�
$gmailUser = �name@gmail.com�
$passFile = �d:tempsecurepassword.txt�

#save password to file
ConvertTo-SecureString $gmailPwd -AsPlainText -Force | ConvertFrom-SecureString | Out-File $passFile

# read the password from the file
$pass = Get-Content $passFile | ConvertTo-SecureString

# create a new credential object
$cred = New-Object System.Management.Automation.PSCredential $gmailUser,$pass

#>