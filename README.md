<div align="center">

# Orime Optimizer

**A clean, reversible Windows game optimizer built with WinUI 3 and .NET 10.**

[![Platform](https://img.shields.io/badge/Windows-10%20%7C%2011%20(64--bit)-0078D4?style=flat-square&logo=windows)](https://github.com/Nahvine/Orime-Release)
[![Framework](https://img.shields.io/badge/WinUI%203-.NET%2010-512BD4?style=flat-square&logo=dotnet)](https://github.com/Nahvine/Orime-Release)
[![License](https://img.shields.io/badge/License-Proprietary-gray?style=flat-square)](https://github.com/Nahvine/Orime-Release)

[**Website**](https://orime.osteup.io.vn) • [**Bản Tiếng Việt**](README_VIETNAMESE.md) • [**Download Releases**](https://github.com/Nahvine/Orime-Release/releases)

<br/>

<img src="assets/gaming_mode_preview.png" alt="Orime Gaming Mode" width="850" />

</div>

---

## Why Orime?

Most Windows "tweakers" and "game optimizers" are just random PowerShell scripts or registry hacks that permanently break Windows Update, delete system components, or trigger anticheat flags.

**Orime is built differently:**

1. **100% Reversible by Design**: Before applying any tweak, Orime captures the exact original state of your services, power plans, and registry keys into a local journal. When you turn off Gaming Mode (or exit), everything rolls back cleanly to how it was.
2. **Native & Fast**: Written in modern C# on .NET 10 with a native WinUI 3 Fluent interface. No Electron, no bloated web wrappers.
3. **No Bullshit / Honest Metrics**: No fake "boosted 500% FPS" claims. It shows actual freed RAM from `GlobalMemoryStatusEx`, real live process counts, and real DNS latency benchmarks.

<div align="center">
<img src="assets/tweaks_preview.png" alt="Orime Tweaks Configuration" width="850" />
</div>

---

## What Happens When You Hit "Kích Hoạt" (Activate)?

Orime runs through up to 7 structured phases:

* **Phase 0 — App & Browser Suspension**: Temporarily freezes heavy background helpers and OEM bloatware (Chrome/Edge updater helpers, Razer Synapse, Discord helpers) so they stop eating CPU cycles while you play. Your open tabs remain intact.
* **Phase 1 — Non-Essential Services**: Pauses background telemetry, diagnostic tracing, and spooler tasks.
* **Phase 2 — Windows 11 Shell Tuning**: Cleans up standby RAM (working sets) and pauses background indexing.
* **Phase 3 — Smart DNS Routing & Latency**: Tests ping against top DNS providers (Cloudflare `1.1.1.1`, Google `8.8.8.8`, Quad9) and applies the fastest one. If your DNS is already optimal, it leaves it alone. Enables `TCP NoDelay`.
* **Phase 4 — Explorer Shell Lifecycle (Optional)**: Can temporarily halt `explorer.exe` to free up 200–400MB RAM and eliminate DWM composition latency during full-screen games, then automatically brings it back.
* **Phase 5 — Antimalware Quiet Mode**: Lowers defender background scan priority during active game sessions.
* **Phase 6 — Power & CPU Quantum**: Unparks CPU cores, activates the Ultimate Performance power scheme, and locks timer resolution to 0.5ms for lowest input lag.

---

## 3 Simple Modes

* **Safe Mode**: Great for casual gaming and streaming. Pauses background updaters and enables power tweaks without touching web browsers, Discord, or system search.
* **Normal Mode (Recommended)**: The sweet spot for esports and AAA titles. Adds RAM purging, smart app freezing, 0.5ms timer, and CPU core unparking.
* **Extreme Mode**: For tournament matches or low-spec systems where every frame and millisecond matters.

---

## Quick Install

Open **PowerShell** and run:

```powershell
irm https://raw.githubusercontent.com/Nahvine/Orime-Release/main/install.ps1 | iex
```

Or grab the standalone zip from [GitHub Releases](https://github.com/Nahvine/Orime-Release/releases) (unzip and double-click `Orime.exe`).

---

## System Requirements

* Windows 10 (version 1903+) or Windows 11 (64-bit)
* Administrator privileges recommended for service and kernel timer adjustments
