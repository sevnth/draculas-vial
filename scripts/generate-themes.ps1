# PowerShell script to generate 25 new Cyan/Purple-anchored themes + update package.json, app.js and index.html

$themeDefinitions = @(
    @{
        id = "dracula-deep-abyss"
        label = "Dracula Deep Abyss (Oceanic Bioluminescence)"
        bg = "#0e1017"; bgDarker = "#080a0f"; fg = "#f0f4f8"; selection = "#1e2638"; comment = "#4d5b75"
        purple = "#9b5de5"; cyan = "#00f0ff"; orange = "#ff577f"; green = "#00f5d4"; yellow = "#fee440"
        pink = "#f15bb5"; tangerine = "#ff758f"; red = "#ff3366"
    },
    @{
        id = "dracula-cyber-lavender"
        label = "Dracula Cyber Lavender (Pastel Cyber)"
        bg = "#151622"; bgDarker = "#0f101a"; fg = "#f8f7fc"; selection = "#282a3d"; comment = "#6b6f8a"
        purple = "#d8b4fe"; cyan = "#67e8f9"; orange = "#fda4af"; green = "#86efac"; yellow = "#fef08a"
        pink = "#e9d5ff"; tangerine = "#fbcfe8"; red = "#f87171"
    },
    @{
        id = "dracula-neon-vapor"
        label = "Dracula Neon Vapor (Vaporwave High-Contrast)"
        bg = "#141226"; bgDarker = "#0d0b1a"; fg = "#ffffff"; selection = "#2d2552"; comment = "#6c6694"
        purple = "#e040fb"; cyan = "#00ffff"; orange = "#ff9100"; green = "#76ff03"; yellow = "#ffff00"
        pink = "#ff4081"; tangerine = "#ff6e40"; red = "#ff1744"
    },
    @{
        id = "dracula-tokyo-nightfall"
        label = "Dracula Tokyo Nightfall (Storm Triad)"
        bg = "#1a1b26"; bgDarker = "#13141f"; fg = "#c0caf5"; selection = "#2e3456"; comment = "#565f89"
        purple = "#bb9af7"; cyan = "#7dcfff"; orange = "#ff9e64"; green = "#9ece6a"; yellow = "#e0af68"
        pink = "#f7768e"; tangerine = "#ff9e64"; red = "#f7768e"
    },
    @{
        id = "dracula-quantum-violet"
        label = "Dracula Quantum Violet (Laser Violet & Cyan)"
        bg = "#161320"; bgDarker = "#0f0d17"; fg = "#f4effa"; selection = "#2e2544"; comment = "#6e6382"
        purple = "#b388ff"; cyan = "#18ffff"; orange = "#ff6e40"; green = "#69f0ae"; yellow = "#ffd740"
        pink = "#ff4081"; tangerine = "#ff9e80"; red = "#ff5252"
    },
    @{
        id = "dracula-hyper-cyan"
        label = "Dracula Hyper Cyan (Electric Cyan Anchor)"
        bg = "#0f171c"; bgDarker = "#091014"; fg = "#e8f7fa"; selection = "#1a323d"; comment = "#4d6b75"
        purple = "#b388ff"; cyan = "#00e5ff"; orange = "#ff9100"; green = "#00e676"; yellow = "#ffd600"
        pink = "#ff1744"; tangerine = "#ff6d00"; red = "#ff1744"
    },
    @{
        id = "dracula-bioluminescent"
        label = "Dracula Bioluminescent (Deep Sea Cyan & Purple)"
        bg = "#0a1128"; bgDarker = "#050917"; fg = "#e1f5fe"; selection = "#172b54"; comment = "#435d87"
        purple = "#7b2cbf"; cyan = "#00f5d4"; orange = "#ef476f"; green = "#52b788"; yellow = "#ffd166"
        pink = "#9d4edd"; tangerine = "#f77f00"; red = "#d62828"
    },
    @{
        id = "dracula-midnight-velvet"
        label = "Dracula Midnight Velvet (Royal Amethyst & Cyan)"
        bg = "#12111a"; bgDarker = "#0a0910"; fg = "#f3f0fa"; selection = "#28233a"; comment = "#665f7a"
        purple = "#c77dff"; cyan = "#48cae4"; orange = "#ffaa00"; green = "#80ffdb"; yellow = "#ffd166"
        pink = "#ff0054"; tangerine = "#ff7b00"; red = "#f72585"
    },
    @{
        id = "dracula-electric-nebula"
        label = "Dracula Electric Nebula (Cosmic Stellar)"
        bg = "#13131f"; bgDarker = "#0c0c14"; fg = "#f8fafc"; selection = "#26263d"; comment = "#646687"
        purple = "#a855f7"; cyan = "#38bdf8"; orange = "#fb923c"; green = "#4ade80"; yellow = "#facc15"
        pink = "#f43f5e"; tangerine = "#f97316"; red = "#ef4444"
    },
    @{
        id = "dracula-acid-cyber"
        label = "Dracula Acid Cyber (UV Glow & Toxic Cyan)"
        bg = "#12161a"; bgDarker = "#0b0f12"; fg = "#f0fffa"; selection = "#1e2e38"; comment = "#4f6973"
        purple = "#9945ff"; cyan = "#00f2fe"; orange = "#ff6a00"; green = "#a8ff78"; yellow = "#ffe600"
        pink = "#ff007f"; tangerine = "#ff8008"; red = "#ff0844"
    },
    @{
        id = "dracula-galactic-plasma"
        label = "Dracula Galactic Plasma (Plasma Violet & Solar)"
        bg = "#111222"; bgDarker = "#0a0b16"; fg = "#f5f3ff"; selection = "#232647"; comment = "#5e638c"
        purple = "#c084fc"; cyan = "#22d3ee"; orange = "#f472b6"; green = "#34d399"; yellow = "#fbbf24"
        pink = "#e879f9"; tangerine = "#fb923c"; red = "#f87171"
    },
    @{
        id = "dracula-pastel-mist"
        label = "Dracula Pastel Mist (Ethereal Lilac & Powder Cyan)"
        bg = "#191a24"; bgDarker = "#12131b"; fg = "#fdfbf7"; selection = "#2c2e3f"; comment = "#6e7187"
        purple = "#c4b5fd"; cyan = "#a5f3fc"; orange = "#fbcfe8"; green = "#bbf7d0"; yellow = "#fef3c7"
        pink = "#ddd6fe"; tangerine = "#fed7aa"; red = "#fca5a5"
    },
    @{
        id = "dracula-obsidian-glow"
        label = "Dracula Obsidian Glow (Pitch Obsidian & Neon Saturation)"
        bg = "#0c0d14"; bgDarker = "#06070a"; fg = "#ffffff"; selection = "#222538"; comment = "#555b7a"
        purple = "#be4bdb"; cyan = "#22b8cf"; orange = "#fd7e14"; green = "#20c997"; yellow = "#ffd43b"
        pink = "#f783ac"; tangerine = "#ff922b"; red = "#ff6b6b"
    },
    @{
        id = "dracula-spectral-prism"
        label = "Dracula Spectral Prism (Full Dispersion Spectrum)"
        bg = "#171926"; bgDarker = "#0f111c"; fg = "#f1f5f9"; selection = "#2a3047"; comment = "#5f6c8c"
        purple = "#9d4edd"; cyan = "#00b4d8"; orange = "#f72585"; green = "#06d6a0"; yellow = "#ffb703"
        pink = "#7209b7"; tangerine = "#fb8500"; red = "#e63946"
    },
    @{
        id = "dracula-retrowave-80s"
        label = "Dracula Retrowave 80s (Miami Neon & Sunset Purple)"
        bg = "#171520"; bgDarker = "#100e17"; fg = "#ffffff"; selection = "#322745"; comment = "#6f6187"
        purple = "#bd00ff"; cyan = "#00f6ff"; orange = "#ff8500"; green = "#00ff66"; yellow = "#ffe600"
        pink = "#ff007f"; tangerine = "#ff5500"; red = "#ff0055"
    },
    @{
        id = "dracula-matrix-cyan"
        label = "Dracula Matrix Cyber (Ultraviolet & Terminal Cyan)"
        bg = "#0c1417"; bgDarker = "#070c0e"; fg = "#d8fced"; selection = "#153038"; comment = "#3d636b"
        purple = "#cc00ff"; cyan = "#00ffcc"; orange = "#ffaa00"; green = "#00ff66"; yellow = "#ffea00"
        pink = "#ff0066"; tangerine = "#ff7700"; red = "#ff0033"
    },
    @{
        id = "dracula-synth-royale"
        label = "Dracula Synth Royale (Imperial Purple & Diamond Cyan)"
        bg = "#121324"; bgDarker = "#0b0b17"; fg = "#f8fafc"; selection = "#24284d"; comment = "#585f8f"
        purple = "#9333ea"; cyan = "#06b6d4"; orange = "#f97316"; green = "#10b981"; yellow = "#eab308"
        pink = "#e11d48"; tangerine = "#ea580c"; red = "#dc2626"
    },
    @{
        id = "dracula-ice-fire"
        label = "Dracula Ice & Fire (Glacial Cyan & Purple Flame)"
        bg = "#0f141d"; bgDarker = "#080c12"; fg = "#f0f8ff"; selection = "#1b2c40"; comment = "#4d6b8a"
        purple = "#9254de"; cyan = "#00d2ff"; orange = "#ff7a45"; green = "#36cfc9"; yellow = "#ffc53d"
        pink = "#f759ab"; tangerine = "#ffa940"; red = "#ff4d4f"
    },
    @{
        id = "dracula-astral-twilight"
        label = "Dracula Astral Twilight (Starlight Cyan & Cosmic Purple)"
        bg = "#161626"; bgDarker = "#0e0e1a"; fg = "#f1f5f9"; selection = "#2a2a47"; comment = "#606087"
        purple = "#8b5cf6"; cyan = "#0ea5e9"; orange = "#fb7185"; green = "#10b981"; yellow = "#f59e0b"
        pink = "#c084fc"; tangerine = "#f97316"; red = "#f43f5e"
    },
    @{
        id = "dracula-emerald-dracula"
        label = "Dracula Emerald Triad (Jade Mint • Cyan • Purple)"
        bg = "#111817"; bgDarker = "#0a100f"; fg = "#ecfdf5"; selection = "#1a3632"; comment = "#486e66"
        purple = "#c084fc"; cyan = "#00e5ff"; orange = "#fb923c"; green = "#10b981"; yellow = "#facc15"
        pink = "#f43f5e"; tangerine = "#34d399"; red = "#ef4444"
    },
    @{
        id = "dracula-magenta-dusk"
        label = "Dracula Magenta Dusk (Radiant Magenta-Purple & Ice Cyan)"
        bg = "#181324"; bgDarker = "#100b1a"; fg = "#faf5ff"; selection = "#36244f"; comment = "#735c8c"
        purple = "#d946ef"; cyan = "#06b6d4"; orange = "#fb923c"; green = "#34d399"; yellow = "#fde047"
        pink = "#ec4899"; tangerine = "#f472b6"; red = "#e11d48"
    },
    @{
        id = "dracula-lapis-lazuli"
        label = "Dracula Lapis Lazuli (Deep Blue Lapis & Persian Amethyst)"
        bg = "#0e1524"; bgDarker = "#080d17"; fg = "#f0f7ff"; selection = "#1a2c4d"; comment = "#486287"
        purple = "#a855f7"; cyan = "#38bdf8"; orange = "#fb923c"; green = "#2dd4bf"; yellow = "#f59e0b"
        pink = "#f43f5e"; tangerine = "#fbbf24"; red = "#ef4444"
    },
    @{
        id = "dracula-cyber-sakura"
        label = "Dracula Cyber Sakura (Blossom Violet & Neon Cyan)"
        bg = "#16131c"; bgDarker = "#0e0b13"; fg = "#fdf2f8"; selection = "#30223b"; comment = "#6e587a"
        purple = "#c084fc"; cyan = "#22d3ee"; orange = "#fb7185"; green = "#4ade80"; yellow = "#fb923c"
        pink = "#f472b6"; tangerine = "#f9a8d4"; red = "#e11d48"
    },
    @{
        id = "dracula-nordic-frost"
        label = "Dracula Nordic Frost (Subtle Arctic Cyan & Polar Purple)"
        bg = "#1a1e29"; bgDarker = "#12151e"; fg = "#eceff4"; selection = "#2e374d"; comment = "#616e87"
        purple = "#b48ead"; cyan = "#88c0d0"; orange = "#d08770"; green = "#a3be8c"; yellow = "#ebcb8b"
        pink = "#bf616a"; tangerine = "#81a1c1"; red = "#bf616a"
    },
    @{
        id = "dracula-super-vibrant-spectrum"
        label = "Dracula Super Vibrant Spectrum (Maximum Chromatic Glow)"
        bg = "#11121b"; bgDarker = "#090a10"; fg = "#ffffff"; selection = "#282b45"; comment = "#60658f"
        purple = "#b845ff"; cyan = "#00f5ff"; orange = "#ff6d00"; green = "#00ff87"; yellow = "#ffea00"
        pink = "#ff00a0"; tangerine = "#ff3d00"; red = "#ff0055"
    }
)

