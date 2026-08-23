<div align="center">

# ⚡ Orime Optimizer

**Ứng dụng tối ưu Windows và giảm độ trễ khi chơi game, viết bằng WinUI 3 & .NET 10.**

[![Nền tảng](https://img.shields.io/badge/Windows-10%20%7C%2011%20(64--bit)-0078D4?style=flat-square&logo=windows)](https://github.com/Nahvine/Orime-Release)
[![Công nghệ](https://img.shields.io/badge/WinUI%203-.NET%2010-512BD4?style=flat-square&logo=dotnet)](https://github.com/Nahvine/Orime-Release)
[![Bản quyền](https://img.shields.io/badge/Bản%20quyền-Proprietary-gray?style=flat-square)](https://github.com/Nahvine/Orime-Release)

[**Trang Chủ**](https://orime.osteup.io.vn) • [**English README**](README.md) • [**Tải Bản Mới Nhất**](https://github.com/Nahvine/Orime-Release/releases)

<br/>

<img src="assets/gaming_mode_preview.png" alt="Giao diện Orime Gaming Mode" width="850" />

</div>

---

## 🎯 Vì sao nên chọn Orime?

Phần lớn các phần mềm "tối ưu hóa game" trên mạng thực chất chỉ là tập hợp các file `.bat` hoặc `.reg` chắp vá. Chúng thường can thiệp thô bạo vào registry khiến Windows Update bị lỗi, tê liệt dịch vụ hệ thống, kích hoạt cảnh báo Anticheat và không thể khôi phục lại như cũ.

**Orime được phát triển với tiêu chuẩn hiện đại, an toàn và minh bạch:**

* **🛡️ Khôi phục nguyên trạng 100% (Reversible Journal)**: Trước khi kích hoạt bất kỳ tinh chỉnh nào, Orime sẽ tự động chụp lại trạng thái gốc của hệ thống vào nhật ký (Journal). Khi bạn tắt Gaming Mode hoặc đóng app, hệ thống sẽ được hoàn trả sạch sẽ về đúng trạng thái ban đầu.
* **🚀 Nhẹ, Mượt & Native**: Viết bằng C# (.NET 10) với giao diện WinUI 3 Fluent thuần túy của Microsoft. Không dùng Electron, không bọc web tốn tài nguyên.
* **📊 Số liệu thật, không vẽ số liệu ảo**: Không quảng cáo "tăng 500% FPS" vô căn cứ. Lượng RAM giải phóng được đo trực tiếp từ API Win32 `GlobalMemoryStatusEx`, đo độ trễ DNS thời gian thực và báo cáo chi tiết từng tiến trình được xử lý.

<div align="center">
<img src="assets/tweaks_preview.png" alt="Giao diện cấu hình tinh chỉnh Orime" width="850" />
</div>

---

## ⚙️ Cơ Chế Tinh Chỉnh 7 Phase Khi Bật Gaming Mode

Khi bạn nhấn **KÍCH HOẠT**, Orime thực hiện quy trình tối ưu hóa qua 7 giai đoạn tuần tự và an toàn:

| Phase | Đối tượng | Mô tả chi tiết |
| :--- | :--- | :--- |
| **Phase 0** | **Đóng băng tiến trình ngầm & app phụ** | Tạm dừng các tác vụ phụ của trình duyệt (Chrome/Edge updater helpers), phần mềm ngoại vi (Razer Synapse, Discord helpers...) để nhường CPU cho game mà không làm tắt ứng dụng hay mất tab đang mở. |
| **Phase 1** | **Dịch vụ Windows & Telemetry** | Tạm dừng các dịch vụ chẩn đoán, thu thập dữ liệu ngầm và tác vụ in ấn không cần thiết trong lúc chơi game. |
| **Phase 2** | **Dọn RAM Standby & Shell Windows 11** | Giải phóng vùng nhớ đệm (Standby list) và tạm hoãn các tác vụ tự động bảo trì ngầm của Windows. |
| **Phase 3** | **Tự chọn Smart DNS & Giảm Ping** | Tự động đo ping đến Cloudflare (`1.1.1.1`), Google (`8.8.8.8`), Quad9 và áp dụng DNS có tốc độ nhanh nhất. Kích hoạt `TCP NoDelay` giúp giảm giật lag đường truyền. |
| **Phase 4** | **Tạm ẩn Explorer (Tùy chọn)** | Cho phép tạm dừng `explorer.exe` khi chơi game toàn màn hình để tiết kiệm 200–400MB RAM và giảm độ trễ render của DWM; tự động khôi phục ngay sau khi đóng game. |
| **Phase 5** | **Hạ tải quét diệt virus** | Tạm thời hạ mức ưu tiên của Windows Defender để hạn chế tình trạng đơ giật do quét ổ đĩa ngầm khi đang combat. |
| **Phase 6** | **Mở khóa CPU & Kernel Timer 0.5ms** | Đánh thức 100% nhân CPU (Unpark Cores), kích hoạt gói nguồn Ultimate Performance và khóa độ trễ đồng hồ hệ thống ở mức **0.5ms** cho phản hồi chuột/phím tức thì. |

---

## 🎮 3 Chế Độ Cấu Hình Sẵn

* 🟢 **Safe Mode**: Phù hợp cho nhu cầu chơi game giải trí thông thường, vừa chơi vừa lướt web, nghe nhạc hoặc gọi Discord. Chỉ dừng các tác vụ updater rác và kích hoạt gói nguồn tối ưu.
* 🟣 **Normal Mode (Khuyên dùng)**: Lựa chọn chuẩn nhất cho game thủ Esport và game AAA. Bổ sung tính năng xả RAM đệm, mở khóa nhân CPU và khóa timer 0.5ms.
* 🔴 **Extreme Mode**: Vắt kiệt tối đa sức mạnh phần cứng dành cho máy cấu hình yếu hoặc các trận thi đấu xếp hạng đòi hỏi độ trễ thấp nhất.

---

## 🚀 Lệnh Cài Đặt & Gỡ Bỏ 1-Click

### ⚡ 1-Click Cài Đặt / Cập Nhật Đè Lên Bản Cũ

Mở **PowerShell** (khuyên dùng quyền Run as Administrator) và dán lệnh:

```powershell
irm https://raw.githubusercontent.com/Nahvine/Orime-Release/main/install.ps1 | iex
```

> [!TIP]
> **Máy đã có sẵn phiên bản cũ?** Chạy lệnh trên sẽ tự động đóng tiến trình Orime cũ, làm sạch file binary lỗi thời và ghi đè phiên bản mới nhất mà vẫn bảo lưu nguyên vẹn cài đặt và bản quyền (license) đã kích hoạt của bạn.

---

### 🗑️ 1-Click Gỡ Bỏ Hoàn Toàn (Uninstall)

Khi muốn gỡ sạch Orime và toàn bộ dữ liệu/shortcut khỏi máy tính, chỉ cần chạy lệnh sau trong **PowerShell**:

```powershell
irm https://raw.githubusercontent.com/Nahvine/Orime-Release/main/uninstall.ps1 | iex
```

**Các tác vụ script tự động thực hiện:**
1. Dừng ngay toàn bộ tiến trình Orime đang chạy.
2. Xóa sạch các shortcut ngoài Desktop (kể cả OneDrive/Public Desktop) và Start Menu.
3. Xóa thư mục cài đặt trong `Program Files` và `AppData\Programs`.
4. Gỡ bỏ gói MSIX nếu trước đó từng cài qua gói đóng gói.
5. Dọn dẹp triệt để file rác tạm thời trong `%TEMP%` và dữ liệu người dùng `%LOCALAPPDATA%\Orime`.

---

### 📦 Bản Portable (Chạy Ngay Không Cần Cài Đặt)

Nếu bạn không muốn cài vào hệ thống:

1. Tải gói nén **[Orime_v1.0_Portable_x64.zip](https://raw.githubusercontent.com/Nahvine/Orime-Release/main/download/Orime_v1.0_Portable_x64.zip)** (hoặc tại [GitHub Releases](https://github.com/Nahvine/Orime-Release/releases)).
2. Giải nén vào bất kỳ thư mục nào trên máy.
3. Mở file `Orime.exe` để trải nghiệm ngay.

---

## 💻 Yêu Cầu Hệ Thống

* **Hệ điều hành**: Windows 10 (bản 1903 trở lên) hoặc Windows 11 (64-bit).
* **Quyền hạn**: Khuyên dùng quyền Administrator để app có thể điều chỉnh timer kernel (0.5ms) và tối ưu dịch vụ Windows.
* **Runtime**: Đã tích hợp sẵn .NET 10 Runtime bên trong, không cần cài thêm bất kỳ phần mềm phụ trợ nào.
