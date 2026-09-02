// Comprehensive token parity auditor between preview/app.js and themes/*.json
const fs = require('fs');
const path = require('path');

const appJsPath = path.join(__dirname, '..', 'preview', 'app.js');
const themesDir = path.join(__dirname, '..', 'themes');

const appJsContent = fs.readFileSync(appJsPath, 'utf8');

// Extract PRESETS
const presetsMatch = appJsContent.match(/const PRESETS = (\{[\s\S]*?\n\};)/);
if (!presetsMatch) {
  console.error("Could not find PRESETS in preview/app.js");
  process.exit(1);
}

// Evaluate PRESETS safely
const PRESETS = eval('(' + presetsMatch[1].replace(/;$/, '') + ')');

console.log("=== PRESETS LOADED ===");
console.log(Object.keys(PRESETS));

const themeFileMap = {
  'dracula-chromatic': 'dracula-vial-chromatic.json',
  'dracula-triad': 'dracula-vial-pure-triad.json',
  'dracula-neon-synth': 'dracula-vial-neon-synth.json',
  'dracula-deep-abyss': 'dracula-vial-deep-abyss.json',
  'dracula-ice-fire': 'dracula-vial-ice-fire.json',
  'dracula-galactic-plasma': 'dracula-vial-galactic-plasma.json',
  'dracula-cyber-lavender': 'dracula-vial-cyber-lavender.json'
};

let allPass = true;

for (const [presetKey, themeFile] of Object.entries(themeFileMap)) {
  const themePath = path.join(themesDir, themeFile);
  if (!fs.existsSync(themePath)) {
    console.error(`Missing theme file: ${themeFile}`);
    allPass = false;
    continue;
  }

  const themeJson = JSON.parse(fs.readFileSync(themePath, 'utf8'));
  const preset = PRESETS[presetKey];

  console.log(`\n========================================`);
  console.log(`Auditing: ${preset.name} -> ${themeFile}`);
  console.log(`========================================`);

  // Check Workbench Colors
  const editorBg = themeJson.colors['editor.background'];
  const sideBarBg = themeJson.colors['sideBar.background'];
  console.log(`  Editor Background: ${editorBg} (Preset: ${preset.colors.bg}) -> ${editorBg.toLowerCase() === preset.colors.bg.toLowerCase() ? '✅ MATCH' : '❌ MISMATCH'}`);
  console.log(`  Sidebar Background: ${sideBarBg} (Preset: ${preset.colors.bgDarker}) -> ${sideBarBg.toLowerCase() === preset.colors.bgDarker.toLowerCase() ? '✅ MATCH' : '❌ MISMATCH'}`);

  // Check Token Roles
  const tokenMap = [
    { role: 'Keywords (syn-purple)', presetHex: preset.colors.purple, themeToken: themeJson.semanticTokenColors.keyword?.foreground },
    { role: 'Declarations (syn-pink)', presetHex: preset.colors.pink, themeToken: themeJson.semanticTokenColors.storage?.foreground },
    { role: 'Functions (syn-cyan)', presetHex: preset.colors.cyan, themeToken: themeJson.semanticTokenColors.function?.foreground },
    { role: 'Types (syn-green)', presetHex: preset.colors.green, themeToken: themeJson.semanticTokenColors.type?.foreground },
    { role: 'Fields/Props (syn-pink)', presetHex: preset.colors.pink, themeToken: themeJson.semanticTokenColors.property?.foreground },
    { role: 'Parameters (syn-tangerine)', presetHex: preset.colors.tangerine, themeToken: themeJson.semanticTokenColors.parameter?.foreground },
    { role: 'Strings (syn-orange)', presetHex: preset.colors.orange, themeToken: themeJson.semanticTokenColors.string?.foreground },
    { role: 'Numbers (syn-yellow)', presetHex: preset.colors.yellow, themeToken: themeJson.semanticTokenColors.number?.foreground },
    { role: 'Comments (syn-slate)', presetHex: preset.colors.comment, themeToken: themeJson.semanticTokenColors.comment?.foreground }
  ];

  for (const item of tokenMap) {
    const match = item.presetHex.toLowerCase() === (item.themeToken || '').toLowerCase();
    if (!match) allPass = false;
    console.log(`  ${item.role.padEnd(28)}: Theme = ${item.themeToken || 'UNDEFINED'} | Preset = ${item.presetHex} -> ${match ? '✅ MATCH' : '❌ MISMATCH'}`);
  }
}

if (allPass) {
  console.log(`\n🎉 ALL 7 THEMES HAVE 100% TOKEN PARITY WITH PREVIEWS!`);
} else {
  console.log(`\n⚠️ SOME TOKENS HAVE DISCREPANCIES!`);
}
