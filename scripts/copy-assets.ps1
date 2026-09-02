$imgDir = Join-Path $PSScriptRoot "..\images"
if (-not (Test-Path $imgDir)) {
    $imgDir = "C:\Users\sevnth\draculas-vial\images"
}

Get-ChildItem $imgDir | ForEach-Object {
    Write-Host "Assets ready: $($_.Name) ($($_.Length) bytes)"
}
