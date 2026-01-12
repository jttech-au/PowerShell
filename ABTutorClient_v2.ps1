$ABTutor64 = Test-Path "C:\Program Files\ABTutor\ABClient.exe"
$ABTutor32 = Test-Path "C:\Program Files (x86)\ABTutor\ABClient.exe"

If ($ABTutor64)
    {
    $ABClient64 = Get-Item 'C:\Program Files\ABTutor\ABClient.exe'    
    $AB64 = $ABClient64.VersionInfo.FileVersion

        If ($AB64 -lt "8,2,2,11006")
        {
            Write-Host "Updating ABtutor 64" -ForegroundColor Green
            msiexec.exe /i "\\subdomain.example.com.au\NETLOGON\ABTutor\ABTutorSetup.ClientOnly8.2.2.msi" /qn
        }
    }
ElseIf ($ABTutor32)
    {
    $ABClient32 = Get-Item 'C:\Program Files (x86)\ABTutor\ABClient.exe'    
    $AB32 = $ABClient32.VersionInfo.FileVersion

        If ($AB32 -lt "8,2,2,11006")
        {
            Write-Host "Updating ABTutor 32" -ForegroundColor Green
            msiexec.exe /i "\\subdomain.example.com.au\NETLOGON\ABTutor\ABTutorSetup.ClientOnly8.2.2.msi" /qn
        }
    }
Else
    {
        Write-Host "Installing ABTutor" -ForegroundColor Green
        msiexec.exe /i "\\subdomain.example.com.au\NETLOGON\ABTutor\ABTutorSetup.ClientOnly8.2.2.msi" /qn
    }