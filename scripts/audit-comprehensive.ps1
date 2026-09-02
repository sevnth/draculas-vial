# Comprehensive Theme Audit - Deep Abyss
# Simulates what VS Code does with semantic tokens + TextMate fallback
# to verify the EXACT color every token type gets.

$json = Get-Content "themes\dracula-vial-deep-abyss.json" -Raw | ConvertFrom-Json

Write-Host "========================================================================"
Write-Host " COMPREHENSIVE THEME AUDIT: Deep Abyss"
Write-Host " Expected color mapping from preview/app.js:"
Write-Host "   syn-purple  = #9b5de5 (keywords: if, return, func, for, const, import)"
Write-Host "   syn-pink    = #f15bb5 (type/struct/interface keywords, struct fields)"
Write-Host "   syn-cyan    = #00f0ff (functions, methods, package names)"
Write-Host "   syn-green   = #00f5d4 (type names, primitive types)"
Write-Host "   syn-tangerine = #ff758f (parameters, receivers, attributes)"
Write-Host "   syn-orange  = #ff577f (strings)"
Write-Host "   syn-yellow  = #fee440 (numbers, nil, true, false)"
Write-Host "   syn-slate   = #4d5b75 (comments)"
Write-Host "   syn-fg      = #f0f4f8 (local variables)"
Write-Host "========================================================================"
Write-Host ""

$tests = @()
$pass = 0
$fail = 0

function Find-SemanticColor($tokenType) {
    $st = $json.semanticTokenColors
    $prop = $st.PSObject.Properties[$tokenType]
    if ($prop) { return $prop.Value.foreground }
    return $null
}

function Find-TextMateColor($scope) {
    # TextMate: most specific matching scope wins (highest segment count)
    $bestMatch = $null
    $bestSpecificity = -1
    foreach ($rule in $json.tokenColors) {
        foreach ($s in $rule.scope) {
            # Check if $s matches $scope (prefix match)
            if ($scope -eq $s -or $scope.StartsWith("$s.")) {
                $specificity = ($s.Split('.').Count)
                if ($specificity -gt $bestSpecificity) {
                    $bestSpecificity = $specificity
                    $bestMatch = $rule.settings.foreground
                }
            }
        }
    }
    return $bestMatch
}

function Test-Token($description, $semanticType, $textmateScope, $expected) {
    # VS Code logic: if semanticHighlighting=true AND semanticTokenColors has the type, use it.
    # Otherwise fall back to TextMate.
    $semColor = $null
    if ($semanticType) { $semColor = Find-SemanticColor $semanticType }
    $tmColor = $null
    if ($textmateScope) { $tmColor = Find-TextMateColor $textmateScope }
    
    # Final color: semantic wins if present, then TextMate
    $finalColor = if ($semColor) { $semColor } else { $tmColor }
    
    $match = ($finalColor -and $expected -and $finalColor.ToLower() -eq $expected.ToLower())
    $icon = if ($match) { "PASS" } else { "FAIL" }
    
    $source = if ($semColor) { "semantic" } else { "textmate" }
    Write-Host "  [$icon] $description"
    Write-Host "         Expected: $expected | Got: $finalColor ($source)"
    if (-not $match) {
        if ($semColor) { Write-Host "         Semantic ($semanticType) -> $semColor" }
        if ($tmColor) { Write-Host "         TextMate ($textmateScope) -> $tmColor" }
    }
    return $match
}

Write-Host "── Go Tokens ──────────────────────────────────────────────────"
Write-Host ""

# Go: `type` keyword -> should be PINK (#f15bb5)
# gopls assigns semantic "keyword" but we removed it, so TextMate wins
$r = Test-Token "'type' keyword in Go" $null "keyword.type.go" "#f15bb5"
if ($r) { $pass++ } else { $fail++ }

# Go: `struct` keyword -> should be PINK (#f15bb5)
$r = Test-Token "'struct' keyword in Go" $null "storage.type.struct.go" "#f15bb5"
if ($r) { $pass++ } else { $fail++ }

# Go: `func` keyword -> should be PURPLE (#9b5de5)
$r = Test-Token "'func' keyword in Go" $null "keyword.function.go" "#9b5de5"
if ($r) { $pass++ } else { $fail++ }

