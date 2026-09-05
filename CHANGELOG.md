# Change Log

All notable changes to the "Dracula's Vial" extension will be documented in this file.

## [1.0.2] - 2026-09-02

### Fixed & Enhanced
- **Marketplace & VSIX Image Rendering**: Converted all README and documentation image URLs to absolute HTTPS GitHub raw assets so all badges, logos, banners, and screenshots render flawlessly in the VS Code Marketplace, Extension Details webview, and GitHub repository.
- **Package & Namespace Highlighting**: Enhanced TextMate and semantic rules for imported modules and namespaces (`fmt`, `context`, `time`, `big`, `ethclient`, `types`, `React`, `asyncio`, etc.) to highlight in Electric Cyan (`#00f0ff`) and Spring Green (`#00f5d4`).
- **Composite Type Constructors**: Mapped Go type constructors (`map`, `chan`, `slice`) to render in Green Italic.

---

## [1.0.1] - 2026-09-02

### Fixed & Enhanced
- **100% Visual Parity with Previews**: Completely audited and aligned TextMate scopes and Semantic Token definitions across all 7 editions to guarantee exact 1:1 visual fidelity with the Interactive Color Lab studio.
- **Type Declaration Keywords**: Precision mapping for `type`, `struct`, `interface`, and `enum` keywords to render in Signature Pink/Magenta (`#f15bb5` in Deep Abyss / `#ff79c6` in Chromatic).
- **Primitive & Composite Types**: Standardized built-in types (`string`, `number`, `bool`, `uint32`, `int64`, `float64`, `error`) in Green Italic across Go, TypeScript/TSX, Python, and Rust.
- **Struct Fields & Object Properties**: Ensured struct field definitions, interface properties, and composite literal keys render consistently in Signature Pink.
- **Language Server Interoperability**: Fine-tuned semantic token hierarchy so language servers (`gopls`, `tsserver`, `pylance`, `rust-analyzer`) preserve fine-grained TextMate keyword differentiation.
- **Sample Codebases**: Synchronized `samples/app.tsx` and `samples/executor.go` with preview code samples for instant validation.

---

## [1.0.0] - 2026-09-02

### Features
- **7 Curated Signature Elixir Editions**:
  - `Dracula's Vial - Chromatic (Rich Full-Spectrum)`: High-density multi-color edition.
  - `Dracula's Vial - Pure Triad (Cyan • Purple • Orange)`: Strict 3-color minimalist edition.
  - `Dracula's Vial - Neon Synth (Hot Pink • Cyan • Violet)`: High-voltage cyberpunk synthwave glow.
  - `Dracula's Vial - Deep Abyss (Oceanic Bioluminescence)`: Deep sea trench dark palette with aqua and phantom purple.
  - `Dracula's Vial - Ice & Fire (Glacial Cyan & Purple Flame)`: Cryogenic contrast between glacial cyan and purple flare.
  - `Dracula's Vial - Galactic Plasma (Plasma Violet & Solar)`: Cosmic plasma violet, radiant pink, and solar amber.
  - `Dracula's Vial - Cyber Lavender (Pastel Cyber)`: Eye-friendly pastel lavender and soft cyan for long coding sessions.
- **Interactive Live Color Lab Studio** (`preview/index.html`): Real-time in-browser theme tester, custom palette generator, and `settings.json` exporter.
- **Automated Validation Suite** (`scripts/validate.ps1`): Verifying 282 UI color keys and comprehensive TextMate semantic token rules per theme.
- **Go Reference Sample** (`samples/transfer.go`): Realistic sample showcasing syntax tokens.
