# Netspace Black/White Restrictions backup
# Navigate to Black/White Restrictions page for CURRIC-TCS
# Save page as htm to Desktop, default is Netspace Education ACS.htm
# Output file is saved to Desktop
#
# NOTE
# Saved file Pattern changes (end of string1) between Firefox and IE change as required.
# FF '<input name="bwurl" class="input-xlarge" value="'
# IE '<INPUT name="bwurl" class="input-xlarge" type="text" value="'
#
$Regex = [regex]'[*]?([a-z0-9\.-]+).([a-z\.-]*)\.([a-z\.\)]{2,3})[*]?'
$string1 = Select-String -Path "$([Environment]::GetFolderPath("Desktop"))\Netspace Education ACS.htm" -Pattern '<INPUT name="bwurl" class="input-xlarge" type="text" value="'
$Regex.Matches($string1) | Select-Object -ExpandProperty Value |  Out-File "$([Environment]::GetFolderPath("Desktop"))\Black-White_list.txt"