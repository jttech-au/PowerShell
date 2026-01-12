$registryPath = "HKLM:\Software\DE\WSUSClientFix"

if (!(Test-Path $registryPath)){
    $WinBuild = [System.Environment]::OSVersion.Version.Build

    If ($WinBuild -lt "19043")
        {
        Stop-Service -Name BITS, wuauserv -Force
        Remove-ItemProperty -Name AccountDomainSid, PingID, SusClientId, SusClientIDValidation -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\ -ErrorAction SilentlyContinue
        Remove-Item "$env:SystemRoot\SoftwareDistribution\" -Recurse -Force -ErrorAction SilentlyContinue
        Start-Service -Name BITS, wuauserv
        wuauclt /resetauthorization /detectnow
        (New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow()

        New-Item -Path $registryPath -Force | Out-Null
        }
}