$VMName = "W10_1803_x64"
$VMRoot = "D:\Virtual Machines\"
$InstallMedia = "C:\Users\Jason\Downloads\ISO\LiteTouchPE_x64_Build.iso"
$Switch = "Ext"

# VM Generation
$VMGenOne = 1
$VMGenTwo = 2

# Virtual Processors
$vCPU = 2

# VHD
$VHDSize_OS = 70GB
$VHDSize_DATA = 1TB

# DefaultMemory
$DefaultMemory = 1GB

# StaticMemory
$StaticMemory   = 2GB

# DynamicMemory
$StartupMemory  = 2GB
$MinMemory      = 2GB
$MaxMemory      = 4GB

# Automatic Start Action (Nothing, Start, StartifRunning)
$AutoStartAction = 'Start'
# In second
$AutoStartDelay  = 60
# Automatic Start Action (TurnOff, Save, Shutdown)
$AutoStopAction  = 'Shutdown'

# Virtual Hard Disks
$VHDPath_OS = "$VMRoot\$VMName\Virtual Hard Disks\$VMName" + '_OS.vhdx'
$VHDPath_DATA = "$VMRoot\$VMName\Virtual Hard Disks\$VMName" + '_DATA.vhdx'

New-VM -Name $VMName -Path $VMRoot -MemoryStartupBytes $DefaultMemory -Generation $VMGenTwo -SwitchName $Switch

New-VHD -Path $VHDPath_OS -Dynamic -SizeBytes $VHDSize_OS
Add-VMHardDiskDrive -VMName $VMName -Path $VHDPath_OS

# Add DVD Drive to Virtual Machine
Add-VMScsiController -VMName $VMName
Add-VMDvdDrive -VMName $VMName -ControllerNumber 1 -ControllerLocation 0 -Path $InstallMedia
# Mount Installation Media
$DVDDrive = Get-VMDvdDrive -VMName $VMName
# Configure Virtual Machine to Boot from DVD
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDDrive

Set-VM -Name $VMName -ProcessorCount $vCPU -DynamicMemory -MemoryMinimumBytes $MinMemory -MemoryStartupBytes $StartupMemory -MemoryMaximumBytes $MaxMemory -AutomaticStartAction $AutoStartAction -AutomaticStartDelay $AutoStartDelay -AutomaticStopAction $AutoStopAction
