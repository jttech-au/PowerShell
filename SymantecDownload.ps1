import-module -name BitsTransfer

# The Intelligent Updater file names for SAV clients end with "i32.exe" or "i64.exe".
# The Intelligent Updater file names for SEP clients end with "v5i32.exe" or "v5i64.exe"

# Symantec Certified Virus Definitions
$cvdsep = "D:\Downloads\Symantec\Certified Virus Definitions\SEP"
$rrsep = "D:\Downloads\Symantec\Rapid Release\SEP"
$AdobeFlashPlayer = "D:\Downloads\Adobe\Flash Player"

if (!(Test-Path -path $cvdsep))
{
New-Item $cvdsep -type directory
}

if (!(Test-Path -path $rrsep))
{
New-Item $rrsep -type directory
}

if (!(Test-Path -path $AdobeFlashPlayer))
{
New-Item $AdobeFlashPlayer -type directory
}

$cvd = "Certified Virus Definitions"
Start-BitsTransfer -DisplayName $cvd -Source http://definitions.symantec.com/defs/symcdefsv5i32.exe -Destination $cvdsep -ProxyUsage Override -ProxyList ("proxy:8080 edupass:800")
Start-BitsTransfer -DisplayName $cvd -Source http://definitions.symantec.com/defs/symcdefsv5i64.exe -Destination $cvdsep -ProxyUsage Override -ProxyList ("proxy:8080 edupass:800")


# Symantec Rapid Release
$rr = "Rapid Release"
Start-BitsTransfer -DisplayName $rr -Source http://definitions.symantec.com/defs/rapidrelease/symrapidreleasedefsv5i32.exe -Destination $rrsep -ProxyUsage Override -ProxyList ("proxy:8080 edupass:800")
Start-BitsTransfer -DisplayName $rr -Source http://definitions.symantec.com/defs/rapidrelease/symrapidreleasedefsv5i64.exe -Destination $rrsep -ProxyUsage Override -ProxyList ("proxy:8080 edupass:800")

# Adobe Flash Player
Start-BitsTransfer -Source http://fpdownload.macromedia.com/get/flashplayer/current/licensing/win/install_flash_player_10_active_x.msi -Destination $AdobeFlashPlayer -ProxyUsage Override -ProxyList ("proxy:8080 edupass:800")
Start-BitsTransfer -Source http://fpdownload.macromedia.com/get/flashplayer/current/licensing/win/install_flash_player_10_plugin.msi -Destination $AdobeFlashPlayer -ProxyUsage Override -ProxyList ("proxy:8080 edupass:800")