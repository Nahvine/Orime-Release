<div align="center">

# ⚡ Orime Optimizer

**Bộ Công Cụ Tối Ưu Hóa Hiệu Năng Windows & Gaming Chuyên Nghiệp**

[![Nền tảng](https://img.shields.io/badge/Nền%20tảng-Windows%2010%20%7C%2011%20x64-blue?style=for-the-badge&logo=windows)](https://github.com/Nahvine/Orime-Release)
[![Công nghệ](https://img.shields.io/badge/Công%20nghệ-WinUI%203%20%7C%20.NET%2010-purple?style=for-the-badge&logo=dotnet)](https://github.com/Nahvine/Orime-Release)
[![Giao diện](https://img.shields.io/badge/Giao%20diện-Fluent%20Design%20System-0078D4?style=for-the-badge&logo=microsoft)](https://github.com/Nahvine/Orime-Release)

[**🌐 Trang Chủ Chính Thức**](https://orime.osteup.io.vn) • [**📖 English Version**](README.md) • [**📦 Tải Bản Release Mới Nhất**](https://github.com/Nahvine/Orime-Release/releases)

<br/>

<img src="assets/gaming_mode_preview.png" alt="Orime Gaming Mode Giao Diện" width="850" style="border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.15);" />

</div>

---

## 🌟 Giới Thiệu

**Orime** là ứng dụng tối ưu hóa Windows và Gaming hiện đại được xây dựng hoàn toàn bằng **WinUI 3 (Windows App SDK)** và **.NET 10**. Với kiến trúc an toàn 2 tầng và nhật ký giao dịch (Transaction Journal), Orime giúp khai thác tối đa FPS, triệt tiêu độ trễ chuột/bàn phím (Kernel Timer **0.5ms**), tự động thu hồi Gigabyte RAM rác và có khả năng **khôi phục 100% nguyên trạng hệ thống** chỉ với 1 click.

<div align="center">
<img src="assets/tweaks_preview.png" alt="Cấu Hình Tinh Chỉnh Orime" width="850" style="border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.15);" />
</div>

---

## ✨ 7 Phase Tối Ưu Hóa Chuyên Sâu

- **🚀 Phase 0 — Đóng Băng Ứng Dụng Bên Thứ 3 & Trình Duyệt**: Tự động tạm dừng các helper ngầm, trình cập nhật, phần mềm OEM (iCUE, Armoury Crate, Razer Synapse) mà không làm mất tab duyệt web hay ứng dụng đang mở.
- **🛡️ Phase 1 — Tạm Dừng Dịch Vụ Windows Background**: Giảm tải Telemetry, Diagnostic Policy, Print Spooler ngầm với cơ chế chụp trạng thái $T_0$ an toàn.
- **⚡ Phase 2 — Dọn Dẹp Shell Windows 11 & Tác Vụ Bảo Trì**: Đóng băng Widgets, hoãn tác vụ quét đĩa nặng nề và giải phóng bộ nhớ RAM Working Set tức thì.
- **🌐 Phase 3 — Đo Ping Smart DNS & Tối Ưu Mạng QoS**: Tự động đo Ping Cloudflare 1.1.1.1, Google 8.8.8.8, Quad9; chuyển sang DNS thấp nhất và bật `TCP NoDelay` chống nghẽn gói tin.
- **🖥️ Phase 4 — Quản Lý Vòng Đời Windows Explorer**: Tắt hoàn toàn `explorer.exe` khi chơi game để giải phóng 150-400MB RAM & triệt tiêu độ trễ DWM; tự động mở lại khi thoát game.
- **🔒 Phase 5 — Giảm Tải Windows Defender**: Tạm hoãn xác minh SmartScreen và quét virus thời gian thực trong phiên chơi game.
- **⚙️ Phase 6 — Tinh Chỉnh Kernel, CPU Core Parking & Power Plan**: Mở khóa sơ đồ nguồn **Ultimate Performance**, đánh thức 100% nhân CPU (Unpark Cores) và phân bổ lượng tử CPU **3:1 Quantum Boost** cho game.

---

## 🎯 3 Chế Độ Tối Ưu Được Thiết Kế Khoa Học

| Chế Độ | Đối Tượng Sử Dụng | Tính Năng Nổi Bật |
| :--- | :--- | :--- |
| **🟢 Safe Mode** | Người dùng phổ thông & làm việc | Chỉ dừng helper/updater, dịch vụ Low Risk, giữ nguyên chat (Discord/Zalo/Tele) và Windows Hello/Search. Bật gói nguồn Ultimate Performance. |
| **🟣 Normal Mode** | Game thủ Esport & AAA *(Khuyên Dùng)* | Đóng băng ứng dụng thông minh, Dọn RAM Standby, Tắt Explorer khi chơi game, Timer 0.5ms, Mở khóa CPU Core Parking. |
| **🔴 Extreme Mode** | Thi đấu chuyên nghiệp & Máy cấu hình cao | Mở khóa toàn bộ 100% 7 Phases, can thiệp dịch vụ mạng nhạy cảm và tạm hoãn Windows Defender. |

---

## ⚡ Cài Đặt 1-Click Siêu Tốc (Web Installer)

Mở **PowerShell** trên máy tính của bạn và dán lệnh sau:

```powershell
powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/Nahvine/Orime-Release/main/install.ps1 | iex"
```

Hoặc tải bản **Portable Chạy Ngay (Không Cần Cài Đặt)** trực tiếp tại [GitHub Releases](https://github.com/Nahvine/Orime-Release/releases).

---

## 📋 Yêu Cầu Hệ Thống

- **Hệ Điều Hành**: Windows 10 (Phiên bản 1903 trở lên) hoặc Windows 11 (64-bit x64)
- **Kiến Trúc Phần Cứng**: x64 (Intel / AMD)
- **Dung Lượng Trống**: ~200 MB

---

## 📜 Bản Quyền & Giấy Phép

Bản quyền thuộc về © 2026 **Orime Optimizer**.  
Hệ Thống Phân Phối & Kích Hoạt Bản Quyền: [https://orime.osteup.io.vn](https://orime.osteup.io.vn)
