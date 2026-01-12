$StartFolder = "E:\Backup"

$colItems = (Get-ChildItem $StartFolder -Recurse | Measure-Object -property length -sum)

"$StartFolder -- " + "{0:N0}" -f ($colItems.sum) + " Bytes"
"$StartFolder -- " + "{0:N2}" -f ($colItems.sum / 1KB) + " KB"
"$StartFolder -- " + "{0:N2}" -f ($colItems.sum / 1MB) + " MB"
"$StartFolder -- " + "{0:N2}" -f ($colItems.sum / 1GB) + " GB"
"$StartFolder -- " + "{0:N2}" -f ($colItems.sum / 1TB) + " TB"
"$StartFolder -- " + "{0:N2}" -f ($colItems.sum / 1PB) + " PB"