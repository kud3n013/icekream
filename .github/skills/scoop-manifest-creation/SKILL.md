---
name: scoop-manifest-creation
description: Comprehensive guide, standards, schemas, and templates for creating, auto-updating, validating, and maintaining Scoop package manifests across Main, Extras, Versions, Nonportable, and Nirsoft buckets.
---

# Scoop Manifest Creation Skill 🍨

This skill provides complete reference rules, schemas, design patterns, auto-update configurations, and verification workflows for creating high-quality, auto-updating Scoop package manifests.

---

## 1. Scoop Bucket Classification Matrix

When creating a new manifest, determine which bucket repository pattern it belongs to:

| Bucket Category | Primary Purpose & Scope | Technical Requirements & Constraints | Naming Convention | Example Applications |
|---|---|---|---|---|
| **Main** | Command-Line Interface (CLI) tools, developer utilities, compilers, interpreters. | • Strictly portable (no admin/UAC required)<br>• No Start menu/desktop shortcuts<br>• No machine-wide registry changes<br>• Must extract cleanly into `$dir` | `<app>.json` | `git`, `curl`, `7zip`, `jq`, `ripgrep` |
| **Extras** | Portable GUI Applications, desktop tools, IDEs, media players. | • Portable extraction preferred<br>• Uses `shortcuts` array for Start menu<br>• Uses `persist` for user configuration/data<br>• No background system services | `<app>.json` | `vscode`, `vlc`, `firefox`, `zalo`, `unikey` |
| **Versions** | Alternate/parallel app versions: Nightly, Beta, Dev, Insiders, or legacy major releases. | • Prevents shim collisions with Main/Extras<br>• Clearly specifies channel or version number<br>• Auto-update handles specific release tags | `<app>-<version>` or `<app>-<channel>` | `python39`, `vscode-insiders`, `go-nightly` |
| **Nonportable** | Applications requiring system-wide installation, admin rights, or system integration. | • **MUST** end with `-np` suffix<br>• Uses system installers (MSI, InnoSetup, NSIS)<br>• Installs drivers, services, or global shortcuts | `<app>-np.json` | `docker-desktop-np`, `sandboxie-plus-np` |
| **Nirsoft** | Standalone NirSoft system utilities. | • Standard URL: `https://www.nirsoft.net/utils/<app>.zip`<br>• Standardized 32-bit/64-bit URL handling<br>• Uniform `checkver` pattern | `<app>.json` | `cport`, `blueScreenView`, `netrouteview` |

---

## 2. Complete Scoop Manifest JSON Specification

Scoop manifests are formatted as JSON files (`.json`) with UTF-8 encoding (without BOM) and 4-space or 2-space indentation.

### Top-Level Properties

```json
{
    "$schema": "https://raw.githubusercontent.com/ScoopInstaller/Scoop/master/schema.json",
    "version": "1.0.0",
    "description": "Short, clear single-sentence summary of the application.",
    "homepage": "https://example.com",
    "license": "MIT",
    "notes": "Post-installation notes displayed to the user.",
    "suggest": {
        "Feature Name": "bucket/app"
    },
    "depends": [
        "extras/vcredist2022"
    ],
    "url": "https://example.com/download/app-1.0.0.zip",
    "hash": "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    "extract_dir": "app-1.0.0",
    "bin": [
        "app.exe",
        [
            "app.exe",
            "app-cli",
            "--cli-mode"
        ]
    ],
    "shortcuts": [
        [
            "app.exe",
            "App Name"
        ]
    ],
    "persist": [
        "config.json",
        "data"
    ],
    "checkver": {
        "github": "https://github.com/owner/repo"
    },
    "autoupdate": {
        "url": "https://example.com/download/app-$version.zip"
    }
}
```

### Property Reference Table

