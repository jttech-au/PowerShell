# Step 1: Download and install ADK https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install
# Step 2: Download cumulative update (CU) https://catalog.update.microsoft.com/ search term "2023-08 cumulative update for windows 10"
# Step 3: Backup existing boot image
Copy-Item "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\en-us\winpe.wim" "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\en-us\winpe.bak.wim"

# Step 4: Mount boot image to mount folder
$MountPath = "C:\Mount"
If (!(Test-Path $MountPath)){
	New-Item -ItemType Directory -Path $MountPath
}
Mount-WindowsImage -Path $MountPath -ImagePath "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\en-us\winpe.wim" -Index 1 -Verbose

# Step 5: Add drivers to boot image (optional)
Add-WindowsDriver -Path $MountPath -Driver "C:\Drivers" -Recurse

# Step 6: Add optional components to boot image
Add-WindowsPackage -PackagePath "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-Scripting.cab" -Path $MountPath -Verbose
Add-WindowsPackage -PackagePath "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-WMI.cab" -Path $MountPath -Verbose
Add-WindowsPackage -PackagePath "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-FMAPI.cab" -Path $MountPath -Verbose
Add-WindowsPackage -PackagePath "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-SecureStartup.cab" -Path $MountPath -Verbose
Add-WindowsPackage -PackagePath "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-HTA.cab" -Path $MountPath -Verbose

<#
To check if an optional component has a language component, 
check the C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\<Language>\ 
directory to see if there's a matching language component for that optional component.

Popular optional components
Scripting/WinPE-Scripting	WinPE-Scripting.cab
Network/WinPE-WDS-Tools	WinPE-WDS-Tools.cab
Scripting/WinPE-WMI	WinPE-WMI.cab
Startup/WinPE-SecureStartup	WinPE-SecureStartup.cab
File management/WinPE-FMAPI	WinPE-FMAPI.cab
PowerShell/WinPE-PowerShell	WinPE-PowerShell.cab
Microsoft .NET/WinPE-NetFx	WinPE-NetFx.cab
Network/WinPE-Dot3Svc	WinPE-Dot3Svc.cab
HTML/WinPE-HTA	WinPE-HTA.cab
Database/WinPE-MDAC	WinPE-MDAC.cab

MDT boot image required components
Scripting/WinPE-Scripting	WinPE-Scripting.cab
Scripting/WinPE-WMI	WinPE-WMI.cab
File management/WinPE-FMAPI	WinPE-FMAPI.cab
Startup/WinPE-SecureStartup	WinPE-SecureStartup.cab
HTML/WinPE-HTA	WinPE-HTA.cab

#>
Add-WindowsPackage -PackagePath "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-Scripting_en-us.cab" -Path $MountPath -Verbose
Add-WindowsPackage -PackagePath "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-WMI_en-us.cab" -Path $MountPath -Verbose
Add-WindowsPackage -PackagePath "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-SecureStartup_en-us.cab" -Path $MountPath -Verbose
Add-WindowsPackage -PackagePath "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-HTA_en-us.cab" -Path $MountPath -Verbose

# Step 7: Add cumulative update (CU) to boot image
Add-WindowsPackage -PackagePath "C:\Updates\ssu-19041.1704-x64_70e350118b85fdae082ab7fde8165a947341ba1a.msu" -Path $MountPath -Verbose
Add-WindowsPackage -PackagePath "C:\Updates\windows10.0-kb5029244-x64_fb8cdde229cf17755c2c890a12e0e8f252dd38c0.msu" -Path $MountPath -Verbose

<# If error Servicing stack update (SSU) and error 0x800f0823
# Extract .cab file from .msu file
$MountExtractPath = "C:\Updates\Extract"
if (!(Test-Path $MountPath")){
	New-Item -ItemType Directory -Path $MountExtractPath
}
Start-Process "expand.exe" -ArgumentList " -f:* `"C:\Updates\windows10.0-kb5028166-x64_fe3aa2fef685c0e76e1f5d34d529624294273f41.msu`" `"C:\Updates\Extract`"" -Wait -LoadUserProfile
Add-WindowsPackage -PackagePath "C:\Updates\Extract\SSU-19041.3205-x64.cab" -Path $MountPath -Verbose
#>

# Step 8: Copy boot files from mounted boot image to ADK installation path
Copy-Item "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\Media\bootmgr.efi" "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\Media\bootmgr.bak.efi"
Copy-Item "C:\Mount\Windows\Boot\EFI\bootmgr.efi" "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\Media\bootmgr.efi"
Copy-Item "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\Media\EFI\Boot\bootx64.efi" "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\Media\EFI\Boot\bootx64.bak.efi"
Copy-Item "C:\Mount\Windows\Boot\EFI\bootmgfw.efi" "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\Media\EFI\Boot\bootx64.efi"

# Step 9: Perform component cleanup
Start-Process "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe" -ArgumentList " /Image:`"C:\Mount`" /Cleanup-image /StartComponentCleanup /Resetbase /Defer" -Wait -LoadUserProfile
Start-Process "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe" -ArgumentList " /Image:`"C:\Mount`" /Cleanup-image /StartComponentCleanup /Resetbase" -Wait -LoadUserProfile

# Step 10: Verify all desired packages have been added to boot image
Get-WindowsPackage -Path $MountPath

# Step 11: Unmount boot image and save changes
Dismount-WindowsImage -Path $MountPath -Save -Verbose

# Step 12: Export boot image to reduce size
Export-WindowsImage -SourceImagePath "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\en-us\winpe.wim" -SourceIndex 1 -DestinationImagePath "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\en-us\winpe-export.wim" -CompressionType max -Verbose
Remove-Item -Path "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\en-us\winpe.wim" -Force
Rename-Item -Path "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\en-us\winpe-export.wim" -NewName "winpe.wim"