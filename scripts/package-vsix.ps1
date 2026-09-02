# Dracula's Vial - Standalone .VSIX Package Builder
# Builds a 100% compliant VS Code Marketplace .vsix archive with normalized OPC paths.

$rootDir = Join-Path $PSScriptRoot ".."
$packageJsonPath = Join-Path $rootDir "package.json"
$pkg = Get-Content $packageJsonPath -Raw | ConvertFrom-Json

$version = $pkg.version
$name = $pkg.name
$publisher = $pkg.publisher
$vsixFileName = "$name-$version.vsix"
$vsixFilePath = Join-Path $rootDir $vsixFileName

$tempDir = Join-Path ([System.IO.Path]::GetTempPath()) ([System.Guid]::NewGuid().ToString())
$extDir = Join-Path $tempDir "extension"

New-Item -ItemType Directory -Path $extDir -Force | Out-Null

Write-Host "📦 Packaging $name v$version for publisher '$publisher' into $vsixFileName..."

# Files and directories to include
$includeFiles = @("package.json", "README.md", "CHANGELOG.md", "LICENSE", "icon.png")
foreach ($f in $includeFiles) {
    $src = Join-Path $rootDir $f
    if (Test-Path $src) {
        Copy-Item $src (Join-Path $extDir $f) -Force
    }
}