function Build-ThemeJson($t) {
    $obj = [ordered]@{
        name = $t.label
        type = "dark"
        colors = [ordered]@{
            "activityBar.background" = $t.bgDarker
            "activityBar.foreground" = "#ffffff"
            "activityBar.inactiveForeground" = $t.comment
            "activityBar.activeBorder" = $t.cyan
            "activityBar.activeBackground" = "$($t.bg)"
            "activityBarBadge.background" = $t.purple
            "activityBarBadge.foreground" = "#ffffff"
            "badge.background" = $t.purple
            "badge.foreground" = "#ffffff"
            "breadcrumb.activeSelectionForeground" = $t.cyan
            "breadcrumb.focusForeground" = "#ffffff"
            "breadcrumb.foreground" = $t.comment
            "breadcrumbPicker.background" = $t.bgDarker
            "button.background" = $t.purple
            "button.foreground" = "#ffffff"
            "button.hoverBackground" = "$($t.purple)dd"
            "button.secondaryBackground" = "$($t.selection)"
            "button.secondaryForeground" = "#ffffff"
            "button.secondaryHoverBackground" = "$($t.selection)cc"
            "charts.blue" = $t.cyan
            "charts.green" = $t.green
            "charts.orange" = $t.orange
            "charts.purple" = $t.purple
            "charts.red" = $t.red
            "charts.yellow" = $t.yellow
            "commandCenter.activeBackground" = "$($t.selection)"
            "commandCenter.activeBorder" = $t.cyan
            "commandCenter.background" = $t.bgDarker
            "commandCenter.border" = "$($t.selection)88"
            "commandCenter.foreground" = "#ffffff"
            "contrastBorder" = "#00000000"
            "debugToolBar.background" = $t.bgDarker
            "diffEditor.diagonalFill" = "$($t.selection)40"
            "diffEditor.insertedLineBackground" = "$($t.green)22"
            "diffEditor.insertedTextBackground" = "$($t.green)33"
            "diffEditor.removedLineBackground" = "$($t.red)22"
            "diffEditor.removedTextBackground" = "$($t.red)33"
            "dropdown.background" = $t.bgDarker
            "dropdown.border" = "$($t.selection)"
            "dropdown.foreground" = "#ffffff"
            "editor.background" = $t.bg
            "editor.findMatchBackground" = "$($t.orange)44"
            "editor.findMatchBorder" = $t.orange
            "editor.findMatchHighlightBackground" = "$($t.cyan)33"
            "editor.findMatchHighlightBorder" = "$($t.cyan)66"
            "editor.foldingRangeBackground" = "$($t.selection)22"
            "editor.foreground" = $t.fg
            "editor.hoverHighlightBackground" = "$($t.cyan)22"
            "editor.lineHighlightBackground" = "$($t.selection)66"
            "editor.lineHighlightBorder" = "#00000000"
            "editor.rangeHighlightBackground" = "$($t.purple)15"
            "editor.selectionBackground" = "$($t.selection)cc"
            "editor.selectionHighlightBackground" = "$($t.selection)66"
            "editor.selectionHighlightBorder" = "$($t.cyan)44"
            "editor.wordHighlightBackground" = "$($t.cyan)22"
            "editor.wordHighlightBorder" = "$($t.cyan)66"
            "editor.wordHighlightStrongBackground" = "$($t.purple)22"
            "editor.wordHighlightStrongBorder" = "$($t.purple)66"
            "editorBracketHighlight.foreground1" = $t.purple
            "editorBracketHighlight.foreground2" = $t.cyan
            "editorBracketHighlight.foreground3" = $t.orange
            "editorBracketHighlight.foreground4" = $t.green
            "editorBracketHighlight.foreground5" = $t.pink
            "editorBracketHighlight.foreground6" = $t.yellow
            "editorBracketMatch.background" = "$($t.selection)55"
            "editorBracketMatch.border" = $t.cyan
            "editorCodeLens.foreground" = $t.comment
            "editorCursor.foreground" = $t.cyan
            "editorError.foreground" = $t.red
            "editorGroup.border" = $t.bgDarker
            "editorGroup.dropBackground" = "$($t.purple)22"
            "editorGroupHeader.noTabsBackground" = $t.bg
            "editorGroupHeader.tabsBackground" = $t.bgDarker
            "editorGutter.addedBackground" = $t.green
            "editorGutter.background" = $t.bg
            "editorGutter.deletedBackground" = $t.red
            "editorGutter.modifiedBackground" = $t.orange
            "editorHoverWidget.background" = $t.bgDarker
            "editorHoverWidget.border" = "$($t.selection)"
            "editorIndentGuide.activeBackground1" = "$($t.comment)aa"
            "editorIndentGuide.background1" = "$($t.selection)66"
            "editorInfo.foreground" = $t.cyan
            "editorInlayHint.background" = "$($t.selection)88"
            "editorInlayHint.foreground" = "$($t.comment)cc"
            "editorInlayHint.typeBackground" = "$($t.selection)88"
            "editorInlayHint.typeForeground" = "$($t.green)cc"
            "editorInlayHint.parameterBackground" = "$($t.selection)88"
            "editorInlayHint.parameterForeground" = "$($t.orange)cc"
            "editorLineNumber.activeForeground" = $t.cyan
            "editorLineNumber.foreground" = "$($t.comment)88"
            "editorLink.activeForeground" = $t.cyan
            "editorMarkerNavigation.background" = $t.bgDarker
            "editorOverviewRuler.addedForeground" = $t.green
            "editorOverviewRuler.border" = $t.bgDarker
            "editorOverviewRuler.bracketMatchForeground" = $t.cyan
            "editorOverviewRuler.errorForeground" = $t.red
            "editorOverviewRuler.findMatchForeground" = $t.orange
            "editorOverviewRuler.infoForeground" = $t.cyan
            "editorOverviewRuler.modifiedForeground" = $t.orange
            "editorOverviewRuler.rangeHighlightForeground" = $t.purple
            "editorOverviewRuler.selectionHighlightForeground" = $t.selection
            "editorOverviewRuler.warningForeground" = $t.orange
            "editorOverviewRuler.wordHighlightForeground" = $t.cyan
            "editorRuler.foreground" = "$($t.selection)44"
            "editorSuggestWidget.background" = $t.bgDarker
            "editorSuggestWidget.border" = "$($t.selection)"
            "editorSuggestWidget.foreground" = $t.fg
            "editorSuggestWidget.highlightForeground" = $t.cyan
            "editorSuggestWidget.selectedBackground" = $t.selection
            "editorSuggestWidget.selectedForeground" = $t.cyan
            "editorWarning.foreground" = $t.orange
            "editorWhitespace.foreground" = "$($t.selection)55"
            "editorWidget.background" = $t.bgDarker
            "editorWidget.border" = "$($t.cyan)55"
            "errorForeground" = $t.red
            "focusBorder" = $t.cyan
            "foreground" = $t.fg
            "gitDecoration.addedResourceForeground" = $t.green
            "gitDecoration.conflictingResourceForeground" = $t.orange
            "gitDecoration.deletedResourceForeground" = $t.red
            "gitDecoration.ignoredResourceForeground" = "$($t.comment)66"
            "gitDecoration.modifiedResourceForeground" = $t.orange
            "gitDecoration.stageDeletedResourceForeground" = $t.red
            "gitDecoration.stageModifiedResourceForeground" = $t.cyan
            "gitDecoration.untrackedResourceForeground" = $t.cyan
            "icon.foreground" = "#ffffff"
            "input.background" = $t.selection
            "input.border" = "$($t.selection)"
            "input.foreground" = "#ffffff"
            "input.placeholderForeground" = $t.comment
            "inputOption.activeBorder" = $t.cyan
            "inputOption.activeBackground" = "$($t.purple)33"
            "inputOption.activeForeground" = "#ffffff"
            "inputValidation.errorBackground" = "$($t.red)22"
            "inputValidation.errorBorder" = $t.red
            "inputValidation.infoBackground" = "$($t.cyan)22"
            "inputValidation.infoBorder" = $t.cyan
            "inputValidation.warningBackground" = "$($t.orange)22"
            "inputValidation.warningBorder" = $t.orange
            "list.activeSelectionBackground" = $t.selection
            "list.activeSelectionForeground" = $t.cyan
            "list.activeSelectionIconForeground" = $t.cyan
            "list.dropBackground" = "$($t.purple)22"
            "list.focusBackground" = "$($t.selection)88"
            "list.focusForeground" = "#ffffff"
            "list.focusHighlightForeground" = $t.cyan
            "list.highlightForeground" = $t.cyan
            "list.hoverBackground" = "$($t.selection)55"
            "list.hoverForeground" = "#ffffff"
            "list.inactiveSelectionBackground" = "$($t.selection)55"
            "list.inactiveSelectionForeground" = "#ffffff"
            "listFilterWidget.background" = $t.bgDarker
            "listFilterWidget.noMatchesOutline" = $t.red
            "listFilterWidget.outline" = $t.cyan
            "menu.background" = $t.bgDarker
            "menu.border" = "$($t.selection)"
            "menu.foreground" = "#ffffff"
            "menu.selectionBackground" = $t.selection
            "menu.selectionForeground" = $t.cyan
            "menu.separatorBackground" = "$($t.selection)"
            "menubar.selectionBackground" = $t.selection
            "menubar.selectionForeground" = $t.cyan
            "minimap.errorHighlight" = $t.red
            "minimap.findMatchHighlight" = $t.orange
            "minimap.selectionHighlight" = $t.selection
            "minimap.warningHighlight" = $t.orange
            "minimapGutter.addedBackground" = $t.green
            "minimapGutter.deletedBackground" = $t.red
            "minimapGutter.modifiedBackground" = $t.orange
            "minimapSlider.activeBackground" = "$($t.cyan)44"
            "minimapSlider.background" = "$($t.selection)33"
            "minimapSlider.hoverBackground" = "$($t.cyan)22"
            "notificationCenterHeader.background" = $t.bgDarker
            "notificationCenterHeader.foreground" = "#ffffff"
            "notifications.background" = $t.bgDarker
            "notifications.border" = "$($t.cyan)55"
            "notifications.foreground" = "#ffffff"
            "notificationLink.foreground" = $t.cyan
            "notificationsErrorIcon.foreground" = $t.red
            "notificationsInfoIcon.foreground" = $t.cyan
            "notificationsWarningIcon.foreground" = $t.orange
            "panel.background" = $t.bgDarker
            "panel.border" = "$($t.selection)55"
            "panelTitle.activeBorder" = $t.cyan
            "panelTitle.activeForeground" = "#ffffff"
            "panelTitle.inactiveForeground" = $t.comment
            "peekView.border" = $t.cyan
            "peekViewEditor.background" = $t.bg
            "peekViewEditor.matchHighlightBackground" = "$($t.orange)44"
            "peekViewEditorGutter.background" = $t.bg
            "peekViewResult.background" = $t.bgDarker
            "peekViewResult.fileForeground" = "#ffffff"
            "peekViewResult.lineForeground" = $t.comment
            "peekViewResult.matchHighlightBackground" = "$($t.orange)44"
            "peekViewResult.selectionBackground" = $t.selection
            "peekViewResult.selectionForeground" = $t.cyan
            "peekViewTitle.background" = $t.bgDarker
            "peekViewTitleDescription.foreground" = $t.comment
            "peekViewTitleInfo.foreground" = $t.purple
            "pickerGroup.border" = "$($t.cyan)55"
            "pickerGroup.foreground" = $t.cyan
            "progressBar.background" = $t.purple
            "quickInput.background" = $t.bgDarker
            "quickInput.foreground" = "#ffffff"
            "quickInputList.focusBackground" = $t.selection
            "quickInputTitle.background" = $t.bgDarker
            "scrollbar.shadow" = "#00000044"
            "scrollbarSlider.activeBackground" = "$($t.cyan)55"
            "scrollbarSlider.background" = "$($t.selection)44"
            "scrollbarSlider.hoverBackground" = "$($t.cyan)33"
            "selection.background" = "$($t.purple)44"
            "sideBar.background" = $t.bgDarker
            "sideBar.border" = "#00000000"
            "sideBar.dropBackground" = "$($t.purple)22"
            "sideBar.foreground" = "#ffffff"
            "sideBarSectionHeader.background" = $t.bgDarker
            "sideBarSectionHeader.border" = "#00000000"
            "sideBarSectionHeader.foreground" = "#ffffff"
            "sideBarTitle.foreground" = $t.cyan
            "statusBar.background" = $t.bgDarker
            "statusBar.border" = "#00000000"
            "statusBar.debuggingBackground" = $t.purple
            "statusBar.debuggingForeground" = "#ffffff"
            "statusBar.foreground" = $t.comment
            "statusBar.noFolderBackground" = $t.bgDarker
            "statusBar.noFolderForeground" = $t.comment
            "statusBarItem.activeBackground" = $t.selection
            "statusBarItem.hoverBackground" = "$($t.selection)88"
            "statusBarItem.prominentBackground" = $t.selection
            "statusBarItem.prominentForeground" = $t.cyan
            "statusBarItem.prominentHoverBackground" = "$($t.selection)cc"
            "statusBarItem.remoteBackground" = $t.purple
            "statusBarItem.remoteForeground" = "#ffffff"
            "tab.activeBackground" = $t.bg
            "tab.activeBorder" = $t.purple
            "tab.activeBorderTop" = $t.cyan
            "tab.activeForeground" = "#ffffff"
            "tab.border" = $t.bgDarker
            "tab.hoverBackground" = "$($t.selection)88"
            "tab.inactiveBackground" = $t.bgDarker
            "tab.inactiveForeground" = $t.comment
            "tab.unfocusedActiveBackground" = $t.bg
            "tab.unfocusedActiveBorder" = "$($t.purple)66"
            "tab.unfocusedActiveBorderTop" = "$($t.cyan)66"
            "tab.unfocusedActiveForeground" = "$($t.fg)99"
            "tab.unfocusedInactiveForeground" = "$($t.comment)66"
            "terminal.ansiBlack" = $t.bg
            "terminal.ansiBlue" = $t.purple
            "terminal.ansiBrightBlack" = $t.comment
            "terminal.ansiBrightBlue" = $t.purple
            "terminal.ansiBrightCyan" = $t.cyan
            "terminal.ansiBrightGreen" = $t.green
            "terminal.ansiBrightMagenta" = $t.pink
            "terminal.ansiBrightRed" = $t.red
            "terminal.ansiBrightWhite" = "#ffffff"
            "terminal.ansiBrightYellow" = $t.yellow
            "terminal.ansiCyan" = $t.cyan
            "terminal.ansiGreen" = $t.green
            "terminal.ansiMagenta" = $t.purple
            "terminal.ansiRed" = $t.red
            "terminal.ansiWhite" = "#ffffff"
            "terminal.ansiYellow" = $t.yellow
            "terminal.background" = $t.bgDarker
            "terminal.foreground" = "#ffffff"
            "terminal.selectionBackground" = "$($t.selection)99"
            "terminalCursor.background" = $t.bgDarker
            "terminalCursor.foreground" = $t.cyan
            "textBlockQuote.background" = $t.bgDarker
            "textBlockQuote.border" = $t.purple
            "textCodeBlock.background" = $t.bgDarker
            "textLink.activeForeground" = $t.cyan
            "textLink.foreground" = $t.cyan
            "textPreformat.foreground" = $t.orange
            "textSeparator.foreground" = "$($t.selection)"
            "titleBar.activeBackground" = $t.bgDarker
            "titleBar.activeForeground" = "#ffffff"
            "titleBar.inactiveBackground" = $t.bgDarker
            "titleBar.inactiveForeground" = $t.comment
            "toolbar.activeBackground" = $t.selection
            "toolbar.hoverBackground" = "$($t.selection)88"
            "tree.indentGuidesStroke" = "$($t.selection)55"
            "widget.shadow" = "#00000055"
        }
        semanticHighlighting = $true
        semanticTokenColors = [ordered]@{
            "enumMember" = @{ foreground = $t.yellow }
            "variable.constant" = @{ foreground = $t.yellow }
            "variable.defaultLibrary" = @{ foreground = $t.cyan }
            "property.readonly" = @{ foreground = $t.pink }
            "parameter" = @{ foreground = $t.tangerine; fontStyle = "italic" }
            "type" = @{ foreground = $t.green }
            "class" = @{ foreground = $t.green }
            "interface" = @{ foreground = $t.green; fontStyle = "italic" }
            "struct" = @{ foreground = $t.green }
            "function" = @{ foreground = $t.cyan }
            "method" = @{ foreground = $t.cyan }
            "macro" = @{ foreground = $t.purple }
            "keyword" = @{ foreground = $t.purple }
            "comment" = @{ foreground = $t.comment; fontStyle = "italic" }
            "string" = @{ foreground = $t.orange }
            "number" = @{ foreground = $t.yellow }
            "operator" = @{ foreground = $t.purple }
        }
        tokenColors = @(
            @{ name = "Comments"; scope = @("comment", "punctuation.definition.comment", "unused.comment", "wildcard.comment"); settings = @{ foreground = $t.comment; fontStyle = "italic" } },
            @{ name = "Doc Comments"; scope = @("comment.block.documentation", "comment.line.documentation"); settings = @{ foreground = "$($t.comment)"; fontStyle = "italic" } },
            @{ name = "Keywords"; scope = @("keyword", "keyword.control", "keyword.control.flow", "keyword.control.loop", "keyword.control.conditional", "keyword.control.import", "keyword.control.export", "keyword.declaration"); settings = @{ foreground = $t.purple; fontStyle = "bold" } },
            @{ name = "Storage"; scope = @("storage", "storage.type", "storage.modifier", "storage.type.function", "storage.type.class", "storage.type.struct", "storage.type.var", "storage.type.let", "storage.type.const"); settings = @{ foreground = $t.purple } },
            @{ name = "Functions & Methods"; scope = @("entity.name.function", "entity.name.function.definition", "entity.name.function.call", "support.function", "meta.function-call"); settings = @{ foreground = $t.cyan } },
            @{ name = "Types & Structs"; scope = @("entity.name.type", "entity.name.type.class", "entity.name.type.struct", "entity.name.type.interface", "support.type", "support.class"); settings = @{ foreground = $t.green; fontStyle = "italic" } },
            @{ name = "Tags"; scope = @("entity.name.tag", "support.class.component"); settings = @{ foreground = $t.cyan } },
            @{ name = "Strings"; scope = @("string", "string.quoted", "string.template", "string.raw"); settings = @{ foreground = $t.orange } },
            @{ name = "Numbers"; scope = @("constant.numeric", "constant.numeric.integer", "constant.numeric.float", "constant.numeric.hex"); settings = @{ foreground = $t.yellow } },
            @{ name = "Parameters"; scope = @("variable.parameter", "meta.parameter"); settings = @{ foreground = $t.tangerine; fontStyle = "italic" } },
            @{ name = "Attributes"; scope = @("entity.other.attribute-name"); settings = @{ foreground = $t.tangerine; fontStyle = "italic" } },
            @{ name = "Constants & Booleans"; scope = @("constant.language", "constant.language.boolean", "constant.language.nil", "constant.language.null", "constant.language.true", "constant.language.false"); settings = @{ foreground = $t.yellow; fontStyle = "bold" } },
            @{ name = "User Constants"; scope = @("constant.other", "variable.other.constant"); settings = @{ foreground = $t.yellow } },
            @{ name = "Escapes"; scope = @("constant.character.escape", "string.regexp"); settings = @{ foreground = $t.pink } },
            @{ name = "Variables"; scope = @("variable", "variable.other", "variable.other.readwrite"); settings = @{ foreground = $t.fg } },
            @{ name = "Fields & Object Keys"; scope = @("meta.object-literal.key", "variable.object.property", "support.type.property-name", "entity.name.variable.field"); settings = @{ foreground = $t.pink } },
            @{ name = "Decorators"; scope = @("entity.name.function.decorator", "meta.decorator"); settings = @{ foreground = $t.purple; fontStyle = "italic" } },
            @{ name = "Operators"; scope = @("keyword.operator", "keyword.operator.arithmetic", "keyword.operator.bitwise", "keyword.operator.assignment", "keyword.operator.comparison"); settings = @{ foreground = $t.purple } },
            @{ name = "Delimiters"; scope = @("punctuation", "punctuation.separator", "punctuation.terminator"); settings = @{ foreground = $t.fg } },
            @{ name = "Brackets"; scope = @("punctuation.brackets", "punctuation.curly.brace", "punctuation.square.bracket"); settings = @{ foreground = $t.purple } },
            @{ name = "JSON Keys"; scope = @("support.type.property-name.json"); settings = @{ foreground = $t.cyan } },
            @{ name = "JSON Values"; scope = @("source.json meta.structure.dictionary.value.json string.quoted.double.json"); settings = @{ foreground = $t.orange } },
            @{ name = "Markdown Headings"; scope = @("heading.1.markdown", "heading.2.markdown", "markup.heading"); settings = @{ foreground = $t.purple; fontStyle = "bold" } },
            @{ name = "Markdown Bold"; scope = @("markup.bold"); settings = @{ foreground = $t.yellow; fontStyle = "bold" } },
            @{ name = "Markdown Code"; scope = @("markup.raw.inline", "markup.raw.block"); settings = @{ foreground = $t.green } },
            @{ name = "CSS Selectors"; scope = @("entity.other.attribute-name.class.css", "entity.name.tag.css"); settings = @{ foreground = $t.green } },
            @{ name = "CSS Properties"; scope = @("support.type.property-name.css"); settings = @{ foreground = $t.cyan } },
            @{ name = "CSS Values"; scope = @("support.constant.property-value.css", "constant.numeric.css"); settings = @{ foreground = $t.yellow } },
            @{ name = "Git Deleted"; scope = @("markup.deleted"); settings = @{ foreground = $t.red } },
            @{ name = "Git Inserted"; scope = @("markup.inserted"); settings = @{ foreground = $t.green } },
            @{ name = "Git Changed"; scope = @("markup.changed"); settings = @{ foreground = $t.orange } },
            @{ name = "Invalid"; scope = @("invalid"); settings = @{ foreground = $t.red; fontStyle = "underline" } }
        )
    }
    return ($obj | ConvertTo-Json -Depth 10)
}

$themesDir = Join-Path $PSScriptRoot "..\themes"
if (-not (Test-Path $themesDir)) {
    $themesDir = "C:\Users\sevnth\draculas-vial\themes"
}

foreach ($t in $themeDefinitions) {
    $filePath = Join-Path $themesDir "$($t.id).json"
    $json = Build-ThemeJson $t
    [System.IO.File]::WriteAllText($filePath, $json, [System.Text.Encoding]::UTF8)
    Write-Host "Generated: $($t.id).json"
}

Write-Host "Successfully generated all theme JSON files!"
