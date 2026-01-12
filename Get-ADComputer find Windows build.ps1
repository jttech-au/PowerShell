# https://en.wikipedia.org/wiki/Windows_10_version_history
#
$OS = Get-ADComputer -properties OperatingSystem,OperatingSystemVersion -Filter * | Where-Object {$_.OperatingSystem -match ".*Windows 7.*|.*Windows 8.*|.*Windows 10.*"}

$result = @()

foreach ($i in $OS )
    {
    $OSVer = $i.OperatingSystemVersion
    $Name = $i.Name
        
    if ( $OSVer -contains '10.0 (18363)' ) { $build = 'Version 1909 November 2019 Update' }
    elseif ( $OSVer -contains '10.0 (18362)' ) { $build = 'Version 1903 May 2019 Update' }
    elseif ( $OSVer -contains '10.0 (17763)' ) { $build = 'Version 1809 October 2018 Update' }
    elseif ( $OSVer -contains '10.0 (17134)' ) { $build = 'Version 1803 April 2018 Update' }
    elseif ( $OSVer -contains '10.0 (16299)' ) { $build = 'Version 1709 Fall Creators Update' }
    elseif ( $OSVer -contains '10.0 (15063)' ) { $build = 'Version 1703 Creators Update' }
    elseif ( $OSVer -contains '10.0 (14393)' ) { $build = 'Version 1607 Anniversary Update' }
    elseif ( $OSVer -contains '10.0 (10586)' ) { $build = 'Version 1511 November Update' }
    elseif ( $OSVer -contains '6.3 (9600)' ) { $build = 'Windows 8.1' }
    elseif ( $OSVer -contains '6.2 (9200)' ) { $build = 'Windows 8' }
    elseif ( $OSVer -contains '6.1 (7601)' ) { $build = 'Windows 7 SP1' }

    $result += $Name + " " + $build
    }
$result | Sort-Object { [double]$_.split()[2],[string]$_.split()[0] } -Descending

    

<#
Version 1909 (OS build 18363)
Version 1903 (OS build 18362)
Version 1809 (OS build 17763)
Version 1803 (OS build 17134)
Version 1709 (OS build 16299)
Version 1703 (OS build 15063)
Version 1607 (OS build 14393)
Version 1511 (OS build 10586)

#>