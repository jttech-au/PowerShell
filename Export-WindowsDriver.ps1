# Export Windows drivers, remove  folders that starts with prn…. Those are printer drivers.
Export-WindowsDriver -Destination "C:\Drivers\$((Get-WmiObject -Class win32_computersystem).Model)" -Online

# Import drivers or add to MDT, WDS, etc.
$infs = Get-ChildItem -Path "C:\Drivers\$((Get-WmiObject -Class win32_computersystem).Model)" -Filter "*.inf" -Recurse -File 
foreach($inf in $infs){ 
$inf.FullName 
pnputil.exe -i -a ""$inf.FullName"" 
} 