$keep = @(
    "dracula-vial-chromatic.json",
    "dracula-vial-pure-triad.json",
    "dracula-vial-neon-synth.json",
    "dracula-vial-deep-abyss.json",
    "dracula-vial-ice-fire.json",
    "dracula-vial-galactic-plasma.json",
    "dracula-vial-cyber-lavender.json"
)

$themesDir = Join-Path $PSScriptRoot "..\themes"
if (-not (Test-Path $themesDir)) {
    $themesDir = "C:\Users\sevnth\draculas-vial\themes"
}

$files = Get-ChildItem -Path $themesDir -Filter *.json
foreach ($f in $files) {
    if ($keep -notcontains $f.Name) {
        try {
            $f.Attributes = [System.IO.FileAttributes]::Normal
            [System.IO.File]::Delete($f.FullName)
            Write-Host "Successfully deleted: $($f.Name)"
        } catch {
            Write-Warning "Could not delete $($f.Name): $_"
        }
    } else {
        Write-Host "Keeping: $($f.Name)"
    }
}
