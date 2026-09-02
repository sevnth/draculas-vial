const fs = require('fs');
const path = require('path');

const ROOT_DIR = path.resolve(__dirname, '..');
const THEMES_DIR = path.join(ROOT_DIR, 'themes');

const themeFiles = [
  'dracula-vial-chromatic.json',
  'dracula-vial-pure-triad.json',
  'dracula-vial-neon-synth.json',
  'dracula-vial-deep-abyss.json',
  'dracula-vial-ice-fire.json',
  'dracula-vial-galactic-plasma.json',
  'dracula-vial-cyber-lavender.json'
];

console.log("🚀 Validating Dracula's Vial Themes...");

let hasErrors = false;

themeFiles.forEach(file => {
  const filePath = path.join(THEMES_DIR, file);
  try {
    if (!fs.existsSync(filePath)) {
      throw new Error(`Theme file missing: ${file}`);
    }
    const content = fs.readFileSync(filePath, 'utf8');
    const json = JSON.parse(content);

    if (!json.name || !json.colors || !json.tokenColors) {
      throw new Error(`Invalid theme structure in ${file}: missing required keys (name, colors, tokenColors)`);
    }

    const colorKeys = Object.keys(json.colors).length;
    const tokenRules = json.tokenColors.length;

    console.log(`✅ [${json.name}] (${file}) - ${colorKeys} UI workbench colors, ${tokenRules} TextMate token rules.`);
  } catch (err) {
    console.error(`❌ Error validating ${file}:`, err.message);
    hasErrors = true;
  }
});

if (hasErrors) {
  process.exit(1);
} else {
  console.log("\n✨ All Dracula's Vial theme variants passed validation successfully!");
}
