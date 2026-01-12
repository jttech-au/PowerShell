$MC32exe = Test-Path "C:\Program Files (x86)\Microsoft Studios\Minecraft Education Edition\Minecraft.Windows.exe" -PathType Leaf
$VC2017 = "\\SERVER\share$\Minecraft\vc_redist.x86.exe"
$MineCraft = "\\SERVER\share$\Minecraft\MinecraftEducationEdition_x86_1.12.5.0.msi"

$MineCraftArgs = @(
    "/i"
    "`"$MineCraft`""
    "/qn"
)


If ($MC32exe)
    {
    $MC32exe = Get-Item "C:\Program Files (x86)\Microsoft Studios\Minecraft Education Edition\Minecraft.Windows.exe" -ErrorAction SilentlyContinue  
    $MC32 = $MC32exe.VersionInfo.FileVersion
        If ($MC32 -lt "1.12.5.0")
            {
            Write-Host "Updating Minecraft" -ForegroundColor Green
            Start-Process $VC2017 -ArgumentList '/q' -NoNewWindow -Wait
            Start-Process msiexec.exe -ArgumentList $MineCraftArgs -Wait
            }
        Else
            {
            Write-Host "No update required" -ForegroundColor Red
            }
    }
Else
    {
    Write-Host "Installing Minecraft" -ForegroundColor Green
    Start-Process -FilePath $VC2017 -ArgumentList '/q' -NoNewWindow -Wait
    Start-Process msiexec.exe -ArgumentList $MineCraftArgs -Wait
    }