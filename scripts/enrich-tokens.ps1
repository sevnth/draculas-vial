# Script to enrich TextMate grammar scopes for Go, TypeScript, Python, Rust across all theme JSONs

$themesDir = Join-Path $PSScriptRoot "..\themes"
$files = Get-ChildItem -Path $themesDir -Filter *.json

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw | ConvertFrom-Json
    
    foreach ($rule in $content.tokenColors) {
        # Enrich struct fields and object keys
        if ($rule.name -match "Field|Property|Object Key") {
            $existing = @($rule.scope)
            $newScopes = @(
                "meta.struct.declaration.go variable.other.declaration.go",
                "meta.struct.declaration.go variable.other.assignment.go",
                "meta.struct.declaration.go variable",
                "meta.field.declaration.go variable",
                "source.go meta.struct.declaration variable",
                "variable.other.declaration.struct.go"
            )
            $merged = ($existing + $newScopes) | Select-Object -Unique
            $rule.scope = $merged
        }

        # Enrich function parameters
        if ($rule.name -match "Parameter") {
            $existing = @($rule.scope)
            $newScopes = @(
                "variable.parameter.go",
                "meta.function.parameters variable",
                "meta.parameters.go variable",
                "source.go meta.function.parameters variable",
                "variable.other.receiver.go"
            )
            $merged = ($existing + $newScopes) | Select-Object -Unique
            $rule.scope = $merged
        }

        # Enrich struct tags
        if ($rule.name -match "Tag|Attribute") {
            $existing = @($rule.scope)
            $newScopes = @(
                "meta.struct.tag.go",
                "entity.name.tag.go",
                "meta.struct.tag.go string",
                "meta.struct.tag.go string.quoted"
            )
            $merged = ($existing + $newScopes) | Select-Object -Unique
            $rule.scope = $merged
        }
    }

    $jsonStr = $content | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($f.FullName, $jsonStr, [System.Text.Encoding]::UTF8)
    Write-Host "Enriched: $($f.Name)"
}

Write-Host "All theme tokens enriched successfully!"
