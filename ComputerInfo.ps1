$computer = $env:computername

# All properties add: | Format-List *
$bios = Get-WmiObject -Class win32_bios
$CompSys = Get-WmiObject -Class Win32_ComputerSystem
$OS = Get-WmiObject -class Win32_OperatingSystem
$CPU = Get-WmiObject Win32_Processor
$RAM = Get-WmiObject Win32_PhysicalMemory
$biosDate = $bios.ConvertToDateTime($bios.ReleaseDate).ToString('dd-MM-yyy')

# Where file is saved. 
# Change path
$ScriptFile = "\\XXXXhv01\Student Public$\Audit\Computers.csv"

# Test if file exists
$FileExists = Test-Path $ScriptFile
If ($FileExists -eq $false ){
	New-Item $ScriptFile -ItemType File
    Add-Content $ScriptFile "ComputerName, OperatingSystem, CPU, Architecture, RAM, Manufacturer, Model, Serial, BIOSDate"
}

# read file
$ComputerInfo = Import-Csv $ScriptFile
$ComputerSerial = $ComputerInfo.Serial
$LocalSerial = $bios.SerialNumber

# x64 or x86
$Architecture = $OS.OSArchitecture
If($Architecture -eq "64-bit"){$OSArch = "x64"}else{$OSArch = "x86"}

# Total RAM
$VarRAM = 0
Foreach ($objRAM In $RAM) {     
      $VarRAM = $objRAM.Capacity + $VarRAM     
}
$RAMTotal = “$([math]::Round(($VarRAM / 1GB),2))GB”

If ($ComputerSerial -eq $LocalSerial)
    {
    #Write-host "Serial in file $true"
    }
    Else
    {
    #Write-host "$false No Serial in file, add"
    $compInfo = $CompSys.Name +", "+ $OS.Caption +", "+ $CPU.Name +", "+ $OSArch +", "+ $RAMTotal +", "+ $CompSys.Manufacturer +", "+ $CompSys.Model +", "+ $LocalSerial +", "+ $biosDate
    $compInfo | Out-File -Append $ScriptFile -Encoding UTF8
    }