# Go: `if` keyword -> should be PURPLE (#9b5de5)
$r = Test-Token "'if' keyword in Go" $null "keyword.control" "#9b5de5"
if ($r) { $pass++ } else { $fail++ }

# Go: `return` keyword -> should be PURPLE (#9b5de5)
$r = Test-Token "'return' keyword in Go" $null "keyword.control.return" "#9b5de5"
if ($r) { $pass++ } else { $fail++ }

# Go: `import` keyword -> should be PURPLE (#9b5de5)
$r = Test-Token "'import' keyword in Go" $null "keyword.import.go" "#9b5de5"
if ($r) { $pass++ } else { $fail++ }

# Go: `for` keyword -> should be PURPLE (#9b5de5)
$r = Test-Token "'for' keyword in Go" $null "keyword.control.loop" "#9b5de5"
if ($r) { $pass++ } else { $fail++ }

# Go: `var` keyword -> should be PURPLE (#9b5de5)
$r = Test-Token "'var' keyword in Go" $null "keyword.var.go" "#9b5de5"
if ($r) { $pass++ } else { $fail++ }

# Go: `defer` keyword -> should be PURPLE (#9b5de5)
$r = Test-Token "'defer' keyword in Go" $null "keyword.control.go" "#9b5de5"
if ($r) { $pass++ } else { $fail++ }

# Go: Type name 'Executor' -> should be GREEN (#00f5d4) via semantic "type"
$r = Test-Token "Type name 'Executor' in Go" "type" "entity.name.type.go" "#00f5d4"
if ($r) { $pass++ } else { $fail++ }

# Go: Primitive type 'string' -> should be GREEN (#00f5d4) via semantic "type"
$r = Test-Token "Primitive type 'string' in Go" "type" "storage.type.string.go" "#00f5d4"
if ($r) { $pass++ } else { $fail++ }

# Go: Primitive type 'bool' -> should be GREEN (#00f5d4)
$r = Test-Token "Primitive type 'bool' in Go" "type" "storage.type.boolean.go" "#00f5d4"
if ($r) { $pass++ } else { $fail++ }

# Go: Primitive type 'uint32' -> should be GREEN (#00f5d4)
$r = Test-Token "Primitive type 'uint32' in Go" "type" "storage.type.uint32.go" "#00f5d4"
if ($r) { $pass++ } else { $fail++ }

# Go: Struct field 'client' -> should be PINK (#f15bb5) via semantic "property"
$r = Test-Token "Struct field 'client' in Go" "property" "variable.other.property.go" "#f15bb5"
if ($r) { $pass++ } else { $fail++ }

# Go: Struct field 'pools' -> should be PINK (#f15bb5)
$r = Test-Token "Struct field 'pools' in Go" "property" "variable.other.member.go" "#f15bb5"
if ($r) { $pass++ } else { $fail++ }

# Go: Function name 'NewExecutor' -> should be CYAN (#00f0ff) via semantic "function"
$r = Test-Token "Function 'NewExecutor' in Go" "function" "entity.name.function.go" "#00f0ff"
if ($r) { $pass++ } else { $fail++ }

# Go: Method name 'Lock' -> should be CYAN (#00f0ff) via semantic "method"
$r = Test-Token "Method 'Lock' in Go" "method" "entity.name.function.go" "#00f0ff"
if ($r) { $pass++ } else { $fail++ }

# Go: Parameter 'rpcURL' -> should be TANGERINE (#ff758f) via semantic "parameter"
$r = Test-Token "Parameter 'rpcURL' in Go" "parameter" "variable.parameter.go" "#ff758f"
if ($r) { $pass++ } else { $fail++ }

# Go: Receiver 'e' -> should be TANGERINE (#ff758f) via semantic "parameter"
$r = Test-Token "Receiver 'e' in Go" "parameter" "variable.other.receiver.go" "#ff758f"
if ($r) { $pass++ } else { $fail++ }

# Go: Package name 'fmt' -> should be CYAN (#00f0ff) via semantic "namespace"
$r = Test-Token "Package 'fmt' in Go" "namespace" "entity.name.package.go" "#00f0ff"
if ($r) { $pass++ } else { $fail++ }

