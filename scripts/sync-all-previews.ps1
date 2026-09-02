$imgDir = Join-Path $PSScriptRoot "..\images"
if (-not (Test-Path $imgDir)) {
    $imgDir = "C:\Users\sevnth\draculas-vial\images"
}

Get-ChildItem -Path $imgDir -Filter "preview-*" | ForEach-Object {
    Write-Host "Preview Asset: $($_.Name) ($($_.Length) bytes)"
}
