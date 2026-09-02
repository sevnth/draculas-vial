# Verify deep abyss theme structure
$json = Get-Content "themes\dracula-vial-deep-abyss.json" -Raw | ConvertFrom-Json

Write-Host "=== semanticTokenColors keys ==="
$json.semanticTokenColors.PSObject.Properties | ForEach-Object { Write-Host $_.Name }

Write-Host ""
Write-Host "=== Check keyword/storage are ABSENT ==="
if ($json.semanticTokenColors.PSObject.Properties['keyword']) { Write-Host "FAIL: keyword STILL PRESENT" } else { Write-Host "PASS: keyword is ABSENT" }
if ($json.semanticTokenColors.PSObject.Properties['storage']) { Write-Host "FAIL: storage STILL PRESENT" } else { Write-Host "PASS: storage is ABSENT" }
if ($json.semanticTokenColors.PSObject.Properties['storage.type']) { Write-Host "FAIL: storage.type STILL PRESENT" } else { Write-Host "PASS: storage.type is ABSENT" }

Write-Host ""
Write-Host "=== Verify TextMate keyword scopes ==="
foreach ($rule in $json.tokenColors) {
    $scopes = $rule.scope
    if ($scopes -contains "keyword.type.go") {
        Write-Host "keyword.type.go -> $($rule.settings.foreground) ($($rule.name))"
    }
    if ($scopes -contains "storage.type.interface.tsx") {
        Write-Host "storage.type.interface.tsx -> $($rule.settings.foreground) ($($rule.name))"
    }
    if ($scopes -contains "keyword.control") {
        Write-Host "keyword.control -> $($rule.settings.foreground) ($($rule.name))"
    }
    if ($scopes -contains "keyword.function.go") {
        Write-Host "keyword.function.go -> $($rule.settings.foreground) ($($rule.name))"
    }
    if ($scopes -contains "storage.type") {
        Write-Host "storage.type (generic) -> $($rule.settings.foreground) ($($rule.name))"
    }
    if ($scopes -contains "variable.parameter") {
        Write-Host "variable.parameter -> $($rule.settings.foreground) ($($rule.name))"
    }
    if ($scopes -contains "variable.other.property") {
        Write-Host "variable.other.property -> $($rule.settings.foreground) ($($rule.name))"
    }
}

Write-Host ""
Write-Host "=== Semantic token property -> pink ==="
Write-Host "property -> $($json.semanticTokenColors.property.foreground)"
Write-Host "parameter -> $($json.semanticTokenColors.parameter.foreground)"
Write-Host "type -> $($json.semanticTokenColors.type.foreground)"
Write-Host "function -> $($json.semanticTokenColors.function.foreground)"
Write-Host "variable -> $($json.semanticTokenColors.variable.foreground)"
