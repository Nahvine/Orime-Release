<div align="center">

# ⚡ Orime Optimizer

**A high-performance, 100% reversible Windows game optimizer built with WinUI 3 & .NET 10.**

[![Platform](https://img.shields.io/badge/Windows-10%20%7C%2011%20(64--bit)-0078D4?style=flat-square&logo=windows)](https://github.com/Nahvine/Orime-Release)
[![Framework](https://img.shields.io/badge/WinUI%203-.NET%2010-512BD4?style=flat-square&logo=dotnet)](https://github.com/Nahvine/Orime-Release)
[![License](https://img.shields.io/badge/License-Proprietary-gray?style=flat-square)](https://github.com/Nahvine/Orime-Release)

[**Website**](https://orime.osteup.io.vn) • [**Bản Tiếng Việt**](README_VIETNAMESE.md) • [**GitHub Releases**](https://github.com/Nahvine/Orime-Release/releases)

<br/>

<img src="assets/gaming_mode_preview.png" alt="Orime Gaming Mode Preview" width="850" />

</div>

---

## 🎯 Why Orime?

Most "Windows optimizers" out there are just messy collections of aggressive batch scripts and registry hacks. They often break Windows Update permanently, corrupt system components, trigger anticheat bans, and leave no way to restore your original system settings.

**Orime is engineered with a modern, safety-first philosophy:**

* **🛡️ 100% Reversible by Design**: Before applying any tweak, Orime captures the exact original state of your services, power plans, and registry keys into an encrypted local **Journal**. When you turn off Gaming Mode (or exit the app), everything rolls back cleanly to how it was.
* **🚀 Native & Ultra-Fast**: Built with modern C# on .NET 10 with a native WinUI 3 Fluent interface. Zero Electron bloat, zero heavy web wrappers.
* **📊 Honest Metrics, Zero Fake Claims**: No ridiculous "+500% FPS" marketing tricks. We display real freed RAM measured via Win32 `GlobalMemoryStatusEx`, real live process counts, and true DNS ping latency benchmarks.

<div align="center">
<img src="assets/tweaks_preview.png" alt="Orime Tweaks Configuration" width="850" />
</div>

---

## ⚙️ 7-Phase Optimization Architecture

When you hit **Activate (Kích Hoạt)**, Orime executes a safe, sequential 7-phase optimization pipeline:

| Phase | Target | What It Does |
| :--- | :--- | :--- |
| **Phase 0** | **App & Background Freezing** | Temporarily pauses heavy background helpers and OEM bloatware (Chrome/Edge updater helpers, Razer Synapse, Discord background workers) so they stop stealing CPU cycles. Tabs and apps remain open. |
| **Phase 1** | **Telemetry & Non-Essential Services** | Safely stops background diagnostics, telemetry logging, and background print spooler tasks during gameplay. |
| **Phase 2** | **RAM Standby Purge & Windows 11 Shell** | Flushes dirty standby memory working sets and defers automatic background maintenance. |
| **Phase 3** | **Smart DNS & Network Latency** | Measures real-time latency to Cloudflare (`1.1.1.1`), Google (`8.8.8.8`), and Quad9, automatically selecting the fastest route. Enables `TCP NoDelay` for reduced packet jitter. |
| **Phase 4** | **Explorer Shell Suspension (Optional)** | Temporarily suspends `explorer.exe` during full-screen games to recover 200–400MB RAM and eliminate DWM composition latency; seamlessly resumes upon game exit. |
| **Phase 5** | **Anti-Malware Quiet Mode** | Temporarily reduces defender background scan priority so heavy file scans don't cause in-game stutter. |
| **Phase 6** | **CPU Core Unparking & 0.5ms Timer** | Unparks all CPU cores, switches to the Ultimate Performance power scheme, and locks the Windows kernel timer resolution to **0.5ms** for ultra-responsive mouse and keyboard input. |

---

## 🎮 3 Tailored Presets

* 🟢 **Safe Mode**: Ideal for everyday gaming, casual sessions, or streaming while browsing. Pauses bloatware helpers and optimizes power without touching browsers, Discord, or core Windows search.
* 🟣 **Normal Mode (Recommended)**: The gold standard for competitive esports and AAA games. Adds standby RAM purging, 0.5ms high-precision timer, and CPU core unparking.
* 🔴 **Extreme Mode**: Maximum horsepower for low-spec rigs or tournament matches where every single frame and millisecond of input latency counts.

---

## 🚀 Quick 1-Click Commands

### ⚡ 1-Click Install / In-Place Update

Open **PowerShell** (Run as Administrator recommended) and execute:

```powershell
irm https://raw.githubusercontent.com/Nahvine/Orime-Release/main/install.ps1 | iex
```

> [!TIP]
> **Already have Orime installed?** Running this command will automatically close any active Orime process, cleanly overwrite outdated binaries, and refresh shortcuts while preserving your saved configuration and activation license.

---

### 🗑️ 1-Click Complete Uninstall

If you ever want to completely remove Orime and all its shortcuts/data from your computer, run:

```powershell
irm https://raw.githubusercontent.com/Nahvine/Orime-Release/main/uninstall.ps1 | iex
```

**What the uninstaller cleans up:**
1. Gracefully terminates any active Orime processes.
2. Removes all desktop and Start Menu shortcuts across all user profiles.
3. Completely deletes installation directories in `Program Files` and `AppData\Programs`.
4. Removes MSIX application packages (if previously installed).
5. Clears cache, temporary setup files, and user config data.

---

### 📦 Portable Version (No Installation Required)

Prefer not to install? Simply download the portable archive:

1. Download **[Orime_v1.0_Portable_x64.zip](https://raw.githubusercontent.com/Nahvine/Orime-Release/main/download/Orime_v1.0_Portable_x64.zip)** (or from [GitHub Releases](https://github.com/Nahvine/Orime-Release/releases)).
2. Extract the archive to any folder of your choice.
3. Run `Orime.exe` directly.

---

## 💻 System Requirements

* **OS**: Windows 10 (version 1903 or higher) or Windows 11 (64-bit)
* **Privileges**: Administrator rights recommended for kernel timer resolution (0.5ms) and Windows service adjustments.
* **Runtime**: .NET 10 Runtime (embedded within self-contained portable package, no extra downloads needed).
