<div align="center">

# ⚡ Orime Optimizer

**The Next-Gen, High-Performance Native Windows & Game Optimization Suite**

[![Platform](https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011%20x64-blue?style=for-the-badge&logo=windows)](https://github.com/Nahvine/Orime-Release)
[![Framework](https://img.shields.io/badge/Framework-WinUI%203%20%7C%20.NET%2010-purple?style=for-the-badge&logo=dotnet)](https://github.com/Nahvine/Orime-Release)
[![Design](https://img.shields.io/badge/UI-Fluent%20Design%20System-0078D4?style=for-the-badge&logo=microsoft)](https://github.com/Nahvine/Orime-Release)
[![License](https://img.shields.io/badge/License-Proprietary-red?style=for-the-badge)](https://github.com/Nahvine/Orime-Release)

[**🌐 Official Website**](https://orime.osteup.io.vn) • [**📖 Tiếng Việt**](README_VIETNAMESE.md) • [**📦 Download Latest Release**](https://github.com/Nahvine/Orime-Release/releases)

<br/>

<img src="assets/gaming_mode_preview.png" alt="Orime Gaming Mode" width="850" style="border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.15);" />

</div>

---

## 🌟 Overview

**Orime** is a modern, enterprise-grade game optimization engine built natively with **WinUI 3 (Windows App SDK)** and **.NET 10**. Designed with a non-destructive, transaction-safe architecture, Orime unlocks maximum FPS, eliminates stutter, reduces system DPC latency to **0.5ms**, and recovers gigabytes of standby RAM—all reversibly with 1-click restore.

<div align="center">
<img src="assets/tweaks_preview.png" alt="Orime Tweaks Configuration" width="850" style="border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.15);" />
</div>

---

## ✨ Key Features & 7-Phase Engine

Orime orchestrates system tuning through **7 dedicated optimization phases**:

- **🚀 Phase 0 — Smart Third-Party App & Browser Freeze**: Automatically suspends background helpers, browser updaters, OEM bloatware (iCUE, Armoury Crate, Synapse) without losing your tabs.
- **🛡️ Phase 1 — Non-Destructive Windows Services Debloat**: Toggles telemetry, diagnostic tracking, and background services with pre-capture state snapshots.
- **⚡ Phase 2 — Windows 11 Shell & Maintenance Purge**: Halts Widgets, OneDrive sync, GameDVR, and triggers real-time Working Set RAM cleanup.
- **🌐 Phase 3 — Smart DNS Benchmark & Network QoS**: Benchmarks Cloudflare, Google, and Quad9 in real-time, applies lowest-latency DNS with `TCP NoDelay` and `NetworkThrottlingIndex` disabled.
- **🖥️ Phase 4 — Explorer Shell Lifecycle**: Closes `explorer.exe` during gameplay to free 150-400MB RAM & eliminate DWM frame latency; seamlessly relaunches on exit.
- **🔒 Phase 5 — Security & Antimalware Tuning**: Temporarily suppresses SmartScreen verification and real-time scanning overhead during gaming sessions.
- **⚙️ Phase 6 — Kernel Scheduler & Hardware Power Scheme**: Activates the hidden **Ultimate Performance** power plan, unparks 100% CPU cores, and forces **3:1 Win32 Priority Quantum Boost**.

---

## 🎯 3 Curated Optimization Profiles

| Preset | Target User | What's Included |
| :--- | :--- | :--- |
| **🟢 Safe Mode** | Everyday users & casual gamers | Helper apps only, low-risk services, Ultimate Power plan. Preserves full browsers, chat (Discord/Zalo/Telegram), and Windows Search/Hello. |
| **🟣 Normal Mode** | Esport & AAA Gamers (Recommended) | Full app freeze with launcher smart-checks, RAM memory purge, Explorer lifecycle, 0.5ms kernel timer, and CPU core unparking. |
| **🔴 Extreme Mode** | Competitive & Tournament Play | 100% maximum power unlocking, sensitive network service suspension, and full real-time antimalware pause. |

---

## ⚡ 1-Click Fast Web Installer

Open **PowerShell** (as Administrator or normal user) and run:

```powershell
powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/Nahvine/Orime-Release/main/install.ps1 | iex"
```

Or download the **Standalone Portable Edition (Zero Installation)** directly from [GitHub Releases](https://github.com/Nahvine/Orime-Release/releases).

---

## 📋 System Requirements

- **Operating System**: Windows 10 (Version 1903+) or Windows 11 (64-bit x64)
- **Runtime**: Windows App SDK 1.6+ (Embedded self-contained in Portable edition)
- **Architecture**: x64 (AMD64 / Intel 64)

---

## 📜 License & Copyright

Copyright © 2026 **Orime Optimizer**. All rights reserved.  
Official Gateway & License Management: [https://orime.osteup.io.vn](https://orime.osteup.io.vn)
