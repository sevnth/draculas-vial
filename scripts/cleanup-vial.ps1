$themesDir = Join-Path $PSScriptRoot "..\themes"
if (-not (Test-Path $themesDir)) {
    $themesDir = "C:\Users\sevnth\draculas-vial\themes"
}
$keepVial = @(
    "dracula-vial-chromatic.json",
    "dracula-vial-pure-triad.json",
    "dracula-vial-neon-synth.json",
    "dracula-vial-deep-abyss.json",
    "dracula-vial-ice-fire.json",
    "dracula-vial-galactic-plasma.json",
    "dracula-vial-cyber-lavender.json"
)

Get-ChildItem -Path $themesDir -Filter *.json | ForEach-Object {
    if ($keepVial -notcontains $_.Name) {
        $_.Attributes = [System.IO.FileAttributes]::Normal
        [System.IO.File]::Delete($_.FullName)
        Write-Host "Removed old theme: $($_.Name)"
    } else {
        Write-Host "Vial Theme Active: $($_.Name)"
    }
}
