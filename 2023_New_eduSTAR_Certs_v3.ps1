# https://msdn.microsoft.com/en-us/library/windows/desktop/aa394102(v=vs.85).aspx
# Search for PCSystemType
#
# Is computer a laptop
$HardwareType = (Get-WmiObject -Class Win32_ComputerSystem).PCSystemType

If ($HardwareType -eq 2)
    {
    # Default cert
    # Get-ChildItem -Path Cert:\LocalMachine\My
    $CertThumbprint = "EDF083F9B752A5DDE4C45A18F1212D6A2E56A2BE"
    $DefaultCert = Get-ChildItem -Path Cert:\LocalMachine\My | where {$_.Thumbprint -eq $CertThumbprint}
    
    # Check for expiring certs
    $Days = 90
    $DaysToExpire = (Get-Date).AddDays($Days)
    $ExpiredCerts = Get-ChildItem Cert:\LocalMachine\My | where {$_.NotAfter -le $DaysToExpire}

    # Cert Paths
    $ComputerName = $env:computername
    $CertPass = 'eduSTAR.NET'
    $SchoolNumber = "0427"
    $Server = "0427FS01"
    $CertPath = "\\$Server\Student Public$\eduSTAR\Certificate\$SchoolNumber-LAPTOP2023.pfx"

    # Root Certs
    $RootCert = "\\$Server\Student Public$\eduSTAR\RootCertificate\eduRootCA01.pem"
    $CAEduSubCA01 = "\\$Server\Student Public$\eduSTAR\RootCertificate\EDUSUBCA01.pem"
    $CAEduSubCA02 = "\\$Server\Student Public$\eduSTAR\RootCertificate\EDUSUBCA02.pem"
    $CASchSubCA01 = "\\$Server\Student Public$\eduSTAR\RootCertificate\STASUBCA01.pem"
    $CASchSubCA02 = "\\$Server\Student Public$\eduSTAR\RootCertificate\STASUBCA02.pem"
    
    If ($DefaultCert -ne $null -or $ExpiredCerts -ne $null)
        { 
    # Test if new cert exists
    If (Test-Path $CertPath)
        {
        #Add the new certificate.
        $CertPassword = ConvertTo-SecureString -String $CertPass -Force –AsPlainText
        Import-PfxCertificate –FilePath $CertPath Cert:\LocalMachine\My -Password $CertPassword
        # Root Cert
        Import-Certificate –FilePath $RootCert -CertStoreLocation Cert:\LocalMachine\Root
        #CA Certs
        Import-Certificate –FilePath $CAEduSubCA01 -CertStoreLocation Cert:\LocalMachine\CA
        Import-Certificate –FilePath $CAEduSubCA02 -CertStoreLocation Cert:\LocalMachine\CA
        Import-Certificate –FilePath $CASchSubCA01 -CertStoreLocation Cert:\LocalMachine\CA
        Import-Certificate –FilePath $CASchSubCA02 -CertStoreLocation Cert:\LocalMachine\CA

        # eduSTAR profile
        # Convert eduSTAR profile from base64 save in temp path
        # Add eduSTAR profile
        # Remove temp file.
        $eduSTARProfile = "PD94bWwgdmVyc2lvbj0iMS4wIj8+DQo8V0xBTlByb2ZpbGUgeG1sbnM9Imh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9uZXR3b3JraW5nL1dMQU4vcHJvZmlsZS92MSI+DQoJPG5hbWU+ZWR1U1RBUjwvbmFtZT4NCgk8U1NJRENvbmZpZz4NCgkJPFNTSUQ+DQoJCQk8aGV4PjY1NjQ3NTUzNTQ0MTUyPC9oZXg+DQoJCQk8bmFtZT5lZHVTVEFSPC9uYW1lPg0KCQk8L1NTSUQ+DQoJCTxub25Ccm9hZGNhc3Q+ZmFsc2U8L25vbkJyb2FkY2FzdD4NCgk8L1NTSURDb25maWc+DQoJPGNvbm5lY3Rpb25UeXBlPkVTUzwvY29ubmVjdGlvblR5cGU+DQoJPGNvbm5lY3Rpb25Nb2RlPmF1dG88L2Nvbm5lY3Rpb25Nb2RlPg0KCTxhdXRvU3dpdGNoPmZhbHNlPC9hdXRvU3dpdGNoPg0KCTxNU00+DQoJCTxzZWN1cml0eT4NCgkJCTxhdXRoRW5jcnlwdGlvbj4NCgkJCQk8YXV0aGVudGljYXRpb24+V1BBMjwvYXV0aGVudGljYXRpb24+DQoJCQkJPGVuY3J5cHRpb24+QUVTPC9lbmNyeXB0aW9uPg0KCQkJCTx1c2VPbmVYPnRydWU8L3VzZU9uZVg+DQoJCQk8L2F1dGhFbmNyeXB0aW9uPg0KCQkJPE9uZVggeG1sbnM9Imh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9uZXR3b3JraW5nL09uZVgvdjEiPg0KCQkJCTxjYWNoZVVzZXJEYXRhPnRydWU8L2NhY2hlVXNlckRhdGE+DQoJCQkJPGF1dGhNb2RlPm1hY2hpbmU8L2F1dGhNb2RlPg0KCQkJCTxFQVBDb25maWc+DQoJCQkJCTxFYXBIb3N0Q29uZmlnIHhtbG5zPSJodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcHJvdmlzaW9uaW5nL0VhcEhvc3RDb25maWciPg0KCQkJCQkJPEVhcE1ldGhvZD4NCgkJCQkJCQk8VHlwZSB4bWxucz0iaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3Byb3Zpc2lvbmluZy9FYXBDb21tb24iPjEzPC9UeXBlPg0KCQkJCQkJCTxWZW5kb3JJZCB4bWxucz0iaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3Byb3Zpc2lvbmluZy9FYXBDb21tb24iPjA8L1ZlbmRvcklkPg0KCQkJCQkJCTxWZW5kb3JUeXBlIHhtbG5zPSJodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcHJvdmlzaW9uaW5nL0VhcENvbW1vbiI+MDwvVmVuZG9yVHlwZT4NCgkJCQkJCQk8QXV0aG9ySWQgeG1sbnM9Imh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wcm92aXNpb25pbmcvRWFwQ29tbW9uIj4wPC9BdXRob3JJZD4NCgkJCQkJCTwvRWFwTWV0aG9kPg0KCQkJCQkJPENvbmZpZyB4bWxucz0iaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3Byb3Zpc2lvbmluZy9FYXBIb3N0Q29uZmlnIj4NCgkJCQkJCQk8RWFwIHhtbG5zPSJodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcHJvdmlzaW9uaW5nL0Jhc2VFYXBDb25uZWN0aW9uUHJvcGVydGllc1YxIj4NCgkJCQkJCQkJPFR5cGU+MTM8L1R5cGU+DQoJCQkJCQkJCTxFYXBUeXBlIHhtbG5zPSJodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcHJvdmlzaW9uaW5nL0VhcFRsc0Nvbm5lY3Rpb25Qcm9wZXJ0aWVzVjEiPg0KCQkJCQkJCQkJPENyZWRlbnRpYWxzU291cmNlPg0KCQkJCQkJCQkJCTxDZXJ0aWZpY2F0ZVN0b3JlPg0KCQkJCQkJCQkJCQk8U2ltcGxlQ2VydFNlbGVjdGlvbj50cnVlPC9TaW1wbGVDZXJ0U2VsZWN0aW9uPg0KCQkJCQkJCQkJCTwvQ2VydGlmaWNhdGVTdG9yZT4NCgkJCQkJCQkJCTwvQ3JlZGVudGlhbHNTb3VyY2U+DQoJCQkJCQkJCQk8U2VydmVyVmFsaWRhdGlvbj4NCgkJCQkJCQkJCQk8RGlzYWJsZVVzZXJQcm9tcHRGb3JTZXJ2ZXJWYWxpZGF0aW9uPnRydWU8L0Rpc2FibGVVc2VyUHJvbXB0Rm9yU2VydmVyVmFsaWRhdGlvbj4NCgkJCQkJCQkJCQk8U2VydmVyTmFtZXM+PC9TZXJ2ZXJOYW1lcz4NCgkJCQkJCQkJCQk8VHJ1c3RlZFJvb3RDQT40YiAwNyBlZCA4NyAyOSA1ZiBmOCA2MCA1OCAwMCA5MCA1MyAxNyAyMCBjOSBmMiBmNCA1ZSA2OSAzZiA8L1RydXN0ZWRSb290Q0E+DQoJCQkJCQkJCQkJPFRydXN0ZWRSb290Q0E+NzAgNDEgYzQgYWYgNTIgZWMgNDUgMmEgNzkgOWEgZDIgN2IgYTEgNzEgYzMgMDkgNjcgMDQgYWUgYmQgPC9UcnVzdGVkUm9vdENBPg0KCQkJCQkJCQkJPC9TZXJ2ZXJWYWxpZGF0aW9uPg0KCQkJCQkJCQkJPERpZmZlcmVudFVzZXJuYW1lPmZhbHNlPC9EaWZmZXJlbnRVc2VybmFtZT4NCgkJCQkJCQkJCTxQZXJmb3JtU2VydmVyVmFsaWRhdGlvbiB4bWxucz0iaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3Byb3Zpc2lvbmluZy9FYXBUbHNDb25uZWN0aW9uUHJvcGVydGllc1YyIj50cnVlPC9QZXJmb3JtU2VydmVyVmFsaWRhdGlvbj4NCgkJCQkJCQkJCTxBY2NlcHRTZXJ2ZXJOYW1lIHhtbG5zPSJodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcHJvdmlzaW9uaW5nL0VhcFRsc0Nvbm5lY3Rpb25Qcm9wZXJ0aWVzVjIiPmZhbHNlPC9BY2NlcHRTZXJ2ZXJOYW1lPg0KCQkJCQkJCQk8L0VhcFR5cGU+DQoJCQkJCQkJPC9FYXA+DQoJCQkJCQk8L0NvbmZpZz4NCgkJCQkJPC9FYXBIb3N0Q29uZmlnPg0KCQkJCTwvRUFQQ29uZmlnPg0KCQkJPC9PbmVYPg0KCQk8L3NlY3VyaXR5Pg0KCTwvTVNNPg0KPC9XTEFOUHJvZmlsZT4NCg=="
        $ProfilePath = "$env:temp\profile.xml"
        $Content = [System.Convert]::FromBase64String($eduSTARProfile)
        Set-Content -Path $ProfilePath -Value $Content -Encoding Byte
        netsh wlan add profile filename=($ProfilePath)
        Remove-Item $ProfilePath

        #Remove expired certs and remove default cert (Admin permissions required)
        $store = New-Object System.Security.Cryptography.X509Certificates.X509Store("My","LocalMachine")
        $store.Open("ReadWrite")
        $store.Remove($DefaultCert)
        $store.Remove($ExpiredCerts)
        $store.Close()
        }
    }
}