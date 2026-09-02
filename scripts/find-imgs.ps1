$imgDir = Join-Path $PSScriptRoot "..\images"
if (-not (Test-Path $imgDir)) {
    $imgDir = "C:\Users\sevnth\draculas-vial\images"
}
Get-ChildItem -Path $imgDir -Recurse -Include *.jpg,*.png,*.webp | ForEach-Object {
    Write-Host "$($_.FullName) | $($_.Length) bytes"
}