# Go: String literal -> should be ORANGE (#ff577f)
$r = Test-Token "String literal in Go" "string" "string.quoted.double" "#ff577f"
if ($r) { $pass++ } else { $fail++ }

# Go: Struct tag `json:"..."` -> should be TANGERINE (#ff758f)
$r = Test-Token "Struct tag in Go" $null "string.quoted.raw.go" "#ff758f"
if ($r) { $pass++ } else { $fail++ }

# Go: Number literal -> should be YELLOW (#fee440)
$r = Test-Token "Number literal in Go" "number" "constant.numeric" "#fee440"
if ($r) { $pass++ } else { $fail++ }

# Go: nil -> should be YELLOW (#fee440)
$r = Test-Token "'nil' constant in Go" $null "constant.language.nil.go" "#fee440"
if ($r) { $pass++ } else { $fail++ }

# Go: Comment -> should be SLATE (#4d5b75)
$r = Test-Token "Comment in Go" "comment" "comment.line.double-slash" "#4d5b75"
if ($r) { $pass++ } else { $fail++ }

# Go: Local variable 'err' -> should be FG (#f0f4f8) via semantic "variable"
$r = Test-Token "Local var 'err' in Go" "variable" "variable.other" "#f0f4f8"
if ($r) { $pass++ } else { $fail++ }

Write-Host ""
Write-Host "── TSX Tokens ─────────────────────────────────────────────────"
Write-Host ""

# TSX: `interface` keyword -> should be PINK (#f15bb5) (no semantic keyword override)
$r = Test-Token "'interface' keyword in TSX" $null "storage.type.interface.tsx" "#f15bb5"
if ($r) { $pass++ } else { $fail++ }

# TSX: Interface name 'VialMetric' -> should be GREEN (#00f5d4) via semantic "interface"
$r = Test-Token "Interface name 'VialMetric' in TSX" "interface" "entity.name.type.interface.tsx" "#00f5d4"
if ($r) { $pass++ } else { $fail++ }

# TSX: Interface field 'id' -> should be PINK (#f15bb5) via semantic "property"
$r = Test-Token "Interface field 'id' in TSX" "property" "entity.name.variable.field.tsx" "#f15bb5"
if ($r) { $pass++ } else { $fail++ }

# TSX: Primitive type 'string' -> should be GREEN (#00f5d4) via semantic "type.defaultLibrary"
$r = Test-Token "Primitive type 'string' in TSX" "type.defaultLibrary" "support.type.primitive.tsx" "#00f5d4"
if ($r) { $pass++ } else { $fail++ }

# TSX: `export` keyword -> should be PURPLE (#9b5de5)
$r = Test-Token "'export' keyword in TSX" $null "keyword.control.export" "#9b5de5"
if ($r) { $pass++ } else { $fail++ }

# TSX: `const` keyword -> should be PURPLE (#9b5de5)
$r = Test-Token "'const' keyword in TSX" $null "storage.type.const" "#9b5de5"
if ($r) { $pass++ } else { $fail++ }

# TSX: Function name 'useState' -> should be CYAN (#00f0ff) via semantic "function"
$r = Test-Token "Function 'useState' in TSX" "function" "support.function.tsx" "#00f0ff"
if ($r) { $pass++ } else { $fail++ }

# TSX: Function name 'fetchTelemetry' -> should be CYAN (#00f0ff)
$r = Test-Token "Function 'fetchTelemetry' in TSX" "function" "entity.name.function.tsx" "#00f0ff"
if ($r) { $pass++ } else { $fail++ }

# TSX: Parameter 'title' (destructured) -> should be TANGERINE (#ff758f) via semantic "parameter"
$r = Test-Token "Parameter 'title' in TSX" "parameter" "variable.parameter.tsx" "#ff758f"
if ($r) { $pass++ } else { $fail++ }

# TSX: `try` keyword -> should be PURPLE (#9b5de5)
$r = Test-Token "'try' keyword in TSX" $null "keyword.control.trycatch" "#9b5de5"
if ($r) { $pass++ } else { $fail++ }

