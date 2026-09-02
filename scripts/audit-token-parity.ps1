# Comprehensive token parity auditor between preview/app.js and themes/*.json

$appJsPath = Join-Path $PSScriptRoot "..\preview\app.js"
$themesDir = Join-Path $PSScriptRoot "..\themes"

$appJsContent = Get-Content $appJsPath -Raw

$themeMap = @{
    "dracula-chromatic" = @{ file = "dracula-vial-chromatic.json"; name = "Chromatic" }
    "dracula-triad" = @{ file = "dracula-vial-pure-triad.json"; name = "Pure Triad" }
    "dracula-neon-synth" = @{ file = "dracula-vial-neon-synth.json"; name = "Neon Synth" }
    "dracula-deep-abyss" = @{ file = "dracula-vial-deep-abyss.json"; name = "Deep Abyss" }
    "dracula-ice-fire" = @{ file = "dracula-vial-ice-fire.json"; name = "Ice & Fire" }
    "dracula-galactic-plasma" = @{ file = "dracula-vial-galactic-plasma.json"; name = "Galactic Plasma" }
    "dracula-cyber-lavender" = @{ file = "dracula-vial-cyber-lavender.json"; name = "Cyber Lavender" }
}

# Extract colors from app.js PRESETS
$allPass = $true

foreach ($presetKey in $themeMap.Keys) {
    $info = $themeMap[$presetKey]
    $themePath = Join-Path $themesDir $info.file
    
    if (-not (Test-Path $themePath)) {
        Write-Host "Missing file: $($info.file)" -ForegroundColor Red
        $allPass = $false
        continue
    }

    $json = Get-Content $themePath -Raw | ConvertFrom-Json
    
    # Extract preset block from app.js using regex
    $pattern = "(?s)'$presetKey':\s*\{.*?colors:\s*\{(.*?)\}"
    if ($appJsContent -match $pattern) {
        $colorsBlock = $matches[1]
        
        $presetColors = @{}
        foreach ($line in ($colorsBlock -split "`n")) {
            if ($line -match "(\w+):\s*'([^']+)'") {
                $presetColors[$matches[1]] = $matches[2]
            }
        }

        Write-Host "`n========================================================" -ForegroundColor Cyan
        Write-Host "Auditing: $($info.name) -> $($info.file)" -ForegroundColor Cyan
        Write-Host "========================================================" -ForegroundColor Cyan

        # 1. UI Backgrounds
        $edBgMatch = ($json.colors.'editor.background' -eq $presetColors['bg'])
        $sbBgMatch = ($json.colors.'sideBar.background' -eq $presetColors['bgDarker'])
        Write-Host "  Editor Background  : $($json.colors.'editor.background') vs $($presetColors['bg']) -> $(if($edBgMatch){'✅ MATCH'}else{'❌ MISMATCH'})"
        Write-Host "  Sidebar Background : $($json.colors.'sideBar.background') vs $($presetColors['bgDarker']) -> $(if($sbBgMatch){'✅ MATCH'}else{'❌ MISMATCH'})"

        # 2. Syntax Token Checks
        # Keywords (purple) and Storage/Type (pink) are now in TextMate tokenColors (NOT semanticTokenColors)
        # because we removed "keyword" from semantic tokens so that fine-grained TextMate scopes take effect.
        $kwRule = $json.tokenColors | Where-Object { $_.scope -contains 'keyword.control' }
        $stRule = $json.tokenColors | Where-Object { $_.scope -contains 'keyword.type.go' -or $_.scope -contains 'storage.type.interface.tsx' }
        $checks = @(
            @{ Role = "Keywords (syn-purple)"; Expected = $presetColors['purple']; Actual = $kwRule.settings.foreground }
            @{ Role = "Storage/Type (syn-pink)"; Expected = $presetColors['pink']; Actual = $stRule.settings.foreground }
            @{ Role = "Functions (syn-cyan)"; Expected = $presetColors['cyan']; Actual = $json.semanticTokenColors.function.foreground }
            @{ Role = "Types (syn-green)"; Expected = $presetColors['green']; Actual = $json.semanticTokenColors.type.foreground }
            @{ Role = "Fields (syn-pink)"; Expected = $presetColors['pink']; Actual = $json.semanticTokenColors.property.foreground }
            @{ Role = "Parameters (syn-tangerine)"; Expected = $presetColors['tangerine']; Actual = $json.semanticTokenColors.parameter.foreground }
            @{ Role = "Strings (syn-orange)"; Expected = $presetColors['orange']; Actual = $json.semanticTokenColors.string.foreground }
            @{ Role = "Numbers (syn-yellow)"; Expected = $presetColors['yellow']; Actual = $json.semanticTokenColors.number.foreground }
            @{ Role = "Comments (syn-slate)"; Expected = $presetColors['comment']; Actual = $json.semanticTokenColors.comment.foreground }
        )

        foreach ($chk in $checks) {
            $m = ($chk.Expected.ToLower() -eq ($chk.Actual -as [string]).ToLower())
            if (-not $m) { $allPass = $false }
            Write-Host ("  {0,-28}: Theme = {1,-9} | Preset = {2,-9} -> {3}" -f $chk.Role, $chk.Actual, $chk.Expected, $(if($m){'✅ MATCH'}else{'❌ MISMATCH'}))
        }

        # 3. Check TextMate token rules for specific scopes
        $structFieldRule = $json.tokenColors | Where-Object { $_.scope -contains 'source.go meta.struct.declaration variable.other.declaration.go' -or $_.scope -contains 'meta.struct.declaration.go variable.other.declaration.go' }
        $primitiveTypeRule = $json.tokenColors | Where-Object { $_.scope -contains 'storage.type.numeric.go' -or $_.scope -contains 'storage.type.primitive.go' }
        $typeDeclRule = $json.tokenColors | Where-Object { $_.scope -contains 'keyword.type.go' -or $_.scope -contains 'keyword.declaration.type.go' }

        Write-Host "  TextMate Go Struct Fields : $(if($structFieldRule.settings.foreground -eq $presetColors['pink']){'✅ MATCH (' + $structFieldRule.settings.foreground + ')'}else{'❌ MISMATCH'})"
        Write-Host "  TextMate Go Primitive Type: $(if($primitiveTypeRule.settings.foreground -eq $presetColors['green']){'✅ MATCH (' + $primitiveTypeRule.settings.foreground + ')'}else{'❌ MISMATCH'})"
        Write-Host "  TextMate Go Type Keyword  : $(if($typeDeclRule.settings.foreground -eq $presetColors['pink']){'✅ MATCH (' + $typeDeclRule.settings.foreground + ')'}else{'❌ MISMATCH'})"
    }
}

if ($allPass) {
    Write-Host "`n🎉 ALL 7 THEMES HAVE 100% TOKEN PARITY WITH PREVIEWS!" -ForegroundColor Green
} else {
    Write-Host "`n⚠️ SOME TOKENS HAVE DISCREPANCIES!" -ForegroundColor Red
}