# Also provide LICENSE.txt (standard Marketplace license asset format)
$licenseSrc = Join-Path $rootDir "LICENSE"
if (Test-Path $licenseSrc) {
    Copy-Item $licenseSrc (Join-Path $extDir "LICENSE.txt") -Force
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

# Clean any macOS .DS_Store artifacts
Get-ChildItem -Path $tempDir -Filter ".DS_Store" -Recurse -Force -ErrorAction SilentlyContinue | Remove-Item -Force

# 1. Generate [Content_Types].xml with full OPC overrides
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
  <Default Extension="svg" ContentType="image/svg+xml"/>
  <Override PartName="/extension.vsixmanifest" ContentType="text/xml"/>
  <Override PartName="/[Content_Types].xml" ContentType="application/xml"/>
  <Override PartName="/extension/package.json" ContentType="application/json"/>
  <Override PartName="/extension/README.md" ContentType="text/markdown"/>
  <Override PartName="/extension/CHANGELOG.md" ContentType="text/markdown"/>
  <Override PartName="/extension/icon.png" ContentType="image/png"/>
  <Override PartName="/extension/LICENSE" ContentType="text/plain"/>
  <Override PartName="/extension/LICENSE.txt" ContentType="text/plain"/>
</Types>
"@
[System.IO.File]::WriteAllText((Join-Path $tempDir "[Content_Types].xml"), $contentTypesXml, [System.Text.Encoding]::UTF8)

# 2. Generate extension.vsixmanifest with full Marketplace properties
$keywords = ($pkg.keywords -join ",") + ",__theme_dark,__ext_json"
$categories = ($pkg.categories -join ",")

$repoUrl = if ($pkg.repository -and $pkg.repository.url) { $pkg.repository.url } else { "https://github.com/sevnth/draculas-vial.git" }
$bugsUrl = if ($pkg.bugs -and $pkg.bugs.url) { $pkg.bugs.url } else { "https://github.com/sevnth/draculas-vial/issues" }
$homeUrl = if ($pkg.homepage) { $pkg.homepage } else { "https://github.com/sevnth/draculas-vial#readme" }

$vsixManifestXml = @"
<?xml version="1.0" encoding="utf-8"?>
<PackageManifest Version="2.0.0" xmlns="http://schemas.microsoft.com/developer/vsx-schema/2011" xmlns:d="http://schemas.microsoft.com/developer/vsx-schema-design/2011">
  <Metadata>
    <Identity Language="en-US" Id="$name" Version="$version" Publisher="$publisher"/>
    <DisplayName>$([System.Security.SecurityElement]::Escape($pkg.displayName))</DisplayName>
    <Description xml:space="preserve">$([System.Security.SecurityElement]::Escape($pkg.description))</Description>
    <Tags>$keywords</Tags>
    <Categories>$categories</Categories>
    <GalleryFlags>Public</GalleryFlags>
    <Properties>
      <Property Id="Microsoft.VisualStudio.Code.Engine" Value="$($pkg.engines.vscode)" />
      <Property Id="Microsoft.VisualStudio.Code.ExtensionDependencies" Value="" />
      <Property Id="Microsoft.VisualStudio.Code.ExtensionPack" Value="" />
      <Property Id="Microsoft.VisualStudio.Code.ExtensionKind" Value="ui,workspace" />
      <Property Id="Microsoft.VisualStudio.Code.LocalizedLanguages" Value="" />
      <Property Id="Microsoft.VisualStudio.Services.Links.Source" Value="$repoUrl" />
      <Property Id="Microsoft.VisualStudio.Services.Links.Getstarted" Value="$repoUrl" />
      <Property Id="Microsoft.VisualStudio.Services.Links.GitHub" Value="$repoUrl" />
      <Property Id="Microsoft.VisualStudio.Services.Links.Support" Value="$bugsUrl" />
      <Property Id="Microsoft.VisualStudio.Services.Links.Learn" Value="$homeUrl" />
      <Property Id="Microsoft.VisualStudio.Services.Branding.Color" Value="#191a21" />
      <Property Id="Microsoft.VisualStudio.Services.Branding.Theme" Value="dark" />
      <Property Id="Microsoft.VisualStudio.Services.GitHubFlavoredMarkdown" Value="true" />
      <Property Id="Microsoft.VisualStudio.Services.Content.Packaging.Version" Value="1" />
    </Properties>
    <License>extension/LICENSE.txt</License>
    <Icon>extension/icon.png</Icon>
  </Metadata>
  <Installation>
    <InstallationTarget Id="Microsoft.VisualStudio.Code"/>
  </Installation>
  <Dependencies/>
  <Assets>
    <Asset Type="Microsoft.VisualStudio.Code.Manifest" Path="extension/package.json" Addressable="true"/>
    <Asset Type="Microsoft.VisualStudio.Services.Icons.Default" Path="extension/icon.png" Addressable="true"/>
    <Asset Type="Microsoft.VisualStudio.Services.Content.Details" Path="extension/README.md" Addressable="true"/>
    <Asset Type="Microsoft.VisualStudio.Services.Content.Changelog" Path="extension/CHANGELOG.md" Addressable="true"/>
    <Asset Type="Microsoft.VisualStudio.Services.Content.License" Path="extension/LICENSE.txt" Addressable="true"/>
  </Assets>
</PackageManifest>
"@
[System.IO.File]::WriteAllText((Join-Path $tempDir "extension.vsixmanifest"), $vsixManifestXml, [System.Text.Encoding]::UTF8)

# 3. Create .vsix with normalized forward-slash entry names (cross-platform ZIP standard)
if (Test-Path $vsixFilePath) {
    Remove-Item $vsixFilePath -Force
}

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$zipArchive = [System.IO.Compression.ZipFile]::Open($vsixFilePath, [System.IO.Compression.ZipArchiveMode]::Create)
try {
    $allFiles = Get-ChildItem -Path $tempDir -Recurse -File
    foreach ($file in $allFiles) {
        $relPath = $file.FullName.Substring($tempDir.Length).TrimStart('\', '/')
        $entryName = $relPath -replace '\\', '/'

        $entry = $zipArchive.CreateEntry($entryName, [System.IO.Compression.CompressionLevel]::Optimal)
        $entryStream = $entry.Open()
        try {
            $fileStream = [System.IO.File]::OpenRead($file.FullName)
            try {
                $fileStream.CopyTo($entryStream)
            } finally {
                $fileStream.Dispose()
            }
        } finally {
            $entryStream.Dispose()
        }
    }
} finally {
    $zipArchive.Dispose()
}

# Clean up temp directory
Remove-Item $tempDir -Recurse -Force

$fileInfo = Get-Item $vsixFilePath
Write-Host "✨ Successfully created Marketplace-ready VSIX package: $vsixFileName ($([Math]::Round($fileInfo.Length / 1KB, 2)) KB)"
Write-Host "Publisher: $publisher | Target: VS Code $($pkg.engines.vscode)"
