# Create cert (10 years)
New-SelfSignedCertificate `
-DnsName "wac.subdomain.example.com.au" `
-KeyAlgorithm "ECDSA_nistP384" `
-KeyExportPolicy "Exportable" `
-CertStoreLocation "Cert:\LocalMachine\My" `
-NotAfter (Get-Date).AddYears(10)

Get-ChildItem Cert:\LocalMachine\My

4B5E6662441EE2C027888F4611A7465E933FA9DD  CN=wac.subdomain.example.com.au

Change perms
$ObjCert = Get-ChildItem Cert:\LocalMachine\My\4B5E6662441EE2C027888F4611A7465E933FA9DD
$Cert = [System.Security.Cryptography.X509Certificates.ECDsaCertificateExtensions]::GetECDsaPrivateKey($ObjCert)
$fileName = $Cert.key.UniqueName
$filePath = "$env:ALLUSERSPROFILE\Microsoft\Crypto\Keys\$fileName"
icacls $filePath /grant "NT AUTHORITY\NETWORK SERVICE:(F)"
icacls $filePath /grant "BUILTIN\Users:(R)"
icacls $filePath

Export
$ObjCert = Get-ChildItem Cert:\LocalMachine\My\4B5E6662441EE2C027888F4611A7465E933FA9DD
Export-Certificate -Cert $ObjCert -FilePath "$env:USERPROFILE\desktop\wac.subdomain.example.com.au.cer"

Import to trusted store
Import-Certificate -FilePath "$env:USERPROFILE\desktop\wac.subdomain.example.com.au.cer" -CertStoreLocation "Cert:\LocalMachine\Root"