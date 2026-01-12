# Stop the Windows Update service
Stop-Service -Name wuauserv
Stop-Service -Name BITS 
Stop-Service -Name appidsvc 
Stop-Service -Name cryptsvc

Remove-Item $env:ALLUSERSPROFILE\Microsoft\Network\Downloader\qmgr*.dat -ErrorAction SilentlyContinue 
Rename-Item $env:SystemRoot\SoftwareDistribution SoftwareDistribution.bak -ErrorAction SilentlyContinue 
Rename-Item $env:SystemRoot\System32\Catroot2 catroot2.bak -ErrorAction SilentlyContinue 
Remove-Item $env:SystemRoot\WindowsUpdate.log -ErrorAction SilentlyContinue

cd $env:SystemRoot\System32

regsvr32.exe /s atl.dll
regsvr32.exe /s urlmon.dll
regsvr32.exe /s mshtml.dll
regsvr32.exe /s shdocvw.dll
regsvr32.exe /s browseui.dll
regsvr32.exe /s jscript.dll
regsvr32.exe /s vbscript.dll
regsvr32.exe /s scrrun.dll
regsvr32.exe /s msxml.dll
regsvr32.exe /s msxml3.dll
regsvr32.exe /s msxml6.dll
regsvr32.exe /s actxprxy.dll
regsvr32.exe /s softpub.dll
regsvr32.exe /s wintrust.dll
regsvr32.exe /s dssenh.dll
regsvr32.exe /s rsaenh.dll
regsvr32.exe /s gpkcsp.dll
regsvr32.exe /s sccbase.dll
regsvr32.exe /s slbcsp.dll
regsvr32.exe /s cryptdlg.dll
regsvr32.exe /s oleaut32.dll
regsvr32.exe /s ole32.dll
regsvr32.exe /s shell32.dll
regsvr32.exe /s initpki.dll
regsvr32.exe /s wuapi.dll
regsvr32.exe /s wuaueng.dll
regsvr32.exe /s wuaueng1.dll
regsvr32.exe /s wucltui.dll
regsvr32.exe /s wups.dll
regsvr32.exe /s wups2.dll
regsvr32.exe /s wuweb.dll
regsvr32.exe /s qmgr.dll
regsvr32.exe /s qmgrprxy.dll
regsvr32.exe /s wucltux.dll
regsvr32.exe /s muweb.dll
regsvr32.exe /s wuwebv.dll

# Remove the registry key
Remove-Item 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -Recurse

Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" -Name "PingID" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" -Name "AccountDomainSid" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" -Name "SusClientId" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" -Name "SusClientIDValidation" -ErrorAction SilentlyContinue


# Start the Windows Update service
Start-Service -Name BITS 
Start-Service -Name wuauserv 
Start-Service -Name appidsvc 
Start-Service -Name cryptsvc 

Invoke-Command {gpupdate /force}
Invoke-Command {wuauclt.exe /detectnow /resetauthorization}