$themesDir = Join-Path $PSScriptRoot "..\themes"
if (-not (Test-Path $themesDir)) {
    $themesDir = "C:\Users\sevnth\draculas-vial\themes"
}
$files = Get-ChildItem -Path $themesDir -Filter *.json

$totalPassed = 0
$totalFailed = 0

foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw | ConvertFrom-Json
        $colorCount = ($content.colors | Get-Member -MemberType NoteProperty).Count
        $tokenCount = $content.tokenColors.Count

        if ($colorCount -gt 50 -and $tokenCount -gt 10) {
            Write-Host "✅ $($file.Name): $($content.name) - $colorCount UI colors, $tokenCount token rules"
            $totalPassed++
        } else {
            Write-Host "❌ $($file.Name): Incomplete palette structure"
            $totalFailed++
        }
    } catch {
        Write-Host "❌ $($file.Name): Invalid JSON! ($($_.Exception.Message))"
        $totalFailed++
    }
}

Write-Host "--------------------------------------------------"
Write-Host "Summary: $totalPassed passed, $totalFailed failed."
if ($totalFailed -gt 0) { exit 1 } else { exit 0 }
