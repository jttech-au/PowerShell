$wsus = get-WsusServer
[reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration") | Out-Null
$wsus.getupdates() | Where-Object {$_.UpdateClassificationTitle -eq 'Drivers'} | ForEach-Object { $wsus.DeleteUpdate($_.Id. UpdateID); Write-Host $_.Title removed }