$baseDir = Join-Path $PSScriptRoot ".."
if (-not (Test-Path $baseDir)) {
    $baseDir = "C:\Users\sevnth\draculas-vial"
}
$imgDir = Join-Path $baseDir "images"

Write-Host "Dracula's Vial icon and logo assets are active in $imgDir and root."
