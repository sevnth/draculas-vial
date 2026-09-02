# Comprehensive theme alignment script
# Aligns all 7 themes with the HTML preview design architecture

$themeConfigs = @{
    "dracula-vial-chromatic.json" = @{
        purple = "#bd93f9"; cyan = "#8be9fd"; orange = "#ffb86c"; green = "#50fa7b"; yellow = "#f1fa8c"
        pink = "#ff79c6"; tangerine = "#ff9e64"; comment = "#68759e"; fg = "#f8f8f2"; bg = "#21222c"; bgDarker = "#191a21"
    }
    "dracula-vial-pure-triad.json" = @{
        purple = "#bd93f9"; cyan = "#8be9fd"; orange = "#ffb86c"; green = "#8be9fd"; yellow = "#ffb86c"
        pink = "#ffb86c"; tangerine = "#ffb86c"; comment = "#68759e"; fg = "#f8f8f2"; bg = "#21222c"; bgDarker = "#191a21"
    }
    "dracula-vial-neon-synth.json" = @{
        purple = "#ff2a85"; cyan = "#00e5ff"; orange = "#ff6b35"; green = "#05ffa1"; yellow = "#ffe600"
        pink = "#c77dff"; tangerine = "#ff6b35"; comment = "#636987"; fg = "#ffffff"; bg = "#161824"; bgDarker = "#12131c"
    }
    "dracula-vial-deep-abyss.json" = @{
        purple = "#9b5de5"; cyan = "#00f0ff"; orange = "#ff577f"; green = "#00f5d4"; yellow = "#fee440"
        pink = "#f15bb5"; tangerine = "#ff758f"; comment = "#4d5b75"; fg = "#f0f4f8"; bg = "#0e1017"; bgDarker = "#080a0f"
    }
    "dracula-vial-ice-fire.json" = @{
        purple = "#9254de"; cyan = "#00d2ff"; orange = "#ff7a45"; green = "#36cfc9"; yellow = "#ffc53d"
        pink = "#f759ab"; tangerine = "#ffa940"; comment = "#4d6b8a"; fg = "#f0f8ff"; bg = "#0f141d"; bgDarker = "#080c12"
    }
    "dracula-vial-galactic-plasma.json" = @{
        purple = "#c084fc"; cyan = "#22d3ee"; orange = "#f472b6"; green = "#34d399"; yellow = "#fbbf24"
        pink = "#e879f9"; tangerine = "#fb923c"; comment = "#5e638c"; fg = "#f5f3ff"; bg = "#111222"; bgDarker = "#0a0b16"
    }
    "dracula-vial-cyber-lavender.json" = @{
        purple = "#d8b4fe"; cyan = "#67e8f9"; orange = "#fda4af"; green = "#86efac"; yellow = "#fef08a"
        pink = "#e9d5ff"; tangerine = "#fbcfe8"; comment = "#6b6f8a"; fg = "#f8f7fc"; bg = "#151622"; bgDarker = "#0f101a"
    }
}

$themesDir = Join-Path $PSScriptRoot "..\themes"

