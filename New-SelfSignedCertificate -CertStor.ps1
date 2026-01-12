New-SelfSignedCertificate -CertStoreLocation Cert:\LocalMachine\My -DnsName "7267RootCA" -TextExtension @("2.5.29.19={text}CA=true") -KeyUsage CertSign,CrlSign,DigitalSignature -NotAfter (Get-Date).AddYears(10)

$rootCertPassword = ConvertTo-SecureString -String "password" -Force -AsPlainText
$rootCertPath = Get-ChildItem -Path "Cert:\LocalMachine\My\" | Where-Object {$_.Subject -like '*7267*'}
Export-PfxCertificate -Cert $rootCertPath -FilePath "$env:USERPROFILE\desktop\7267RootCA.pfx" -Password $rootCertPassword
Export-Certificate -Cert $rootCertPath -FilePath "$env:USERPROFILE\desktop\7267RootCA.crt"


$rootCert = Get-ChildItem -Path "Cert:\LocalMachine\My\" | Where-Object {$_.Subject –like '*7267*'}
New-SelfSignedCertificate -CertStoreLocation Cert:\LocalMachine\My -DnsName "print.curric.mount-clear-co.wan","7267-mcc-ps01.curric.mount-clear-co.wan" -KeyAlgorithm 'RSA' -KeyLength '2048' -KeyExportPolicy "Exportable" -NotAfter (Get-Date).AddYears(10) -Signer $rootCert

$Pwd = ConvertTo-SecureString -String "password" -Force -AsPlainText
$cert = Get-ChildItem -Path "Cert:\LocalMachine\My\" -DnsName "print.curric.mount-clear-co.wan"
Export-Certificate -Cert $cert -FilePath "$env:USERPROFILE\desktop\print.curric.mount-clear-co.wan.cer"
Export-PfxCertificate -Cert $cert -FilePath "$env:USERPROFILE\desktop\print.curric.mount-clear-co.wan.pfx" -Password $pwd




# export the key from the certificate key bundle
openssl pkcs12 -in certname.pfx -nocerts -out tlspw.pem

# remove the PEM pass phrase
openssl rsa -in tlspw.pem -out tls.pem (Private Key)

# export the certificate from the certificate key bundle
openssl pkcs12 -in certname.pfx -nokeys -out tls.cer (Public Certificate)