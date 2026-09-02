# Dracula's Vial - Standalone .VSIX Package Builder
# Builds a valid VS Code .vsix archive without npm or node dependencies.

$rootDir = Join-Path $PSScriptRoot ".."
$packageJsonPath = Join-Path $rootDir "package.json"
$pkg = Get-Content $packageJsonPath -Raw | ConvertFrom-Json

$version = $pkg.version
$name = $pkg.name
$vsixFileName = "$name-$version.vsix"
$vsixFilePath = Join-Path $rootDir $vsixFileName

$tempDir = Join-Path ([System.IO.Path]::GetTempPath()) ([System.Guid]::NewGuid().ToString())
$extDir = Join-Path $tempDir "extension"

New-Item -ItemType Directory -Path $extDir -Force | Out-Null

Write-Host "📦 Packaging $name v$version into $vsixFileName..."

# Files and directories to include (per .vscodeignore)
$includeFiles = @("package.json", "README.md", "CHANGELOG.md", "LICENSE", "icon.png")
foreach ($f in $includeFiles) {
    $src = Join-Path $rootDir $f
    if (Test-Path $src) {
        Copy-Item $src (Join-Path $extDir $f) -Force
    }
}

# Copy themes and images directories
$themesSrc = Join-Path $rootDir "themes"
if (Test-Path $themesSrc) {
    Copy-Item $themesSrc (Join-Path $extDir "themes") -Recurse -Force
}

$imagesSrc = Join-Path $rootDir "images"
if (Test-Path $imagesSrc) {
    Copy-Item $imagesSrc (Join-Path $extDir "images") -Recurse -Force
}

# 1. Generate [Content_Types].xml
$contentTypesXml = @"
<?xml version="1.0" encoding="utf-8"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="json" ContentType="application/json"/>
  <Default Extension="png" ContentType="image/png"/>
  <Default Extension="jpg" ContentType="image/jpeg"/>
  <Default Extension="md" ContentType="text/markdown"/>
  <Default Extension="vsixmanifest" ContentType="text/xml"/>
  <Default Extension="xml" ContentType="text/xml"/>
  <Default Extension="txt" ContentType="text/plain"/>
  <Override PartName="/extension.vsixmanifest" ContentType="text/xml"/>
</Types>
"@
[System.IO.File]::WriteAllText((Join-Path $tempDir "[Content_Types].xml"), $contentTypesXml, [System.Text.Encoding]::UTF8)

# 2. Generate extension.vsixmanifest
$keywords = ($pkg.keywords -join ",") + ",__theme_dark,__ext_json"
$categories = ($pkg.categories -join ",")

$vsixManifestXml = @"
<?xml version="1.0" encoding="utf-8"?>
<PackageManifest Version="2.0.0" xmlns="http://schemas.microsoft.com/developer/vsx-schema/2011" xmlns:d="http://schemas.microsoft.com/developer/vsx-schema-design/2011">
  <Metadata>
    <Identity Language="en-US" Id="$($pkg.name)" Version="$($pkg.version)" Publisher="$($pkg.publisher)"/>
    <DisplayName>$([System.Security.SecurityElement]::Escape($pkg.displayName))</DisplayName>
    <Description xml:space="preserve">$([System.Security.SecurityElement]::Escape($pkg.description))</Description>
    <Tags>$keywords</Tags>
    <Categories>$categories</Categories>
    <GalleryFlags>Public</GalleryFlags>
    <Icon>extension/icon.png</Icon>
    <License>extension/LICENSE</License>
  </Metadata>
  <Installation>
    <InstallationTarget Id="Microsoft.VisualStudio.Code"/>
  </Installation>
  <Dependencies/>
  <Assets>
    <Asset Type="Microsoft.VisualStudio.Code.Manifest" Path="extension/package.json" Addressable="true"/>
    <Asset Type="Microsoft.VisualStudio.Services.Icons.Default" Path="extension/icon.png" Addressable="true"/>
    <Asset Type="Microsoft.VisualStudio.Services.Content.Details" Path="extension/README.md" Addressable="true"/>
    <Asset Type="Microsoft.VisualStudio.Services.Content.License" Path="extension/LICENSE" Addressable="true"/>
  </Assets>
</PackageManifest>
"@
[System.IO.File]::WriteAllText((Join-Path $tempDir "extension.vsixmanifest"), $vsixManifestXml, [System.Text.Encoding]::UTF8)

# 3. Zip into .vsix file
if (Test-Path $vsixFilePath) {
    Remove-Item $vsixFilePath -Force
}

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::CreateFromDirectory($tempDir, $vsixFilePath, [System.IO.Compression.CompressionLevel]::Optimal, $false)

# Clean up temp directory
Remove-Item $tempDir -Recurse -Force

$fileInfo = Get-Item $vsixFilePath
Write-Host "✨ Successfully created VS Code Extension Package: $vsixFileName ($([Math]::Round($fileInfo.Length / 1KB, 2)) KB)"
Write-Host "👉 You can install it in VS Code via: code --install-extension $vsixFileName"
