<div align=center>

# Orime Optimizer

**Ứng dụng tối ưu Windows và giảm độ trễ khi chơi game, viết bằng WinUI 3 & .NET 10.**

[![Nền tảng](https://img.shields.io/badge/Windows-10%20%7C%2011%20(64--bit)-0078D4?style=flat-square&logo=windows)](https://github.com/Nahvine/Orime-Release)
[![Công nghệ](https://img.shields.io/badge/WinUI%203-.NET%2010-512BD4?style=flat-square&logo=dotnet)](https://github.com/Nahvine/Orime-Release)
[![Bản quyền](https://img.shields.io/badge/Bản%20quyền-Proprietary-gray?style=flat-square)](https://github.com/Nahvine/Orime-Release)

[**Trang Chủ**](https://orime.osteup.io.vn) • [**English README**](README.md) • [**Tải Bản Mới Nhất**](https://github.com/Nahvine/Orime-Release/releases)

<br/>

<img src=assets/gaming_mode_preview.png alt=Giao diện Orime Gaming Mode width=850 />

</div>

---

## Vì sao nên dùng Orime?

Nhiều công cụ tối ưu Windows trên mạng thực chất chỉ là file .bat hoặc file .reg gom nhặt, chỉnh sửa vĩnh viễn vào hệ thống khiến Windows Update bị lỗi, hỏng dịch vụ nền hoặc gây xanh màn hình (BSOD).

**Orime được thiết kế theo hướng an toàn và tôn trọng hệ thống:**

1. **Khôi phục nguyên trạng 100% (Reversible)**: Trước khi tinh chỉnh bất kỳ cài đặt nào, Orime đều chụp lại trạng thái gốc của máy vào nhật ký (Journal). Khi bạn tắt Gaming Mode hoặc đóng ứng dụng, mọi thứ sẽ tự động hoàn trả về đúng như ban đầu.
2. **Nhẹ và Native**: Viết bằng C# (.NET 10) với giao diện Fluent của WinUI 3, không dùng Electron hay bọc web nặng nề.
3. **Thông số trung thực, không vẽ số liệu**: Không quảng cáo tăng 500% FPS ảo. Lượng RAM giải phóng được đo từ API hệ thống thực tế (GlobalMemoryStatusEx), đo ping DNS trực tiếp và hiển thị rõ ràng từng dịch vụ được xử lý.

<div align=center>
<img src=assets/tweaks_preview.png alt=Giao diện cấu hình tinh chỉnh Orime width=850 />
</div>

---

## 7 Phase Tinh Chỉnh Khi Bật Gaming Mode

Khi bạn nhấn **KÍCH HOẠT**, Orime thực hiện tối ưu theo từng tầng rõ ràng:

* **Phase 0 — Đóng băng tiến trình ngầm & app phụ**: Tạm dừng các helper ngầm của trình duyệt (Chrome/Edge updater), phần mềm hãng (Razer Synapse, iCUE, Armoury Crate) để nhường toàn bộ CPU cho game. Không làm mất tab web hay đóng app đang mở.
* **Phase 1 — Dịch vụ Windows không cần thiết**: Tạm dừng các dịch vụ theo dõi dữ liệu (Telemetry), Diagnostic Policy và dịch vụ in ấn ngầm.
* **Phase 2 — Dọn dẹp RAM Standby & Windows 11 Shell**: Thu hồi vùng nhớ đệm rác và hoãn các tác vụ tự động bảo trì của Windows.
* **Phase 3 — Tự động chọn DNS nhanh nhất (Smart DNS)**: Đo ping đến Cloudflare 1.1.1.1, Google 8.8.8.8, Quad9 và chuyển sang máy chủ có độ trễ thấp nhất. Nếu máy bạn đã tự chỉnh DNS xịn từ trước, app sẽ giữ nguyên. Bật TCP NoDelay để giảm giật lag mạng.
* **Phase 4 — Tạm ẩn Windows Explorer (Tùy chọn)**: Tạm dừng explorer.exe trong lúc chơi game toàn màn hình để tiết kiệm 200–400MB RAM và giảm độ trễ dựng khung hình của DWM; tự động mở lại ngay khi thoát game.
* **Phase 5 — Giảm tải quét nền**: Hạ mức ưu tiên của trình quét virus khi bạn đang trong trận game.
* **Phase 6 — Mở khóa phần cứng & Kernel Timer**: Mở khóa gói nguồn Ultimate Performance, đánh thức 100% nhân CPU (Unpark CPU Cores) và khóa độ phân giải đồng hồ hệ thống ở mức **0.5ms** để giảm tối đa độ trễ chuột/bàn phím.

---

## 3 Chế Độ Lựa Chọn Nhanh

* **🟢 Safe Mode**: Dành cho người dùng phổ thông, vừa chơi game vừa lướt web hoặc gọi Discord/Zalo. Chỉ dừng các helper ngầm và bật gói nguồn tối ưu mà không đụng tới ứng dụng chính.
* **🟣 Normal Mode (Khuyên Dùng)**: Cân bằng tốt nhất cho game thủ Esport và game AAA. Bổ sung dọn RAM, timer 0.5ms và mở khóa toàn bộ nhân CPU.
* **🔴 Extreme Mode**: Dành cho máy cấu hình yếu hoặc các trận đấu thi đấu cần vắt kiệt từng khung hình và mili-giây độ trễ.

---

## Lệnh Cài Đặt & Gỡ Bỏ 1-Click

### ⚡ Cài Đặt Mới / Cập Nhật Đè Lên Bản Cũ
Mở **PowerShell** và dán lệnh:

`powershell
irm https://raw.githubusercontent.com/Nahvine/Orime-Release/main/install.ps1 | iex
`
*(Nếu máy đã cài sẵn bản cũ, lệnh trên sẽ tự động đóng tiến trình cũ và ghi đè cập nhật sạch sẽ lên phiên bản mới nhất mà vẫn bảo lưu bản quyền/cấu hình của bạn).*

### 🗑️ Gỡ Bỏ Hoàn Toàn (Uninstall)
Mở **PowerShell** và dán lệnh sau để dọn dẹp toàn bộ file, shortcut và cache của Orime:

`powershell
irm https://raw.githubusercontent.com/Nahvine/Orime-Release/main/uninstall.ps1 | iex
`

Hoặc tải bản **Portable (chạy ngay không cần cài đặt)** từ [GitHub Releases](https://github.com/Nahvine/Orime-Release/releases), giải nén và mở file Orime.exe.

---

## Yêu Cầu Hệ Thống

* Windows 10 (bản 1903 trở lên) hoặc Windows 11 (64-bit)
* Khuyên dùng quyền Administrator để app có thể điều chỉnh timer kernel và dịch vụ hệ thống