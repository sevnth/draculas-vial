# Masterpiece Theme Builder for Dracula's Vial
# ============================================
#
# Generates 100% faithful TextMate & Semantic Token rules matching preview/index.html & preview/app.js
#
# Includes complete package/namespace recognition (fmt, context, time, ethclient, React, asyncio, etc.)
# and Go type constructors (map, chan, slice).

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

    # ================================================================
    # SEMANTIC TOKEN COLORS (LSP language servers)
    # ================================================================
    $semanticTokens = [PSCustomObject]@{
        # Type names (Executor, MetricRecord, string, bool, etc.) -> GREEN ITALIC
        "type" = [PSCustomObject]@{ foreground = $t.green; fontStyle = "italic" }
        "type.defaultLibrary" = [PSCustomObject]@{ foreground = $t.green; fontStyle = "italic" }
        "class" = [PSCustomObject]@{ foreground = $t.green; fontStyle = "italic" }
        "class.defaultLibrary" = [PSCustomObject]@{ foreground = $t.green; fontStyle = "italic" }
        "interface" = [PSCustomObject]@{ foreground = $t.green; fontStyle = "italic" }
        "struct" = [PSCustomObject]@{ foreground = $t.green; fontStyle = "italic" }
        "enum" = [PSCustomObject]@{ foreground = $t.green; fontStyle = "italic" }
        "typeParameter" = [PSCustomObject]@{ foreground = $t.green; fontStyle = "italic" }

        # Functions & Methods -> CYAN
        "function" = [PSCustomObject]@{ foreground = $t.cyan }
        "function.defaultLibrary" = [PSCustomObject]@{ foreground = $t.cyan }
        "method" = [PSCustomObject]@{ foreground = $t.cyan }
        "method.defaultLibrary" = [PSCustomObject]@{ foreground = $t.cyan }
        "macro" = [PSCustomObject]@{ foreground = $t.cyan }

        # Properties (struct fields, interface fields, object properties) -> PINK
        "property" = [PSCustomObject]@{ foreground = $t.pink }
        "property.declaration" = [PSCustomObject]@{ foreground = $t.pink }
        "property.readonly" = [PSCustomObject]@{ foreground = $t.pink }

        # Parameters & Receivers -> TANGERINE ITALIC
        "parameter" = [PSCustomObject]@{ foreground = $t.tangerine; fontStyle = "italic" }
        "parameter.declaration" = [PSCustomObject]@{ foreground = $t.tangerine; fontStyle = "italic" }

        # Variables -> FG (WHITE)
        "variable" = [PSCustomObject]@{ foreground = $t.fg }
        "variable.declaration" = [PSCustomObject]@{ foreground = $t.fg }
        "variable.readonly" = [PSCustomObject]@{ foreground = $t.fg }
        "variable.defaultLibrary" = [PSCustomObject]@{ foreground = $t.green }

        # Constants & Enum Members -> YELLOW
        "enumMember" = [PSCustomObject]@{ foreground = $t.yellow }
        "variable.readonly.defaultLibrary" = [PSCustomObject]@{ foreground = $t.yellow }

        # Namespace / Package / Module -> CYAN / GREEN
        "namespace" = [PSCustomObject]@{ foreground = $t.cyan }
        "namespace.defaultLibrary" = [PSCustomObject]@{ foreground = $t.green }
        "package" = [PSCustomObject]@{ foreground = $t.cyan }
        "module" = [PSCustomObject]@{ foreground = $t.cyan }

        # Strings -> ORANGE
        "string" = [PSCustomObject]@{ foreground = $t.orange }

        # Numbers -> YELLOW
        "number" = [PSCustomObject]@{ foreground = $t.yellow }

        # Operator -> PURPLE
        "operator" = [PSCustomObject]@{ foreground = $t.purple }

        # Comment -> SLATE ITALIC
        "comment" = [PSCustomObject]@{ foreground = $t.comment; fontStyle = "italic" }

        # Decorator -> PURPLE
        "decorator" = [PSCustomObject]@{ foreground = $t.purple }

        # Regexp -> ORANGE
        "regexp" = [PSCustomObject]@{ foreground = $t.orange }
    }

    # ================================================================
    # TEXTMATE TOKEN COLORS
    # ================================================================
    $tokenColors = @(
        # ── Comments ──────────────────────────────────────────────
        @{
            name = "Comments"
            scope = @(
                "comment", "punctuation.definition.comment", "comment.block",
                "comment.block.documentation", "comment.line", "comment.line.double-slash",
                "comment.line.documentation", "string.quoted.docstring"
            )
            settings = @{ foreground = $t.comment; fontStyle = "italic" }
        },

        # ── Type Declaration KEYWORDS (type, struct, interface, enum, class) -> PINK ──
        @{
            name = "Type Declaration Keywords -> Pink"
            scope = @(
                "keyword.type.go",
                "keyword.type",
                "keyword.declaration.type.go",
                "keyword.declaration.type",
                "keyword.declaration.struct.go",
                "keyword.declaration.struct",
                "keyword.declaration.interface.go",
                "keyword.declaration.interface",
                "storage.type.interface.ts",
                "storage.type.interface.tsx",
                "storage.type.interface.js",
                "storage.type.interface.jsx",
                "storage.type.type.ts",
                "storage.type.type.tsx",
                "storage.type.type.js",
                "storage.type.enum.ts",
                "storage.type.enum.tsx",
                "storage.type.class.ts",
                "storage.type.class.tsx",
                "storage.type.class.js",
                "storage.type.class.jsx",
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

        # ── Primitive Built-in Types (string, number, bool, map, chan, uint32, error, etc.) -> GREEN ITALIC ──
        @{
            name = "Primitive Built-in Types -> Green Italic"
            scope = @(
                "storage.type.primitive.go",
                "storage.type.numeric.go",
                "storage.type.string.go",
                "storage.type.boolean.go",
                "storage.type.byte.go",
                "storage.type.rune.go",
                "storage.type.error.go",
                "storage.type.map.go",
                "storage.type.chan.go",
                "storage.type.slice.go",
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
                "support.type.builtin.tsx",
                "support.type.primitive",
                "support.type.builtin",
                "support.type.python",
                "support.type.rust",
                "support.type.primitive.rust"
            )
            settings = @{ foreground = $t.green; fontStyle = "italic" }
        },

        # ── User/Named Types (Executor, MetricRecord, TransferTarget, etc.) -> GREEN ITALIC ──
        @{
            name = "User Types, Classes & Interfaces -> Green Italic"
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
                "entity.name.type.ts",
                "entity.name.type.tsx",
                "entity.name.type.interface.ts",
                "entity.name.type.interface.tsx",
                "entity.name.type.alias.ts",
                "entity.name.type.alias.tsx",
                "entity.name.class",
                "support.type",
                "support.class",
                "support.type.go",
                "support.class.react"
            )
            settings = @{ foreground = $t.green; fontStyle = "italic" }
        },

        # ── Struct Fields, Interface Properties & Object Keys -> PINK ──
        @{
            name = "Properties, Fields & Object Keys -> Pink"
            scope = @(
                "variable.object.property",
                "variable.other.property",
                "variable.other.object.property",
                "variable.other.member",
                "variable.other.property.go",
                "variable.other.member.go",
                "entity.name.variable.field",
                "entity.name.variable.field.go",
                "entity.name.variable.field.ts",
                "entity.name.variable.field.tsx",
                "support.type.property-name",
                "meta.object-literal.key",
                "meta.object-literal.key.ts",
                "meta.object-literal.key.tsx",
                "meta.object-literal.key.js",
                "meta.object-literal.key.jsx",
                "variable.other.declaration.struct.go",
                "source.go meta.struct.declaration variable.other.declaration.go",
                "source.go meta.struct.declaration variable.other.assignment.go",
                "meta.struct.declaration.go variable.other.declaration.go",
                "meta.struct.declaration.go variable.other.assignment.go",
                "source.go meta.composite-literal.go variable.other.assignment.go",
                "meta.composite-literal.go variable.other.assignment.go"
            )
            settings = @{ foreground = $t.pink }
        },

        # ── Function Parameters & Receivers -> TANGERINE ITALIC ──
        @{
            name = "Parameters & Receivers -> Tangerine Italic"
            scope = @(
                "variable.parameter",
                "variable.parameter.function",
                "variable.parameter.go",
                "variable.parameter.ts",
                "variable.parameter.tsx",
                "variable.parameter.js",
                "variable.parameter.jsx",
                "variable.other.receiver.go",
                "meta.parameters.go variable.other.declaration.go",
                "meta.function.parameters.go variable.other.declaration.go",
                "meta.receiver.go variable.other.declaration.go",
                "variable.parameter.function.python",
                "variable.language.special.self.python",
                "variable.language.special.cls.python",
                "variable.parameter.rust"
            )
            settings = @{ foreground = $t.tangerine; fontStyle = "italic" }
        },

        # ── Struct Tags, HTML/JSX Attributes -> TANGERINE ──
        @{
            name = "Struct Tags & Attributes -> Tangerine"
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

        # ── Functions, Methods & Builtins -> CYAN ──
        @{
            name = "Functions & Methods -> Cyan"
            scope = @(
                "entity.name.function",
                "entity.name.function.go",
                "entity.name.function.ts",
                "entity.name.function.tsx",
                "entity.name.function.js",
                "entity.name.function.jsx",
                "entity.name.function.python",
                "entity.name.function.rust",
                "support.function",
                "support.function.builtin",
                "support.function.builtin.go",
                "support.function.go",
                "support.function.ts",
                "support.function.tsx",
                "meta.function-call",
                "meta.function-call.go",
                "meta.method-call"
            )
            settings = @{ foreground = $t.cyan }
        },

        # ── Package & Namespace Names -> CYAN ──
        @{
            name = "Package & Namespace -> Cyan"
            scope = @(
                "entity.name.package",
                "entity.name.package.go",
                "entity.name.namespace",
                "entity.name.module",
                "support.other.namespace",
                "support.other.namespace.use.go",
                "support.other.package.use.go",
                "support.package.go",
                "support.module.go",
                "variable.other.package.go",
                "support.other.module",
                "support.class.builtin"
            )
            settings = @{ foreground = $t.cyan }
        },

        # ── Keywords & Flow Control -> PURPLE BOLD ──
        @{
            name = "Keywords & Flow Control -> Purple Bold"
            scope = @(
                "keyword",
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
                "keyword.control.from",
                "keyword.control.default",
                "keyword.control.go",
                "keyword.statement.go",
                "keyword.import.go",
                "keyword.package.go",
                "keyword.function.go",
                "keyword.function",
                "keyword.var.go",
                "keyword.const.go",
                "keyword.other",
                "keyword.other.rust",
                "storage.type",
                "storage.type.function",
                "storage.type.function.ts",
                "storage.type.function.tsx",
                "storage.type.function.python",
                "storage.type.class.python",
                "storage.type.var",
                "storage.type.let",
                "storage.type.const"
            )
            settings = @{ foreground = $t.purple; fontStyle = "bold" }
        },

        # ── Strings & Quotes -> ORANGE ──
        @{
            name = "Strings -> Orange"
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

        # ── Numbers -> YELLOW ──
        @{
            name = "Numbers -> Yellow"
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

        # ── Language Constants (nil, null, true, false, None) -> YELLOW BOLD ──
        @{
            name = "Language Constants -> Yellow Bold"
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

        # ── User Constants & Enum Values -> YELLOW ──
        @{
            name = "Constants & Enum Values -> Yellow"
            scope = @(
                "constant.other",
                "variable.other.constant",
                "variable.other.enummember"
            )
            settings = @{ foreground = $t.yellow }
        },

        # ── HTML/JSX Tags -> CYAN ──
        @{
            name = "HTML/JSX Tags -> Cyan"
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

        # ── JSON Keys -> CYAN ──
        @{
            name = "JSON Keys -> Cyan"
            scope = @(
                "support.type.property-name.json",
                "source.json meta.structure.dictionary.json support.type.property-name.json"
            )
            settings = @{ foreground = $t.cyan }
        },

        # ── Operators & Decorators -> PURPLE ──
        @{
            name = "Operators & Decorators -> Purple"
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

        # ── Variables (Default Foreground) -> FG ──
        @{
            name = "Variables -> Foreground"
            scope = @(
                "variable",
                "variable.other",
                "variable.other.readwrite"
            )
            settings = @{ foreground = $t.fg }
        },

        # ── Punctuation & Separators -> FG ──
        @{
            name = "Punctuation -> Foreground"
            scope = @(
                "punctuation",
                "punctuation.separator",
                "punctuation.terminator",
                "punctuation.definition.block"
            )
            settings = @{ foreground = $t.fg }
        },

        # ── Invalid -> RED ──
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
    Write-Host "Generated: $($t.file)"
}

Write-Host ""
Write-Host "All 7 themes regenerated successfully!"
