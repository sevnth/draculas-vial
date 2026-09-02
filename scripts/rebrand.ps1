$baseDir = Join-Path $PSScriptRoot ".."
if (-not (Test-Path $baseDir)) {
    $baseDir = "C:\Users\sevnth\draculas-vial"
}
$themesDir = Join-Path $baseDir "themes"
$imgDir = Join-Path $baseDir "images"

# Theme mapping
$mapping = @{
    "dracula-vial-chromatic.json" = @{ newName = "dracula-vial-chromatic.json"; title = "Dracula's Vial - Chromatic (Rich Full-Spectrum)" }
    "dracula-vial-pure-triad.json" = @{ newName = "dracula-vial-pure-triad.json"; title = "Dracula's Vial - Pure Triad (Cyan • Purple • Orange)" }
    "dracula-vial-neon-synth.json" = @{ newName = "dracula-vial-neon-synth.json"; title = "Dracula's Vial - Neon Synth (Hot Pink • Cyan • Violet)" }
    "dracula-vial-deep-abyss.json" = @{ newName = "dracula-vial-deep-abyss.json"; title = "Dracula's Vial - Deep Abyss (Oceanic Bioluminescence)" }
    "dracula-vial-ice-fire.json" = @{ newName = "dracula-vial-ice-fire.json"; title = "Dracula's Vial - Ice & Fire (Glacial Cyan & Purple Flame)" }
    "dracula-vial-galactic-plasma.json" = @{ newName = "dracula-vial-galactic-plasma.json"; title = "Dracula's Vial - Galactic Plasma (Plasma Violet & Solar)" }
    "dracula-vial-cyber-lavender.json" = @{ newName = "dracula-vial-cyber-lavender.json"; title = "Dracula's Vial - Cyber Lavender (Pastel Cyber)" }
}

foreach ($file in $mapping.Keys) {
    $targetPath = Join-Path $themesDir $file
    $info = $mapping[$file]

    if (Test-Path $targetPath) {
        $content = Get-Content $targetPath -Raw | ConvertFrom-Json
        $content.name = $info.title
        $jsonStr = $content | ConvertTo-Json -Depth 10
        [System.IO.File]::WriteAllText($targetPath, $jsonStr, [System.Text.Encoding]::UTF8)
        Write-Host "Verified: $($info.newName) -> $($info.title)"
    }
}

Write-Host "Rebrand theme files complete!"
