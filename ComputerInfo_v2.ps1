# All properties add: | Format-List *
$bios = Get-WmiObject -Class win32_bios
$CompSys = Get-WmiObject -Class Win32_ComputerSystem
$OS = Get-WmiObject -class Win32_OperatingSystem
$CPU = Get-WmiObject Win32_Processor
$RAM = Get-WmiObject Win32_PhysicalMemory
$biosDate = $bios.ConvertToDateTime($bios.ReleaseDate).ToString('dd-MM-yyy')

# Where file is saved. 
# Change path
$ScriptFile = "\\1918FS01\Student Public$\eduSTAR\Audit\Computers.csv"

# Test if file exists
$FileExists = Test-Path $ScriptFile
If ($FileExists -eq $false ){
	'' | select 'ComputerName','OperatingSystem','CPU','Architecture','RAM','Manufacturer','Model','Serial','BIOSDate' | Export-Csv $ScriptFile -NoTypeInformation
}
# x64 or x86
$Architecture = $OS.OSArchitecture
If($Architecture -eq "64-bit"){$OSArch = "x64"}else{$OSArch = "x86"}

# Total RAM
$VarRAM = 0
Foreach ($objRAM In $RAM) {     
      $VarRAM = $objRAM.Capacity + $VarRAM     
}
$RAMTotal = “$([math]::Round(($VarRAM / 1GB),2))GB”

# read file
$Serial = @()
Import-Csv $ScriptFile |`
    ForEach-Object {
        $Serial += $_.Serial
        }
$LocalSerial = $bios.SerialNumber

Write-Host $LocalSerial
Write-Host "Serial " $Serial


If ($LocalSerial -in $Serial)
    {
    Write-Host $true "CSV contains serial number"
    }
    Else
    {
    Write-Host $false "CSV does not contain serial number"
    $objectProperty = [ordered]@{

            ComputerName        = $CompSys.Name
            OperatingSystem     = $OS.Caption
            CPU                 = $CPU.Name
            Architecture        = $OSArch
            RAM                 = $RAMTotal
            Manufacturer        = $CompSys.Manufacturer
            Model               = $CompSys.Model
            Serial              = $LocalSerial
            BIOSDate            = $biosDate
            }
        $compInfo = New-Object -TypeName psobject -Property $objectProperty
        $compInfo | Export-Csv -Path $ScriptFile -Append -NoTypeInformation  
        }


<#

$array = "1", "2", "3", "4"

$a = "1"
$b = "5"

#method 1
if ($a -in $array)
{
    Write-Host "'a' is in array'"
}

#method 2
if ($array -contains $a)
{
    Write-Host "'a' is in array'"
}

#method 3
if ($array.Contains($a))
{
    Write-Host "'a' is in array'"
}

#method 4
$array | where {$_ -eq $a} | select -First 1 | %{Write-Host "'a' is in array'"}

#>
