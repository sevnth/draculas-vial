$f = Join-Path $PSScriptRoot "..\samples\executor.go"
if (Test-Path $f) {
    (Get-Item $f).Attributes = [System.IO.FileAttributes]::Normal
    [System.IO.File]::Delete($f)
    Write-Host "Deleted executor.go successfully"
}
