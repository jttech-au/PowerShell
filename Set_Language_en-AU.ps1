$1 = New-WinUserLanguageList -Language "en-AU"
$1.Add("en-AU")
Set-WinUserLanguageList $1

Set-Culture -CultureInfo en-AU
Set-WinSystemLocale -SystemLocale en-AU -ErrorAction SilentlyContinue
Set-WinUILanguageOverride -Language en-AU -ErrorAction SilentlyContinue