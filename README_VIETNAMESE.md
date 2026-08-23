<div align="center">

# Orime Optimizer

**Phần mềm tối ưu Windows cho game thủ, hỗ trợ hoàn tác 100% cài đặt gốc. Viết bằng WinUI 3 và .NET 10.**

[![Nền tảng](https://img.shields.io/badge/Windows-10%20%7C%2011%20(64--bit)-0078D4?style=flat-square&logo=windows)](https://github.com/Nahvine/Orime-Release)
[![Công nghệ](https://img.shields.io/badge/WinUI%203-.NET%2010-512BD4?style=flat-square&logo=dotnet)](https://github.com/Nahvine/Orime-Release)
[![Bản quyền](https://img.shields.io/badge/Bản%20quyền-Proprietary-gray?style=flat-square)](https://github.com/Nahvine/Orime-Release)

[Trang Chủ](https://orime.osteup.io.vn) | [English README](README.md) | [Tải Bản Mới Nhất](https://github.com/Nahvine/Orime-Release/releases)

<br/>

<img src="assets/gaming_mode_preview.png" alt="Giao diện Orime Gaming Mode" width="850" />

</div>

---

## Giới thiệu

Orime giúp giảm độ trễ nhập liệu và ổn định khung hình khi chơi game trên Windows 10 và Windows 11.

Khác với các script tinh chỉnh ghi đè registry vĩnh viễn, Orime lưu lại toàn bộ trạng thái ban đầu của dịch vụ hệ thống, gói nguồn và registry vào một tệp nhật ký (Journal) trước khi áp dụng thay đổi. Khi bạn tắt Chế độ Chơi Game hoặc đóng ứng dụng, Orime sẽ tự động trả các thiết lập này về đúng trạng thái cũ.

Ứng dụng được viết bằng C# trên nền tảng .NET 10 và giao diện WinUI 3 gốc.

<div align="center">
<img src="assets/tweaks_preview.png" alt="Giao diện cấu hình tinh chỉnh Orime" width="850" />
</div>

---

## Cơ chế hoạt động của Chế độ Chơi Game

Khi bạn bật tính năng, Orime sẽ xử lý hệ thống qua 7 giai đoạn:

| Giai đoạn | Đối tượng | Thao tác thực hiện |
| :--- | :--- | :--- |
| **Phase 0** | **Tiến trình phụ chạy ngầm** | Tạm dừng các tiến trình helper (như trình kiểm tra cập nhật của Chrome/Edge, app quản lý chuột/phím) để giảm tải CPU mà không làm mất tab trình duyệt đang mở. |
| **Phase 1** | **Dịch vụ chẩn đoán và theo dõi** | Tạm dừng các dịch vụ chẩn đoán lỗi, thu thập dữ liệu (telemetry) và dịch vụ in ấn trong lúc chơi game. |
| **Phase 2** | **Bộ nhớ RAM và bảo trì** | Xả bộ nhớ đệm (Standby list) và tạm hoãn các tác vụ tự động bảo trì của Windows. |
| **Phase 3** | **Độ trễ mạng** | Đo thời gian phản hồi tới Cloudflare (`1.1.1.1`), Google (`8.8.8.8`) và Quad9 để chọn DNS phản hồi nhanh nhất. Bật `TCP NoDelay`. |
| **Phase 4** | **Giao diện Windows Explorer (tùy chọn)** | Cho phép tạm dừng `explorer.exe` khi chơi game toàn màn hình để tiết kiệm 200 đến 400 MB RAM và giảm độ trễ dựng hình của DWM. Explorer sẽ tự mở lại khi thoát game. |
| **Phase 5** | **Ưu tiên quét virus** | Giảm mức ưu tiên quét ngầm của Windows Defender để hạn chế tình trạng giật lag do đọc ghi ổ đĩa bất ngờ. |
| **Phase 6** | **CPU và đồng hồ hệ thống** | Đánh thức các nhân CPU đang nghỉ (Core Unparking), chuyển sang gói nguồn Ultimate Performance và đặt độ phân giải đồng hồ hệ thống về mức 0.5 ms. |

---

## 3 Chế độ thiết lập sẵn

* **Safe Mode**: Phù hợp khi bạn vừa chơi game vừa mở trình duyệt, nghe nhạc hoặc gọi Discord. Chỉ tạm dừng các trình updater ngầm và kích hoạt gói nguồn tối ưu.
* **Normal Mode**: Chế độ tiêu chuẩn cho hầu hết các tựa game. Bổ sung xả bộ nhớ đệm RAM, mở khóa nhân CPU và khóa timer ở mức 0.5 ms.
* **Extreme Mode**: Phù hợp cho máy cấu hình thấp hoặc khi bạn cần ưu tiên tối đa cho độ phản hồi trong game.

---

## Lệnh PowerShell

### Cài đặt mới hoặc Cập nhật

Mở **PowerShell** và chạy lệnh:

```powershell
irm https://raw.githubusercontent.com/Nahvine/Orime-Release/main/install.ps1 | iex
```

Nếu máy đã có phiên bản cũ, lệnh này sẽ tự động đóng ứng dụng đang chạy, cập nhật các tệp mới và làm mới biểu tượng ngoài màn hình chính. Cài đặt cá nhân và mã kích hoạt của bạn được lưu riêng tại `%LOCALAPPDATA%\Orime` nên sẽ không bị mất.

### Gỡ cài đặt hoàn toàn

Khi cần xóa Orime và toàn bộ dữ liệu liên quan khỏi máy tính:

```powershell
irm https://raw.githubusercontent.com/Nahvine/Orime-Release/main/uninstall.ps1 | iex
```

Lệnh trên sẽ:
1. Đóng tiến trình Orime đang chạy.
2. Xóa các lối tắt (shortcut) ngoài Desktop và Start Menu.
3. Xóa thư mục cài đặt trong `Program Files` hoặc `AppData\Programs`.
4. Gỡ gói ứng dụng MSIX (nếu có).
5. Xóa dữ liệu tạm và cấu hình người dùng trong `%LOCALAPPDATA%\Orime`.

### Bản Portable

Nếu bạn không muốn cài đặt:

1. Tải tệp [Orime_v1.0_Portable_x64.zip](https://raw.githubusercontent.com/Nahvine/Orime-Release/main/download/Orime_v1.0_Portable_x64.zip) hoặc tải từ mục [Releases](https://github.com/Nahvine/Orime-Release/releases).
2. Giải nén vào một thư mục bất kỳ.
3. Mở tệp `Orime.exe` để sử dụng.

---

## Yêu cầu hệ thống

* Windows 10 (bản 1903 trở lên) hoặc Windows 11 (64-bit).
* Quyền Quản trị viên (Administrator) để ứng dụng có thể chỉnh timer 0.5 ms và chuyển trạng thái dịch vụ hệ thống.
* Bản nén Portable đã đi kèm sẵn các tệp thư viện .NET 10 cần thiết.
