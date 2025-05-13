# OpenRGB-Monitor-Status

This script detects whether your monitor is on or off and applies an OpenRGB profile accordingly.

## 📝 Description

OpenRGB-Monitor-Status is a small automation setup that toggles your RGB lighting based on the monitor's power state. It relies on Windows PowerShell (used for the logic), VBScript (used **only to hide the PowerShell window**), and OpenRGB command-line support.

Since OpenRGB's command-line interface **does not support loading effect profiles**, only standard profiles can be applied. This limitation means you must embed any desired effects directly into your saved profiles.

## 📁 Files

You will find (or must create) the following files in the same folder:

- `OpenRGB ON.lnk` — Shortcut to `OpenRGB.exe` that applies your **"ON"** profile (used when the monitor is **on**).
- `OpenRGB OFF.lnk` — Shortcut to `OpenRGB.exe` that applies your **"OFF"** profile (used when the monitor is **off**).
- `openRGBMonitorStatus.ps1` — PowerShell script that checks the monitor status and runs the appropriate shortcut.
- `openRGBMonitorStatus.vbs` — VBScript that silently launches the PowerShell script (used **only to hide the PowerShell window**).

> ⚠️ **All four files must reside in the same folder for everything to work properly.**

![same folder](images/same%20folder.png)

## 🛠️ How to Set Up

### 1. Create Your OpenRGB Shortcuts

Manually create two Windows shortcuts (`.lnk`) pointing to your `OpenRGB.exe`, each with a different `--profile` argument.

- **OpenRGB ON.lnk**
  ```text
  Target: "C:\Path\To\OpenRGB.exe" --profile ON
  
- ("ON" is the name of the profile, you can change it to whatever profile name you want to be applied when monitor is on)

- **OpenRGB OFF.lnk**
  ```text
  Target: "C:\Path\To\OpenRGB.exe" --profile OFF

- ("OFF" is the name of the profile, you can change it to whatever profile name you want to be applied when monitor is off)

  
### 2. Set It to Run at Startup

To make the script automatically run when you log into Windows, you have two options:

#### 🧩 Option A: Use Task Scheduler

1. Open **Task Scheduler**.
2. Create a **new task** (not basic).
3. Under **Triggers**, set:
   - **Begin the task**: At log on
4. Under **Actions**, set:
   - **Action**: Start a program  
   - **Program/script**: Browse and select the `openRGBMonitorStatus.vbs` file
5. (Optional) Under **General**, check **"Run with highest privileges"** for better reliability.

#### 🚀 Option B: Use the Startup Folder

1. Press `Win + R`, then type:
   ```text
   shell:startup
2. Paste a shortcut to the `openRGBMonitorStatus.vbs` file into the folder that opens.