| Property | Type | Description & Usage |
|---|---|---|
| `$schema` | String | Path to official Scoop JSON schema for syntax validation. |
| `version` | String | Version string (e.g. `"1.2.3"`, `"2026.07"`). |
| `description` | String | One-line description of the software. |
| `homepage` | String | Official website or repository URL. |
| `license` | String \| Object | SPDX expression (`"MIT"`, `"GPL-3.0-only"`) or object `{"identifier": "Freeware", "url": "..."}`. |
| `notes` | String \| Array | Displayed after `scoop install` or `scoop update`. |
| `url` | String \| Array | File download URL(s). |
| `hash` | String \| Array | SHA-256 hash (or `sha512:...`, `md5:...`). |
| `architecture` | Object | Architecture-specific overrides (`64bit`, `32bit`, `arm64`). |
| `extract_dir` | String \| Array | Root directory to extract from archive. |
| `extract_to` | String \| Array | Destination subfolder inside `$dir`. |
| `bin` | String \| Array | Creates executable shims in Scoop's `bin/` directory. |
| `shortcuts` | Array of Arrays | Start menu shortcuts `[["target.exe", "Shortcut Name", "args", "icon.ico"]]`. |
| `env_add_path` | String \| Array | Adds relative path(s) to user `PATH` environment variable. |
| `env_set` | Object | Sets environment variables (e.g., `{ "APP_HOME": "$dir" }`). |
| `persist` | String \| Array | Persists files/folders to `~/scoop/persist/<app>/` across updates. |
| `installer` | Object | Custom installer script (`script`, `file`, `args`, `keep`). |
| `uninstaller` | Object | Custom uninstaller script (`script`, `file`, `args`). |
| `pre_install` | String \| Array | PowerShell code executed prior to extraction/copying. |
| `post_install` | String \| Array | PowerShell code executed after installation. |
| `pre_uninstall` | String \| Array | PowerShell code executed before uninstallation. |
| `post_uninstall` | String \| Array | PowerShell code executed after uninstallation. |
| `checkver` | String \| Object | Version checker configuration for Scoop Excavator. |
| `autoupdate` | Object | Template rules to update manifest when new version is found. |

---

## 3. Auto-Update (`checkver` & `autoupdate`) Specification

### Checkver Strategies

#### 1. GitHub Releases
```json
"checkver": {
    "github": "https://github.com/owner/repo"
}
```

#### 2. Regex Page Scraping
```json
"checkver": {
    "url": "https://example.com/downloads",
    "regex": "app-v?([\\d.]+)\\.zip"
}
```

#### 3. Named Regex Capture Groups
```json
"checkver": {
    "url": "https://example.com/releases",
    "regex": "version-(?<version>[\\d.]+)-build-(?<build>\\d+)"
}
```

#### 4. JSON API / JSONPath
```json
"checkver": {
    "url": "https://api.github.com/repos/owner/repo/releases/latest",
    "jsonpath": "$.tag_name",
    "regex": "v?(.*)"
}
```

### Autoupdate Variables & Replacement Rules

- **`$version`**: Version matched by `checkver`.
- **`$match1`, `$match2`**: Positional regex capture groups.
- **`$match<group_name>`**: Named regex capture group (e.g. `$matchBuild`).
- **`$url`**: Computed target URL.
- **`$sha256`**: Automatically computed SHA-256 hash by Scoop Excavator.
- **`$cleanVersion`**: Version string stripped of hyphens and special characters.

```json
"autoupdate": {
    "architecture": {
        "64bit": {
            "url": "https://github.com/owner/repo/releases/download/v$version/app-v$version-x64.zip"
        },
        "32bit": {
            "url": "https://github.com/owner/repo/releases/download/v$version/app-v$version-x86.zip"
        }
    }
}
```

---

## 4. Manifest Templates by Category

