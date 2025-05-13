# OpenRGB-Monitor-Status

This script detects whether your monitor is on or off and applies an OpenRGB profile accordingly.

## 📝 Description

OpenRGB-Monitor-Status is a small automation setup that toggles your RGB lighting based on the monitor's power state. It relies on Windows PowerShell (used for the logic), VBScript (used **only to hide the PowerShell window**), and OpenRGB command-line support.

Since OpenRGB's command-line interface **does not support loading effect profiles**, only standard profiles can be applied. This limitation means you must embed any desired effects directly into your saved profiles.

## 📁 Files

You will find (or must create) the following files in the same folder:

- `OpenRGB ON.lnk` — Shortcut to `OpenRGB.exe` that applies your **"ON"** profile (used when the monitor is **on**).
- `OpenRGB OFF.lnk` — Shortcut to `OpenRGB.exe` that applies your **"OFF"** profile (used when the monitor is **off**).
- `monitor-status.ps1` — PowerShell script that checks the monitor status and runs the appropriate shortcut.
- `monitor-status.vbs` — VBScript that silently launches the PowerShell script (used **only to hide the PowerShell window**).

> ⚠️ **All four files must reside in the same folder for everything to work properly.**

## 🛠️ How to Set Up

### 1. Create Your OpenRGB Shortcuts

Manually create two Windows shortcuts (`.lnk`) pointing to your `OpenRGB.exe`, each with a different `--profile` argument.

- **OpenRGB ON.lnk**
  ```text
  Target: "C:\Path\To\OpenRGB.exe" --profile ON

  - **OpenRGB OFF.lnk**
  ```text
  Target: "C:\Path\To\OpenRGB.exe" --profile OFF
