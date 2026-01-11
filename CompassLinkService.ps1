$compass = Get-Service CompassLink
$status = $compass.Status
If ( $status -ne "running")
    {
    Write-Host " Service not running"
    Start-Service CompassLink
    }
Else
    {
    Write-Host "Service running"
    }