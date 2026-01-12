$OliverSrc = "D:\Oliver"
$Date = Get-Date -Format dd-MM-yyyy
$BackupFolder = "D:\Oliver Backup\"
$BackupFile = "Oliver_Backup_$Date.zip"
$BackupDst = $BackupFolder+$BackupFile
$Days = 365

#Stop IIS
Get-Service W3SVC -ErrorAction SilentlyContinue | Where-Object {$_.status -eq 'running'} | Stop-Service
Get-Process -Name FormsDetach -ErrorAction SilentlyContinue | Stop-Process -Force
Get-Process -Name java -ErrorAction SilentlyContinue | Stop-Process -Force

If((Test-Path -Path $OliverSrc))
{
    If(-not(Test-Path -Path $BackupFolder))
    {
        New-Item -Path $BackupFolder -ItemType directory
    }
        If((Test-Path $BackupDst))
        {
            Remove-Item -Path $BackupDst -Force
        }
        [System.Reflection.Assembly]::LoadWithPartialName('System.IO.Compression.FileSystem')
        $compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal # Optima, Fastest, NoCompression.
        $includebasedir = $true
        [System.IO.Compression.ZipFile]::CreateFromDirectory($OliverSrc,$BackupDst,$compressionLevel,$includebasedir)
}
#Start IIS
Get-Service W3SVC -ErrorAction SilentlyContinue | where {$_.status -ne 'running'} | Start-Service

Get-ChildItem -Path $BackupFolder | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$Days) } | Remove-Item -Recurse -Force


<#
Check disk size. Less than 10% free space. delete oldest backup.
#>

