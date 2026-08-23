<div align="center">

# Orime Optimizer

**Reversible Windows game optimizer built with WinUI 3 and .NET 10.**

[![Platform](https://img.shields.io/badge/Windows-10%20%7C%2011%20(64--bit)-0078D4?style=flat-square&logo=windows)](https://github.com/Nahvine/Orime-Release)
[![Framework](https://img.shields.io/badge/WinUI%203-.NET%2010-512BD4?style=flat-square&logo=dotnet)](https://github.com/Nahvine/Orime-Release)
[![License](https://img.shields.io/badge/License-Proprietary-gray?style=flat-square)](https://github.com/Nahvine/Orime-Release)

[Website](https://orime.osteup.io.vn) | [Bản Tiếng Việt](README_VIETNAMESE.md) | [Releases](https://github.com/Nahvine/Orime-Release/releases)

<br/>

<img src="assets/gaming_mode_preview.png" alt="Orime Gaming Mode Preview" width="850" />

</div>

---

## Overview

Orime optimizes Windows 10 and 11 for lower input latency and smoother frame delivery during games.

Unlike static tweak scripts that make permanent registry edits, Orime saves a snapshot of your original system settings (services, power plans, and registry keys) into a local journal before making changes. When you turn off Gaming Mode or close the app, it restores those settings to their previous state.

<div align="center">
<img src="assets/tweaks_preview.png" alt="Orime Tweaks Configuration" width="850" />
</div>

---

## How to Use

1. **Launch Orime**: Open `Orime.exe` (run as Administrator for service and kernel timer adjustments).
2. **Choose a preset**: Select **Safe**, **Normal**, or **Extreme** mode on the main dashboard, or customize specific tweaks in the **Tweaks** tab.
3. **Activate Gaming Mode**: Click **Kích Hoạt** (Activate) before starting your game. The app will apply the selected tweaks and display live metrics (freed RAM, timer resolution, and network latency).
4. **Play your game**: Run your game normally.
5. **Restore settings**: When finished, click **Tắt** (Deactivate) or close Orime. A restore report will confirm that your system settings have returned to their original state.

---

## How Gaming Mode Works

When activated, Orime applies optimizations across seven sequential phases:

| Phase | Target | Purpose |
| :--- | :--- | :--- |
| **Phase 0** | **Background helpers** | Pauses background helper processes to prioritize CPU resources for gaming. |
| **Phase 1** | **Background services** | Temporarily pauses non-essential system services during gaming sessions. |
| **Phase 2** | **RAM and maintenance** | Purges standby memory cache and defers background maintenance tasks. |
| **Phase 3** | **Network latency** | Optimizes network routing and packet response times. |
| **Phase 4** | **Explorer shell (optional)** | Temporarily suspends the desktop shell to free memory and lower render overhead. |
| **Phase 5** | **Security scan priority** | Lowers background scan priority to prevent frame stutter. |
| **Phase 6** | **CPU and timer resolution** | Optimizes CPU power allocation and sets system timer resolution to 0.5 ms. |

---

## Presets

* **Safe Mode**: Suspends background updaters and applies power tweaks. Leaves web browsers, Discord, and Windows Search untouched.
* **Normal Mode**: Recommended for most games. Adds standby memory clearing, 0.5 ms timer resolution, and CPU core unparking.
* **Extreme Mode**: Intended for low-spec hardware or competitive play where reducing latency is the priority.

---

## Frequently Asked Questions

### Can this trigger an anticheat ban in online games?
**No.** Orime works strictly at the Windows operating system level (power plans, system services, memory cache, and network parameters). It does not inject code, hook game processes, modify game files, or touch game memory. It is fully compatible with Riot Vanguard, Easy Anti-Cheat, BattlEye, Valve Anti-Cheat (VAC), and Ricochet.

### Does Orime make permanent changes or break Windows Update?
**No.** Every modification is recorded in a local state journal before application. When you turn off Gaming Mode or exit the app, Orime rolls back each setting to its exact pre-activation state. Windows Update and core system components remain intact.

### What happens if my PC crashes or loses power while Gaming Mode is on?
On the next launch, Orime detects the unfinished session from the saved journal and automatically restores your original system settings.

### Do I need an internet connection to use Orime?
**No.** All core optimization phases work locally and offline. Network tests (DNS ping measurements in Phase 3) will simply skip if no connection is present.

### Does Phase 0 close my open browser tabs?
**No.** Phase 0 only suspends background updater and helper services (such as browser update checkers). Your browser windows, tabs, and active applications remain open.

---

## Commands

### Install or Update

Open **PowerShell** and run:

```powershell
irm https://raw.githubusercontent.com/Nahvine/Orime-Release/main/install.ps1 | iex
```

Running this command on a system that already has Orime will close the running app, replace the application files with the latest build, and update desktop and Start menu shortcuts. Your saved configuration is stored separately in `%LOCALAPPDATA%\Orime` and will stay intact.

### Uninstall

To remove Orime, its shortcuts, and associated data from your system:

```powershell
irm https://raw.githubusercontent.com/Nahvine/Orime-Release/main/uninstall.ps1 | iex
```

The script will:
1. Stop any running Orime processes.
2. Remove shortcuts from the Desktop and Start Menu.
3. Delete the install folder from `Program Files` or `AppData\Programs`.
4. Remove any registered MSIX package.
5. Clean up temporary files and user data in `%LOCALAPPDATA%\Orime`.

### Portable Build

If you prefer not to use the installer:

1. Download [Orime_v1.0_Portable_x64.zip](https://raw.githubusercontent.com/Nahvine/Orime-Release/main/download/Orime_v1.0_Portable_x64.zip) or grab it from [Releases](https://github.com/Nahvine/Orime-Release/releases).
2. Extract the archive.
3. Run `Orime.exe`.

---

## System Requirements

* Windows 10 or Windows 11 (64-bit).
* Administrator rights (required for adjusting the 0.5 ms kernel timer and Windows service states).
* The portable download includes the required .NET 10 runtime files.
