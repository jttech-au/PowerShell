#Variables
$StoragePoolName = "SP2"
$TieredSpaceName = "Tiered Storage"
$ResiliencySetting = "Simple"
$SSDTierName = "SSDTier"
$HDDTierName = "HDDTier"

#List all disks that can be pooled and output in table format (format-table)
Get-PhysicalDisk -CanPool $True | Format-Table FriendlyName,OperationalStatus,Size,MediaType

#Store all physical disks that can be pooled into a variable, $PhysicalDisks
$PhysicalDisks = (Get-PhysicalDisk -CanPool $True | Where-Object MediaType -NE UnSpecified)       

#Create a new Storage Pool using the disks in variable $PhysicalDisks with a name of My Storage Pool
$SubSysName = (Get-StorageSubSystem).FriendlyName
New-StoragePool -PhysicalDisks $PhysicalDisks -StorageSubSystemFriendlyName $SubSysName -FriendlyName $StoragePoolName

#View the disks in the Storage Pool just created
Get-StoragePool -FriendlyName $StoragePoolName | Get-PhysicalDisk | Select-Object FriendlyName, MediaType

#Create two tiers in the Storage Pool created. One for SSD disks and one for HDD disks
$SSDTier = New-StorageTier -StoragePoolFriendlyName $StoragePoolName -FriendlyName $SSDTierName -MediaType SSD -ResiliencySettingName $ResiliencySetting
$HDDTier = New-StorageTier -StoragePoolFriendlyName $StoragePoolName -FriendlyName $HDDTierName -MediaType HDD -ResiliencySettingName $ResiliencySetting

#Identify tier sizes within this storage pool
# $SSDTierSize = (Get-StorageTierSupportedSize -FriendlyName $SSDTierName -ResiliencySettingName $ResiliencySetting).TierSizeMax
# $HDDTierSize = (Get-StorageTierSupportedSize -FriendlyName $HDDTierName -ResiliencySettingName $ResiliencySetting).TierSizeMax

$SSDTierSizeInfo = Get-StorageTierSupportedSize SSDTier
$HDDTierSizeInfo = Get-StorageTierSupportedSize HDDTier

$SSDTierSize = $SSDTierSizeInfo.TierSizeMax - $SSDTierSizeInfo.TierDivisor * 10
$HDDTierSize = $HDDTierSizeInfo.TierSizeMax - $HDDTierSizeInfo.TierDivisor * 10

Write-Output "TierSizes: ( $SSDTierSize , $HDDTierSize )"

#Create a new virtual disk in the pool with a name of TieredSpace using the SSD and HDD tiers
# New-VirtualDisk -StoragePoolFriendlyName $StoragePoolName -FriendlyName $TieredSpaceName -StorageTiers $SSDTier, $HDDTier -StorageTierSizes $SSDTierSize, $HDDTierSize -ResiliencySettingName $ResiliencySetting  -AutoWriteCacheSize -AutoNumberOfColumns
New-VirtualDisk -StoragePoolFriendlyName $StoragePoolName -FriendlyName $TieredSpaceName -StorageTiers @($SSDTier,$HDDTier) -StorageTierSizes @(460GB,7.2TB) -ResiliencySettingName $ResiliencySetting -AutoWriteCacheSize -AutoNumberOfColumns