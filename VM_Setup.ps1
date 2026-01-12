# Set VM Name, Switch Name, and Installation Media Path.
$Server = @("DC01","DC02", "FS01", "PS01", "DS01")
$VMRoot = 'D:\Virtual Machines\'
$InstallMedia = 'D:\ISO\SW_DVD9_Win_Server_STD_CORE_2019_1809.1_64Bit_English_DC_STD_MLF_X22-02970.ISO'
$Switch = 'Ext'

# VM Generation
$VMGenTwo = 2

# Virtual Processors
$vCPU = 2

# VHD
$VHDSize_OS = 100GB
$VHDSize_FS = 1TB
$VHDSize_DS = 500GB

# DefaultMemory
$DefaultMemory = 4GB

# DynamicMemory
$StartupMemory  = 4GB
$MinMemory      = 4GB


# Automatic Start Action (Nothing, Start, StartifRunning)
$AutoStartAction = 'Start'
# In second
$AutoStartDelay  = 60
# Automatic Start Action (TurnOff, Save, Shutdown)
$AutoStopAction  = 'Shutdown'



# Create New Virtual Machine
foreach ($VMName in $Server)
    { 
    # Default VM
    New-VM -Name $VMName -Path $VMRoot -MemoryStartupBytes $DefaultMemory -Generation $VMGenTwo -SwitchName $Switch
    
    # Virtual Hard Disks
    $VHDPath_OS = "$VMRoot\$VMName\Virtual Hard Disks\$VMName" + '_OS.vhdx'
    $VHDPath_DATA = "$VMRoot\$VMName\Virtual Hard Disks\$VMName" + '_DATA.vhdx'
    
    Switch ($VMName) {
        "1436DC01" {
                New-VHD -Path $VHDPath_OS -Dynamic -SizeBytes $VHDSize_OS
                Add-VMHardDiskDrive -VMName $VMName -Path $VHDPath_OS
               }
        "1436DC02" {
                New-VHD -Path $VHDPath_OS -Dynamic -SizeBytes $VHDSize_OS
                Add-VMHardDiskDrive -VMName $VMName -Path $VHDPath_OS              
               }
        "1436FS01" {
                New-VHD -Path $VHDPath_OS -Dynamic -SizeBytes $VHDSize_OS
                Add-VMHardDiskDrive -VMName $VMName -Path $VHDPath_OS
                New-VHD -Path $VHDPath_DATA -Dynamic -SizeBytes $VHDSize_FS
                Add-VMHardDiskDrive -VMName $VMName -Path $VHDPath_DATA
               }
        "1436PS01" {
                New-VHD -Path $VHDPath_OS -Dynamic -SizeBytes $VHDSize_OS
                Add-VMHardDiskDrive -VMName $VMName -Path $VHDPath_OS
               }
        "1436DS01" {
                New-VHD -Path $VHDPath_OS -Dynamic -SizeBytes $VHDSize_OS
                Add-VMHardDiskDrive -VMName $VMName -Path $VHDPath_OS
                New-VHD -Path $VHDPath_DATA -Dynamic -SizeBytes $VHDSize_DS
                Add-VMHardDiskDrive -VMName $VMName -Path $VHDPath_DATA
               }
        }
        $Gen = get-vm -Name $VMName
        $VMGen = $Gen.Generation
    
    If ($VMGen -eq 2)
        {
        # Add DVD Drive to Virtual Machine
        Add-VMScsiController -VMName $VMName
        Add-VMDvdDrive -VMName $VMName -ControllerNumber 1 -ControllerLocation 0 -Path $InstallMedia
        # Mount Installation Media
        $DVDDrive = Get-VMDvdDrive -VMName $VMName
        # Configure Virtual Machine to Boot from DVD
        Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDDrive
        }
    Else
        {
        Set-VMDvdDrive -VMName $VMName -ControllerNumber 1 -ControllerLocation 0 -Path $InstallMedia
        }
}

foreach ($VM in $Server)
    {
    $VMSnapshots = "D:\Virtual Machines\$VM\Snapshots"
    $VMSmartPaging = "D:\Virtual Machines\$VM\Smart Paging"

    Set-VM -Name $VM -ProcessorCount $vCPU -DynamicMemory -MemoryMinimumBytes $MinMemory -MemoryStartupBytes $StartupMemory  -AutomaticStartAction $AutoStartAction -AutomaticStartDelay $AutoStartDelay -AutomaticStopAction $AutoStopAction -SnapshotFileLocation $VMSnapshots -SmartPagingFilePath $VMSmartPaging
    If ($VM -eq "DC01" -or $VM -eq "DC02")
        {
        Set-VM -Name $VM -AutomaticStartDelay 0
        }
    }
