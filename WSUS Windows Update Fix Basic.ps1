# https://blogs.technet.microsoft.com/askpfeplat/2018/11/06/unsticking-windows-updates-that-are-stuck-in-their-tracks/

#Stop BITS Server 
Stop-Service BITS
#Stop Windows Update 
Stop-Service wuauserv
#Rename the Software Distribution Folder to .old the folder will be recreated when the services are restarted 
Rename-Item -Path "C:\Windows\SoftwareDistribution" -NewName "C:\Windows\SoftwareDistribution.old"
#Start BITS service 
Start-Service BITS
#Start Windows Update 
Start-Service wuauserv