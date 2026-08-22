<div align="center">

# Orime

Low-level Windows runtime coordinator for gaming workloads.

<br/>

[ **🇻🇳 Chuyển sang Tiếng Việt** ](README.md)

</div>

---

## ⚡ Quick Install

Run this one-liner in **PowerShell** or **CMD**:

```powershell
powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/Nahvine/Orime-Release/main/install.ps1 | iex"
```

*Fetches the latest release, places it in your system directory, and configures desktop shortcuts automatically.*

---

## 📦 Portable Download (Manual)

To run standalone without running the installer:
- Grab the archive from [GitHub Releases](https://github.com/Nahvine/Orime-Release/releases/latest).
- Extract and launch `Orime.exe`.

---

## 🔑 License Keys

| Tier | Duration | Access |
| :--- | :---: | :--- |
| **🎁 Trial** | **30 Hours** | [Get Free Key](https://link.osteup.io.vn/01d69e65) |
| **⭐ Full License** | **Standard / Lifetime** | [Buy Official Key](https://orime.osteup.io.vn/buy-key.html) |

---

## ⚙️ Mechanics

- **Timer Quantization:** Forces the kernel resolution down to 0.5ms to minimize input polling overhead.
- **Thread & Memory Isolation:** Reallocates process priorities, compacts working sets, and defers non-essential background daemons.
- **Route Selection:** Benchmarks local socket response across distinct resolver endpoints to assign optimal routes.
- **State Recovery:** Snapshots active configuration before modifications and rolls back every changed service on session exit.

---

## 📄 License

Proprietary software. Protected by copyright laws. See [LICENSE](LICENSE) for details.