### A. Portable CLI Tool (Main Style)
```json
{
    "$schema": "https://raw.githubusercontent.com/ScoopInstaller/Scoop/master/schema.json",
    "version": "2.4.0",
    "description": "High-performance command-line JSON processor.",
    "homepage": "https://example.com/cli-tool",
    "license": "MIT",
    "architecture": {
        "64bit": {
            "url": "https://example.com/downloads/cli-tool-v2.4.0-win-x64.zip",
            "hash": "a1b2c3d4e5f67890123456789abcdef0123456789abcdef0123456789abcdef0"
        }
    },
    "extract_dir": "cli-tool-v2.4.0-win-x64",
    "bin": "cli-tool.exe",
    "checkver": {
        "github": "https://github.com/owner/cli-tool"
    },
    "autoupdate": {
        "architecture": {
            "64bit": {
                "url": "https://example.com/downloads/cli-tool-v$version-win-x64.zip"
            }
        },
        "extract_dir": "cli-tool-v$version-win-x64"
    }
}
```

### B. Portable GUI App with Shortcuts & Persistence (Extras Style)
```json
{
    "$schema": "https://raw.githubusercontent.com/ScoopInstaller/Scoop/master/schema.json",
    "version": "1.8.0",
    "description": "Modern cross-platform markdown editor.",
    "homepage": "https://example.com/editor",
    "license": "GPL-3.0-only",
    "architecture": {
        "64bit": {
            "url": "https://example.com/downloads/editor-1.8.0-x64.zip",
            "hash": "1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef"
        }
    },
    "bin": "Editor.exe",
    "shortcuts": [
        [
            "Editor.exe",
            "Markdown Editor"
        ]
    ],
    "persist": [
        "settings.json",
        "plugins"
    ],
    "checkver": {
        "url": "https://example.com/downloads",
        "regex": "editor-([\\d.]+)-x64\\.zip"
    },
    "autoupdate": {
        "architecture": {
            "64bit": {
                "url": "https://example.com/downloads/editor-$version-x64.zip"
            }
        }
    }
}
```

### C. Non-Portable System App (`-np` Style)
```json
{
    "$schema": "https://raw.githubusercontent.com/ScoopInstaller/Scoop/master/schema.json",
    "version": "4.2.1",
    "description": "System container management engine (Non-portable).",
    "homepage": "https://example.com/container-engine",
    "license": "Proprietary",
    "notes": "Requires administrator privileges for system-wide installation.",
    "architecture": {
        "64bit": {
            "url": "https://example.com/downloads/EngineSetup-4.2.1.exe",
            "hash": "abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789"
        }
    },
    "installer": {
        "script": [
            "if (-not (is_admin)) { error 'Administrator privileges are required.'; break }",
            "Start-Process -FilePath \"$dir\\EngineSetup-$version.exe\" -ArgumentList '/S', '/allusers' -Wait"
        ]
    },
    "uninstaller": {
        "script": [
            "if (-not (is_admin)) { error 'Administrator privileges are required.'; break }",
            "Start-Process -FilePath \"$env:ProgramFiles\\Container Engine\\uninstall.exe\" -ArgumentList '/S' -Wait"
        ]
    },
    "checkver": {
        "github": "https://github.com/owner/engine"
    },
    "autoupdate": {
        "architecture": {
            "64bit": {
                "url": "https://example.com/downloads/EngineSetup-$version.exe"
            }
        }
    }
}
```

---

## 5. Development & Validation Workflow

When adding or modifying a manifest in a bucket:

1. **Verify Source Files**: Ensure URLs are direct download links and calculate exact SHA-256 hashes using `Get-FileHash -Algorithm SHA256 <file>`.
2. **Validate JSON Syntax**: Ensure strict JSON rules (double quotes, no trailing commas).
3. **Run PSScriptAnalyzer / Bucket Tests**:
   ```pwsh
   Invoke-PSScriptAnalyzer -Path . -Recurse
   .\Scoop-Bucket.Tests.ps1
   ```
4. **Local Installation Test**:
   ```pwsh
   scoop install .\bucket\<manifest-name>.json
   ```
5. **Auto-Update Test**:
   ```pwsh
   scoop checkver <manifest-name>
   ```
6. **Uninstallation & Cleanup Test**:
   ```pwsh
   scoop uninstall <manifest-name>
   ```
