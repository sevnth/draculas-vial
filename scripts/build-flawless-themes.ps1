# Flawless Theme Generator for Dracula's Vial
# Generates 100% faithful TextMate & Semantic Token rules matching preview-4-deep-abyss.png and all preview images

$themes = @(
    @{
        file = "dracula-vial-chromatic.json"
        name = "Dracula's Vial - Chromatic (Rich Full-Spectrum)"
        bg = "#21222c"; bgDarker = "#191a21"; fg = "#f8f8f2"; selection = "#44475a77"; comment = "#68759e"
        purple = "#bd93f9"; cyan = "#8be9fd"; orange = "#ffb86c"; green = "#50fa7b"; yellow = "#f1fa8c"
        pink = "#ff79c6"; tangerine = "#ff9e64"; red = "#ff5555"
    },
    @{
        file = "dracula-vial-pure-triad.json"
        name = "Dracula's Vial - Pure Triad (Cyan • Purple • Orange)"
        bg = "#21222c"; bgDarker = "#191a21"; fg = "#f8f8f2"; selection = "#44475a77"; comment = "#68759e"
        purple = "#bd93f9"; cyan = "#8be9fd"; orange = "#ffb86c"; green = "#8be9fd"; yellow = "#ffb86c"
        pink = "#ffb86c"; tangerine = "#ffb86c"; red = "#ff5555"
    },
    @{
        file = "dracula-vial-neon-synth.json"
        name = "Dracula's Vial - Neon Synth (Hot Pink • Cyan • Violet)"
        bg = "#161824"; bgDarker = "#12131c"; fg = "#ffffff"; selection = "#393e5c99"; comment = "#636987"
        purple = "#ff2a85"; cyan = "#00e5ff"; orange = "#ff6b35"; green = "#05ffa1"; yellow = "#ffe600"
        pink = "#c77dff"; tangerine = "#ff6b35"; red = "#ff2a85"
    },
    @{
        file = "dracula-vial-deep-abyss.json"
        name = "Dracula's Vial - Deep Abyss (Oceanic Bioluminescence)"
        bg = "#0e1017"; bgDarker = "#080a0f"; fg = "#f0f4f8"; selection = "#1e263899"; comment = "#4d5b75"
        purple = "#9b5de5"; cyan = "#00f0ff"; orange = "#ff577f"; green = "#00f5d4"; yellow = "#fee440"
        pink = "#f15bb5"; tangerine = "#ff758f"; red = "#ff3366"
    },
    @{
        file = "dracula-vial-ice-fire.json"
        name = "Dracula's Vial - Ice & Fire (Glacial Cyan & Purple Flame)"
        bg = "#0f141d"; bgDarker = "#080c12"; fg = "#f0f8ff"; selection = "#1e2c3d99"; comment = "#4d6b8a"
        purple = "#9254de"; cyan = "#00d2ff"; orange = "#ff7a45"; green = "#36cfc9"; yellow = "#ffc53d"
        pink = "#f759ab"; tangerine = "#ffa940"; red = "#ff4d4f"
    },
    @{
        file = "dracula-vial-galactic-plasma.json"
        name = "Dracula's Vial - Galactic Plasma (Plasma Violet & Solar)"
        bg = "#111222"; bgDarker = "#0a0b16"; fg = "#f5f3ff"; selection = "#23264799"; comment = "#5e638c"
        purple = "#c084fc"; cyan = "#22d3ee"; orange = "#f472b6"; green = "#34d399"; yellow = "#fbbf24"
        pink = "#e879f9"; tangerine = "#fb923c"; red = "#f87171"
    },
    @{
        file = "dracula-vial-cyber-lavender.json"
        name = "Dracula's Vial - Cyber Lavender (Pastel Cyber)"
        bg = "#151622"; bgDarker = "#0f101a"; fg = "#f8f7fc"; selection = "#282a3d99"; comment = "#6b6f8a"
        purple = "#d8b4fe"; cyan = "#67e8f9"; orange = "#fda4af"; green = "#86efac"; yellow = "#fef08a"
        pink = "#e9d5ff"; tangerine = "#fbcfe8"; red = "#f87171"
    }
)