foreach ($file in $themeConfigs.Keys) {
    $filePath = Join-Path $themesDir $file
    if (-not (Test-Path $filePath)) { continue }

    $c = $themeConfigs[$file]
    $json = Get-Content $filePath -Raw | ConvertFrom-Json

    # 1. Update semanticTokenColors
    $json.semanticTokenColors = [PSCustomObject]@{
        "keyword" = [PSCustomObject]@{ foreground = $c.purple }
        "storage" = [PSCustomObject]@{ foreground = $c.pink }
        "storage.type" = [PSCustomObject]@{ foreground = $c.pink }
        "type" = [PSCustomObject]@{ foreground = $c.green; fontStyle = "italic" }
        "class" = [PSCustomObject]@{ foreground = $c.green }
        "interface" = [PSCustomObject]@{ foreground = $c.green; fontStyle = "italic" }
        "struct" = [PSCustomObject]@{ foreground = $c.green }
        "function" = [PSCustomObject]@{ foreground = $c.cyan }
        "method" = [PSCustomObject]@{ foreground = $c.cyan }
        "string" = [PSCustomObject]@{ foreground = $c.orange }
        "number" = [PSCustomObject]@{ foreground = $c.yellow }
        "comment" = [PSCustomObject]@{ foreground = $c.comment; fontStyle = "italic" }
        "parameter" = [PSCustomObject]@{ foreground = $c.tangerine; fontStyle = "italic" }
        "property" = [PSCustomObject]@{ foreground = $c.pink }
        "property.readonly" = [PSCustomObject]@{ foreground = $c.pink }
        "variable.other.property" = [PSCustomObject]@{ foreground = $c.pink }
        "variable.other.member" = [PSCustomObject]@{ foreground = $c.pink }
        "enumMember" = [PSCustomObject]@{ foreground = $c.yellow }
        "variable.constant" = [PSCustomObject]@{ foreground = $c.yellow }
        "operator" = [PSCustomObject]@{ foreground = $c.purple }
    }

    # 2. Rebuild clean, comprehensive tokenColors
    $json.tokenColors = @(
        @{
            name = "Comments & Documentation"
            scope = @("comment", "punctuation.definition.comment", "comment.block.documentation", "comment.line.documentation")
            settings = @{ foreground = $c.comment; fontStyle = "italic" }
        },
        @{
            name = "Keywords & Control Flow"
            scope = @("keyword", "keyword.control", "keyword.control.flow", "keyword.control.import", "keyword.control.export", "keyword.declaration")
            settings = @{ foreground = $c.purple; fontStyle = "bold" }
        },
        @{
            name = "Storage Modifiers & Definition Types (type, struct, interface)"
            scope = @(
                "storage", "storage.type", "storage.modifier", "storage.type.function", "storage.type.class",
                "storage.type.struct", "storage.type.interface", "storage.type.enum", "storage.type.type",
                "keyword.declaration.type", "keyword.declaration.struct", "keyword.declaration.interface",
                "storage.type.var", "storage.type.let", "storage.type.const"
            )
            settings = @{ foreground = $c.pink }
        },
        @{
            name = "Functions & Methods"
            scope = @(
                "entity.name.function", "entity.name.function.definition", "entity.name.function.call",
                "support.function", "support.function.builtin", "meta.function-call", "meta.method-call"
            )
            settings = @{ foreground = $c.cyan }
        },
        @{
            name = "Types, Structs & Interfaces"
            scope = @(
                "entity.name.type", "entity.name.type.class", "entity.name.type.struct", "entity.name.type.interface",
                "entity.name.type.enum", "entity.name.class", "support.type", "support.class", "support.type.primitive"
            )
            settings = @{ foreground = $c.green; fontStyle = "italic" }
        },
        @{
            name = "Package & Namespace Identifiers"
            scope = @("entity.name.package", "entity.name.package.go", "entity.name.namespace", "support.other.namespace")
            settings = @{ foreground = $c.cyan }
        },
        @{
            name = "Strings & Text Literals"
            scope = @("string", "string.quoted", "string.quoted.single", "string.quoted.double", "string.template")
            settings = @{ foreground = $c.orange }
        },
        @{
            name = "Struct Tags & Raw Strings"
            scope = @(
                "meta.struct.tag.go", "entity.name.tag.go", "meta.struct.tag.go string",
                "string.quoted.raw.go", "entity.other.attribute-name", "entity.other.attribute-name.html",
                "entity.other.attribute-name.jsx", "entity.other.attribute-name.tsx"
            )
            settings = @{ foreground = $c.tangerine }
        },
        @{
            name = "Numbers & Numerics"
            scope = @("constant.numeric", "constant.numeric.integer", "constant.numeric.float", "constant.numeric.hex")
            settings = @{ foreground = $c.yellow }
        },
        @{
            name = "Language Booleans & Nil / Null"
            scope = @(
                "constant.language", "constant.language.boolean", "constant.language.null",
                "constant.language.nil", "constant.language.undefined", "constant.language.true", "constant.language.false"
            )
            settings = @{ foreground = $c.yellow; fontStyle = "bold" }
        },
        @{
            name = "Constants & Enum Members"
            scope = @("constant.other", "variable.other.constant", "variable.other.enummember")
            settings = @{ foreground = $c.yellow }
        },
        @{
            name = "Parameters & Receivers"
            scope = @(
                "variable.parameter", "variable.parameter.function", "variable.parameter.go",
                "meta.parameter", "meta.parameters", "meta.function.parameters variable",
                "meta.parameters.go variable", "source.go meta.function.parameters variable",
                "variable.other.receiver.go"
            )
            settings = @{ foreground = $c.tangerine; fontStyle = "italic" }
        },
        @{
            name = "Struct Fields & Object Properties"
            scope = @(
                "meta.object-literal.key", "variable.object.property", "support.type.property-name",
                "entity.name.variable.field", "variable.other.property", "variable.other.object.property",
                "variable.other.member", "meta.struct.declaration.go variable",
                "meta.struct.declaration.go variable.other.declaration.go",
                "meta.struct.declaration.go variable.other.assignment.go",
                "meta.struct.declaration.go variable.other",
                "meta.field.declaration.go variable",
                "source.go meta.struct.declaration variable",
                "source.go meta.struct.declaration variable.other.declaration",
                "meta.composite-literal.go variable",
                "meta.composite-literal.go variable.other.assignment",
                "meta.composite-literal.go variable.other.assignment.go",
                "variable.other.declaration.struct.go",
                "meta.field.declaration variable"
            )
            settings = @{ foreground = $c.pink }
        },
        @{
            name = "Tags & JSX Elements"
            scope = @("entity.name.tag", "entity.name.tag.custom", "entity.name.tag.jsx", "entity.name.tag.tsx", "support.class.component")
            settings = @{ foreground = $c.cyan }
        },
        @{
            name = "Operators & Punctuation"
            scope = @("keyword.operator", "keyword.operator.arithmetic", "keyword.operator.bitwise", "keyword.operator.assignment", "keyword.operator.comparison")
            settings = @{ foreground = $c.purple }
        },
        @{
            name = "Delimiters & Brackets"
            scope = @("punctuation.brackets", "punctuation.curly.brace", "punctuation.square.bracket")
            settings = @{ foreground = $c.purple }
        },
        @{
            name = "Variables (Default)"
            scope = @("variable", "variable.other", "variable.other.readwrite")
            settings = @{ foreground = $c.fg }
        },
        @{
            name = "Punctuation & Delimiters"
            scope = @("punctuation", "punctuation.separator", "punctuation.terminator", "punctuation.definition.block")
            settings = @{ foreground = $c.fg }
        },
        @{
            name = "Invalid"
            scope = @("invalid", "invalid.illegal")
            settings = @{ foreground = "#ff5555" }
        }
    )

    $jsonStr = $json | ConvertTo-Json -Depth 20
    [System.IO.File]::WriteAllText($filePath, $jsonStr, [System.Text.Encoding]::UTF8)
    Write-Host "Aligned theme: $file"
}

Write-Host "All 7 themes perfectly aligned with HTML preview architecture!"