# TSX: `catch` keyword -> should be PURPLE (#9b5de5)
$r = Test-Token "'catch' keyword in TSX" $null "keyword.control.trycatch" "#9b5de5"
if ($r) { $pass++ } else { $fail++ }

# TSX: `finally` keyword -> should be PURPLE (#9b5de5)
$r = Test-Token "'finally' keyword in TSX" $null "keyword.control.trycatch" "#9b5de5"
if ($r) { $pass++ } else { $fail++ }

# TSX: `async` keyword -> should be PURPLE (#9b5de5)
$r = Test-Token "'async' keyword in TSX" $null "keyword.control.async" "#9b5de5"
if ($r) { $pass++ } else { $fail++ }

# TSX: `await` keyword -> should be PURPLE (#9b5de5)
$r = Test-Token "'await' keyword in TSX" $null "keyword.control.await" "#9b5de5"
if ($r) { $pass++ } else { $fail++ }

# TSX: `return` keyword -> should be PURPLE (#9b5de5)
$r = Test-Token "'return' keyword in TSX" $null "keyword.control.return" "#9b5de5"
if ($r) { $pass++ } else { $fail++ }

# TSX: JSX tag 'div' -> should be CYAN (#00f0ff)
$r = Test-Token "JSX tag 'div' in TSX" $null "entity.name.tag.tsx" "#00f0ff"
if ($r) { $pass++ } else { $fail++ }

# TSX: JSX attribute 'className' -> should be TANGERINE (#ff758f)
$r = Test-Token "JSX attribute 'className' in TSX" $null "entity.other.attribute-name.tsx" "#ff758f"
if ($r) { $pass++ } else { $fail++ }

# TSX: String literal 'all' -> should be ORANGE (#ff577f)
$r = Test-Token "String literal in TSX" "string" "string.quoted.single" "#ff577f"
if ($r) { $pass++ } else { $fail++ }

# TSX: Boolean 'true' -> should be YELLOW (#fee440)
$r = Test-Token "Boolean 'true' in TSX" $null "constant.language.true" "#fee440"
if ($r) { $pass++ } else { $fail++ }

# TSX: Number '3000' -> should be YELLOW (#fee440)
$r = Test-Token "Number '3000' in TSX" "number" "constant.numeric.integer" "#fee440"
if ($r) { $pass++ } else { $fail++ }

# TSX: Local variable 'metrics' -> should be FG (#f0f4f8)
$r = Test-Token "Local var 'metrics' in TSX" "variable" "variable.other.readwrite" "#f0f4f8"
if ($r) { $pass++ } else { $fail++ }

# TSX: Property access '.length' -> should be PINK (#f15bb5)
$r = Test-Token "Property '.length' in TSX" "property" "variable.other.property" "#f15bb5"
if ($r) { $pass++ } else { $fail++ }

# TSX: `import` keyword -> should be PURPLE (#9b5de5)
$r = Test-Token "'import' keyword in TSX" $null "keyword.control.import" "#9b5de5"
if ($r) { $pass++ } else { $fail++ }

# TSX: `from` keyword -> should be PURPLE (#9b5de5)
$r = Test-Token "'from' keyword in TSX" $null "keyword.control.from" "#9b5de5"
if ($r) { $pass++ } else { $fail++ }

# TSX: 'console' (defaultLibrary) -> should be GREEN (#00f5d4)
$r = Test-Token "'console' object in TSX" "variable.defaultLibrary" $null "#00f5d4"
if ($r) { $pass++ } else { $fail++ }

# TSX: Method 'error' on console -> should be CYAN (#00f0ff)
$r = Test-Token "Method 'error' on console in TSX" "method" "support.function.tsx" "#00f0ff"
if ($r) { $pass++ } else { $fail++ }

Write-Host ""
Write-Host "========================================================================"
Write-Host " RESULTS: $pass passed / $($pass + $fail) total ($fail failed)"
if ($fail -eq 0) {
    Write-Host " ALL TOKENS MATCH PREVIEW! Theme is 100% aligned."
} else {
    Write-Host " $fail TOKENS MISMATCH - needs further investigation."
}
Write-Host "========================================================================"