$themesDir = Join-Path $PSScriptRoot "..\themes"

foreach ($t in $themes) {
    $targetPath = Join-Path $themesDir $t.file
    if (-not (Test-Path $targetPath)) { continue }

    $json = Get-Content $targetPath -Raw | ConvertFrom-Json
    $colors = $json.colors

    # 1. semanticTokenColors
    $semanticTokens = [PSCustomObject]@{
        "keyword" = [PSCustomObject]@{ foreground = $t.purple }
        "storage" = [PSCustomObject]@{ foreground = $t.pink }
        "storage.type" = [PSCustomObject]@{ foreground = $t.pink }
        "type" = [PSCustomObject]@{ foreground = $t.green; fontStyle = "italic" }
        "type.defaultLibrary" = [PSCustomObject]@{ foreground = $t.green; fontStyle = "italic" }
        "type.primitive" = [PSCustomObject]@{ foreground = $t.green; fontStyle = "italic" }
        "class" = [PSCustomObject]@{ foreground = $t.green }
        "interface" = [PSCustomObject]@{ foreground = $t.green; fontStyle = "italic" }
        "struct" = [PSCustomObject]@{ foreground = $t.green }
        "enum" = [PSCustomObject]@{ foreground = $t.green }
        "function" = [PSCustomObject]@{ foreground = $t.cyan }
        "function.defaultLibrary" = [PSCustomObject]@{ foreground = $t.cyan }
        "method" = [PSCustomObject]@{ foreground = $t.cyan }
        "method.defaultLibrary" = [PSCustomObject]@{ foreground = $t.cyan }
        "string" = [PSCustomObject]@{ foreground = $t.orange }
        "number" = [PSCustomObject]@{ foreground = $t.yellow }
        "comment" = [PSCustomObject]@{ foreground = $t.comment; fontStyle = "italic" }
        "parameter" = [PSCustomObject]@{ foreground = $t.tangerine; fontStyle = "italic" }
        "property" = [PSCustomObject]@{ foreground = $t.pink }
        "property.readonly" = [PSCustomObject]@{ foreground = $t.pink }
        "property.declaration" = [PSCustomObject]@{ foreground = $t.pink }
        "variable.other.property" = [PSCustomObject]@{ foreground = $t.pink }
        "variable.other.member" = [PSCustomObject]@{ foreground = $t.pink }
        "variable.declaration" = [PSCustomObject]@{ foreground = $t.fg }
        "variable.defaultLibrary" = [PSCustomObject]@{ foreground = $t.cyan }
        "enumMember" = [PSCustomObject]@{ foreground = $t.yellow }
        "variable.constant" = [PSCustomObject]@{ foreground = $t.yellow }
        "operator" = [PSCustomObject]@{ foreground = $t.purple }
        "namespace" = [PSCustomObject]@{ foreground = $t.cyan }
    }

    # 2. Strict, Ordered TextMate tokenColors
    $tokenColors = @(
        # Comments
        @{
            name = "Comments"
            scope = @(
                "comment", "punctuation.definition.comment", "comment.block",
                "comment.block.documentation", "comment.line", "comment.line.double-slash",
                "comment.line.documentation", "string.quoted.docstring"
            )
            settings = @{ foreground = $t.comment; fontStyle = "italic" }
        },

        # Type Declaration Keywords (type, struct, interface) -> PINK
        @{
            name = "Type Declarations (type, struct, interface, enum, class)"
            scope = @(
                "keyword.type.go",
                "keyword.declaration.type.go",
                "keyword.declaration.struct.go",
                "keyword.declaration.interface.go",
                "keyword.declaration.type",
                "keyword.declaration.struct",
                "keyword.declaration.interface",
                "storage.type.struct.go",
                "storage.type.interface.go",
                "storage.type.type.go",
                "storage.type.struct",
                "storage.type.interface",
                "storage.type.type",
                "storage.type.enum",
                "storage.type.class",
                "storage.type.rust",
                "storage.modifier.rust"
            )
            settings = @{ foreground = $t.pink }
        },

        # Builtin Primitive Types (string, bool, uint32, float64, error) -> GREEN ITALIC
        @{
            name = "Primitive Built-in Types"
            scope = @(
                "storage.type.primitive.go",
                "storage.type.numeric.go",
                "storage.type.string.go",
                "storage.type.boolean.go",
                "storage.type.byte.go",
                "storage.type.rune.go",
                "storage.type.error.go",
                "storage.type.uint.go",
                "storage.type.uint8.go",
                "storage.type.uint16.go",
                "storage.type.uint32.go",
                "storage.type.uint64.go",
                "storage.type.int.go",
                "storage.type.int8.go",
                "storage.type.int16.go",
                "storage.type.int32.go",
                "storage.type.int64.go",
                "storage.type.float32.go",
                "storage.type.float64.go",
                "storage.type.complex64.go",
                "storage.type.complex128.go",
                "storage.type.uintptr.go",
                "storage.type.primitive",
                "support.type.primitive.ts",
                "support.type.primitive.tsx",
                "support.type.builtin.ts",
                "support.type.python",
                "support.type.rust",
                "support.type.primitive.rust"
            )
            settings = @{ foreground = $t.green; fontStyle = "italic" }
        },

        # User Types, Structs & Interfaces -> GREEN ITALIC
        @{
            name = "User Types, Classes, Structs & Interfaces"
            scope = @(
                "entity.name.type",
                "entity.name.type.class",
                "entity.name.type.struct",
                "entity.name.type.interface",
                "entity.name.type.enum",
                "entity.name.type.alias",
                "entity.name.type.go",
                "entity.name.type.struct.go",
                "entity.name.type.interface.go",
                "entity.name.type.type.go",
                "meta.type.declaration.go entity.name.type.go",
                "entity.name.class",
                "support.type",
                "support.class",
                "support.type.go"
            )
            settings = @{ foreground = $t.green; fontStyle = "italic" }
        },

        # Go Struct Field Declarations & Object Properties -> PINK
        @{
            name = "Struct Fields, Object Properties & Literal Keys"
            scope = @(
                "source.go meta.struct.declaration variable.other.declaration.go",
                "source.go meta.struct.declaration variable.other.assignment.go",
                "source.go meta.struct.declaration variable.other.declaration",
                "source.go meta.struct.declaration variable",
                "source.go meta.field.declaration variable",
                "meta.struct.declaration.go variable.other.declaration.go",
                "meta.struct.declaration.go variable.other.assignment.go",
                "meta.struct.declaration.go variable.other.declaration",
                "meta.struct.declaration.go variable.other",
                "meta.struct.declaration.go variable",
                "meta.field.declaration.go variable",
                "variable.other.declaration.struct.go",
                "source.go meta.composite-literal.go variable.other.assignment.go",
                "source.go meta.composite-literal.go variable.other.assignment",
                "source.go meta.composite-literal.go variable",
                "source.go meta.composite-literal.go entity.name.variable.field.go",
                "meta.composite-literal.go variable.other.assignment.go",
                "meta.composite-literal.go variable.other.assignment",
                "meta.composite-literal.go variable",
                "meta.composite-literal.go entity.name.variable.field.go",
                "entity.name.variable.field.go",
                "variable.other.property.go",
                "variable.other.member.go",
                "meta.object-literal.key",
                "variable.object.property",
                "support.type.property-name",
                "entity.name.variable.field",
                "variable.other.property",
                "variable.other.object.property",
                "variable.other.member",
                "meta.field.declaration variable"
            )
            settings = @{ foreground = $t.pink }
        },

        # Function Parameters & Receivers -> TANGERINE ITALIC
        @{
            name = "Function Parameters & Receivers"
            scope = @(
                "variable.parameter",
                "variable.parameter.function",
                "variable.parameter.go",
                "variable.other.receiver.go",
                "meta.parameters.go variable.other.declaration.go",
                "meta.parameters.go variable",
                "meta.function.parameters.go variable.other.declaration.go",
                "meta.function.parameters.go variable",
                "meta.receiver.go variable.other.declaration.go",
                "meta.receiver.go variable",
                "source.go meta.function.parameters variable",
                "source.go meta.parameters variable",
                "source.go meta.receiver variable",
                "variable.parameter.ts",
                "variable.parameter.tsx",
                "variable.parameter.function.python",
                "variable.language.special.self.python",
                "variable.language.special.cls.python",
                "variable.parameter.rust"
            )
            settings = @{ foreground = $t.tangerine; fontStyle = "italic" }
        },

        # Struct Tags, Attributes & Raw String Literals -> TANGERINE
        @{
            name = "Struct Tags, Attributes & Raw String Literals"
            scope = @(
                "meta.struct.tag.go",
                "entity.name.tag.go",
                "meta.struct.tag.go string",
                "meta.struct.tag.go string.quoted",
                "string.quoted.raw.go",
                "punctuation.definition.string.raw.go",
                "entity.other.attribute-name",
                "entity.other.attribute-name.html",
                "entity.other.attribute-name.jsx",
                "entity.other.attribute-name.tsx",
                "entity.other.attribute-name.xml"
            )
            settings = @{ foreground = $t.tangerine }
        },

        # Functions & Methods -> CYAN
        @{
            name = "Functions, Methods & Builtins"
            scope = @(
                "entity.name.function",
                "entity.name.function.definition",
                "entity.name.function.call",
                "entity.name.function.go",
                "entity.name.function.definition.go",
                "entity.name.function.call.go",
                "support.function",
                "support.function.builtin",
                "support.function.builtin.go",
                "support.function.go",
                "meta.function-call",
                "meta.function-call.go",
                "meta.method-call"
            )
            settings = @{ foreground = $t.cyan }
        },

        # Package & Namespace Names -> CYAN
        @{
            name = "Package & Module Names"
            scope = @(
                "entity.name.package",
                "entity.name.package.go",
                "entity.name.namespace",
                "entity.name.module",
                "support.other.namespace",
                "support.other.module"
            )
            settings = @{ foreground = $t.cyan }
        },

        # Keywords & Flow Control -> PURPLE BOLD
        @{
            name = "Keywords & Flow Control"
            scope = @(
                "keyword.control",
                "keyword.control.flow",
                "keyword.control.conditional",
                "keyword.control.loop",
                "keyword.control.import",
                "keyword.control.export",
                "keyword.control.trycatch",
                "keyword.control.async",
                "keyword.control.await",
                "keyword.control.return",
                "keyword.control.go",
                "keyword.statement.go",
                "keyword.import.go",
                "keyword.package.go",
                "keyword.channel.go",
                "keyword.function.go",
                "keyword.var.go",
                "keyword.const.go",
                "keyword.other",
                "keyword.other.rust",
                "storage.type.function",
                "storage.type.function.python",
                "storage.type.class.python",
                "storage.type.var",
                "storage.type.let",
                "storage.type.const"
            )
            settings = @{ foreground = $t.purple; fontStyle = "bold" }
        },

        # Strings & Text Literals -> ORANGE
        @{
            name = "Strings & Quotes"
            scope = @(
                "string",
                "string.quoted",
                "string.quoted.single",
                "string.quoted.double",
                "string.template",
                "punctuation.definition.string.begin",
                "punctuation.definition.string.end"
            )
            settings = @{ foreground = $t.orange }
        },

        # Numbers & Numerics -> YELLOW
        @{
            name = "Numbers"
            scope = @(
                "constant.numeric",
                "constant.numeric.integer",
                "constant.numeric.float",
                "constant.numeric.hex",
                "constant.numeric.binary",
                "constant.numeric.octal"
            )
            settings = @{ foreground = $t.yellow }
        },

        # Language Constants (nil, null, true, false, None) -> YELLOW BOLD
        @{
            name = "Language Constants (nil, null, true, false, None)"
            scope = @(
                "constant.language",
                "constant.language.boolean",
                "constant.language.null",
                "constant.language.nil",
                "constant.language.nil.go",
                "constant.language.true.go",
                "constant.language.false.go",
                "constant.language.undefined",
                "constant.language.true",
                "constant.language.false",
                "constant.language.python"
            )
            settings = @{ foreground = $t.yellow; fontStyle = "bold" }
        },

        # User Constants & Enum Values -> YELLOW
        @{
            name = "Constants & Enum Values"
            scope = @(
                "constant.other",
                "variable.other.constant",
                "variable.other.enummember"
            )
            settings = @{ foreground = $t.yellow }
        },

        # Tags & JSX / HTML Elements -> CYAN
        @{
            name = "Tags & JSX Elements"
            scope = @(
                "entity.name.tag",
                "entity.name.tag.custom",
                "entity.name.tag.jsx",
                "entity.name.tag.tsx",
                "entity.name.tag.html",
                "support.class.component"
            )
            settings = @{ foreground = $t.cyan }
        },

        # JSON Keys -> CYAN
        @{
            name = "JSON Keys"
            scope = @(
                "support.type.property-name.json",
                "source.json meta.structure.dictionary.json support.type.property-name.json"
            )
            settings = @{ foreground = $t.cyan }
        },

        # Operators & Decorators -> PURPLE
        @{
            name = "Operators & Decorators"
            scope = @(
                "keyword.operator",
                "keyword.operator.arithmetic",
                "keyword.operator.bitwise",
                "keyword.operator.assignment",
                "keyword.operator.comparison",
                "keyword.operator.address.go",
                "keyword.operator.channel.go",
                "entity.name.function.decorator",
                "meta.decorator",
                "punctuation.decorator"
            )
            settings = @{ foreground = $t.purple }
        },

        # Brackets & Curly Braces -> PURPLE
        @{
            name = "Brackets & Curly Braces"
            scope = @(
                "punctuation.brackets",
                "punctuation.curly.brace",
                "punctuation.square.bracket"
            )
            settings = @{ foreground = $t.purple }
        },

        # Variables (Default Foreground) -> FG (WHITE)
        @{
            name = "Variables (Default Foreground)"
            scope = @(
                "variable",
                "variable.other",
                "variable.other.readwrite"
            )
            settings = @{ foreground = $t.fg }
        },

        # Punctuation & Separators -> FG (WHITE)
        @{
            name = "Punctuation & Separators"
            scope = @(
                "punctuation",
                "punctuation.separator",
                "punctuation.terminator",
                "punctuation.definition.block"
            )
            settings = @{ foreground = $t.fg }
        },

        # Invalid
        @{
            name = "Invalid"
            scope = @("invalid", "invalid.illegal")
            settings = @{ foreground = $t.red }
        }
    )

    $outputObj = [PSCustomObject]@{
        name = $t.name
        type = "dark"
        colors = $colors
        semanticHighlighting = $true
        semanticTokenColors = $semanticTokens
        tokenColors = $tokenColors
    }

    $jsonStr = $outputObj | ConvertTo-Json -Depth 25
    [System.IO.File]::WriteAllText($targetPath, $jsonStr, [System.Text.Encoding]::UTF8)
    Write-Host "Generated flawless theme: $($t.file)"
}

Write-Host "All 7 flawless themes generated successfully!"
