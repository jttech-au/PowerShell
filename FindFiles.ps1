######################################################
#
#
#
######################################################
$FileTypes = @("*.jpg","*.mov","*.mp4","*.avi","*.wmv","*.vob")
$FolderPath = @("\\SERVER\Staff Public$","\\SERVER\Student Public$","\\SERVER\Student Users$","\\SERVER\Staff Users$")

foreach ($fp in $FolderPath)
    {
    Switch ($fp)
        {
        "\\SERVER\Staff Public$" { $Drive = "T Drive" }
        "\\SERVER\Student Public$" { $Drive = "S Drive" }
        "\\SERVER\Student Users$" { $Drive = "Student Users" }
        "\\SERVER\Staff Users$" { $Drive = "Staff Users" }
        Default { 'unable to determine value of $FolderPath' }
        }
        foreach ( $file in $FileTypes)
            {
            $fext = $file.ToUpper().Substring(2)
            Get-ChildItem -Path $fp -Filter $file -Recurse | Format-Table | Out-File D:\$fext'_'$drive.txt
            }
    }


<#
http://technet.microsoft.com/en-us/library/ff730945.aspx

$startFolder = "C:\Scripts"

$colItems = (Get-ChildItem $startFolder | Measure-Object -property length -sum)
"$startFolder -- " + "{0:N2}" -f ($colItems.sum / 1MB) + " MB"

$colItems = (Get-ChildItem $startFolder -recurse | Where-Object {$_.PSIsContainer -eq $True} | Sort-Object)
foreach ($i in $colItems)
    {
        $subFolderItems = (Get-ChildItem $i.FullName | Measure-Object -property length -sum)
        $i.FullName + " -- " + "{0:N2}" -f ($subFolderItems.sum / 1MB) + " MB"
    }


#>


# $_Excluded_Items = @("*$RECYCLE.BIN*","*System Volume Information*")
# get-childitem $_Folder_Root -include *  -Exclude $_Excluded_Items -force  | Remove-Item -recurse –force -whatif

# Get-ChildItem C:\Dell, D:\Backup, E:\Hyper-V | Where-Object {$_.Extension -eq ".ps1"}
