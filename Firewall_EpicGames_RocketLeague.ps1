# Define firewall rules
$firewallRules = @(
    @{
        Name = "EpicGamesLauncher"
        Program = "C:\Program Files (x86)\Epic Games\Launcher\Portal\Binaries\Win64\EpicGamesLauncher.exe"
    },
    @{
        Name = "Rocket League"
        Program = "C:\Program Files\Epic Games\rocketleague\Binaries\Win64\RocketLeague.exe"
    }
)

foreach ($rule in $firewallRules) {
    $ruleName = $rule.Name
    $programPath = $rule.Program

    # Attempt to get existing rule
    $existingRule = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue

    if (-not $existingRule) {
        Write-Host "Firewall rule '$ruleName' not found. Creating..."
        New-NetFirewallRule `
            -DisplayName $ruleName `
            -Direction Inbound `
            -Program $programPath `
            -Action Allow `
            -Profile Public `
            -Enabled True `
            -Description "Allow inbound connections for $ruleName"
    }
    elseif ($existingRule.Enabled -eq 'False') {
        Write-Host "Firewall rule '$ruleName' exists but is disabled. Enabling..."
        Set-NetFirewallRule -DisplayName $ruleName -Enabled True
    }
    else {
        Write-Host "Firewall rule '$ruleName' already exists and is enabled. No action needed."
    }
}
