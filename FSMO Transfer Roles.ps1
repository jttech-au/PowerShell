# Transfer FSMO Roles
#
# Check roles
# Get-ADForest | Select-Object DomainNamingMaster, SchemaMaster | Format-List
# Get-ADDomain | Select-Object InfrastructureMaster, RIDMaster, PDCEmulator | Format-List
#
# Transfer roles
#
$DC = "0755DC01"
# Transfer PDCEmulator
Move-ADDirectoryServerOperationMasterRole -Identity $DC PDCEmulator
# Transfer RIDMaster
Move-ADDirectoryServerOperationMasterRole -Identity $DC RIDMaster
# Transfer InfrastrctureMaster
Move-ADDirectoryServerOperationMasterRole -Identity $DC Infrastructuremaster
# Transfer DomainNamingMaster
Move-ADDirectoryServerOperationMasterRole -Identity $DC DomainNamingmaster
# Transfer SchemaMaster
Move-ADDirectoryServerOperationMasterRole -Identity $DC SchemaMaster