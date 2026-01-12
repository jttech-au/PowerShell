# Applies To: Windows 8.1, Windows PowerShell 4.0, Windows Server 2012 R2
Get-WsusServer | Invoke-WsusServerCleanup -DeclineSupersededUpdates
Get-WsusServer | Invoke-WsusServerCleanup -DeclineExpiredUpdates
Get-WsusServer | Invoke-WsusServerCleanup -CleanupObsoleteComputers
Get-WsusServer | Invoke-WsusServerCleanup -CleanupObsoleteUpdates
Get-WsusServer | Invoke-WsusServerCleanup -CleanupUnneededContentFiles
Get-WsusServer | Invoke-WsusServerCleanup -CompressUpdates