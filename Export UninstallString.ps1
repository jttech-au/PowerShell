$PATHS = @("HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall",
           "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall")

$file = "$env:USERPROFILE\Desktop\UninstallString.txt"

$installed = Get-ChildItem -Path $PATHS | Get-ItemProperty

$OutArray = @()

ForEach ($path in $installed)
    {
    $myobj = "" | Select-Object "DisplayName", "UninstallString"

    $myobj.DisplayName = $path.DisplayName
    $myobj.UninstallString = $path.UninstallString

    $outarray += $myobj

    # Wipe the object just to be sure
    $myobj = $null  
}
$outarray | export-csv $file
Write-Host "Uninstall strings exported to $file"