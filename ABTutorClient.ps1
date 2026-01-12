$ABTutor = Get-Item 'C:\Program Files (x86)\ABTutor\ABTutor.exe'
$AB = $ABTutor.VersionInfo.FileVersion

If ($AB -lt "8,1,18,10669")
{
msiexec.exe /i "\\XXXXds01\sdp$\AB Tutor\ABTutorSetup.ClientOnly8.1.18.msi" /qn
}