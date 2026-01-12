if (Test-Path "C:\Program Files\LAPS\CSE\AdmPwd.dll") {
    Write-Host "AdmPwd.dll found, running uninstall command..."
    Start-Process "MsiExec.exe" -ArgumentList "/X{EA8CB806-C109-4700-96B4-F1F268E5036C} /qn" -Wait
    Write-Host "Uninstall completed."
}
else {
    Write-Host "AdmPwd.dll not found, no action taken."
}