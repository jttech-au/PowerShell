# Reset Windows Update Components Script
Write-Host "Stopping Windows Update Services..." -ForegroundColor Yellow
Stop-Service wuauserv -Force
Stop-Service cryptSvc -Force
Stop-Service bits -Force
Stop-Service msiserver -Force

Write-Host "Deleting Windows Update Cache..." -ForegroundColor Yellow
Remove-Item -Path "C:\Windows\SoftwareDistribution\*" -Recurse -Force
Remove-Item -Path "C:\Windows\System32\catroot2\*" -Recurse -Force

Write-Host "Resetting Windows Update Components..." -ForegroundColor Yellow
Start-Process -FilePath "cmd.exe" -ArgumentList "/c netsh winsock reset" -Wait -NoNewWindow
Start-Process -FilePath "cmd.exe" -ArgumentList "/c netsh winhttp reset proxy" -Wait -NoNewWindow

Write-Host "Re-registering Windows Update DLLs..." -ForegroundColor Yellow
$updateDLLs = @(
    "atl.dll", "urlmon.dll", "mshtml.dll", "shdocvw.dll", "browseui.dll", "jscript.dll",
    "vbscript.dll", "scrrun.dll", "msxml.dll", "msxml3.dll", "msxml6.dll", "actxprxy.dll",
    "softpub.dll", "wintrust.dll", "dssenh.dll", "rsaenh.dll", "gpkcsp.dll", "sccbase.dll",
    "slbcsp.dll", "cryptdlg.dll", "oleaut32.dll", "ole32.dll", "shell32.dll", "initpki.dll",
    "wuapi.dll", "wuaueng.dll", "wuaueng1.dll", "wucltui.dll", "wups.dll", "wups2.dll",
    "wuweb.dll", "qmgr.dll", "qmgrprxy.dll", "wucltux.dll", "muweb.dll", "wuwebv.dll"
)

foreach ($dll in $updateDLLs) {
    regsvr32 /s $dll
}

Write-Host "Restarting Windows Update Services..." -ForegroundColor Yellow
Start-Service wuauserv
Start-Service cryptSvc
Start-Service bits
Start-Service msiserver

Write-Host "Windows Update Reset Complete!" -ForegroundColor Green