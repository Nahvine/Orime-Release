<div align="center">

# Orime

Điều phối luồng và can thiệp tầng kernel cho Windows khi chơi game.

<br/>

[ **🇬🇧 Switch to English Version** ](README_EN.md)

</div>

---

## ⚡ Cài đặt nhanh

Mở **PowerShell** hoặc **CMD** và dán dòng lệnh sau:

```powershell
powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/Nahvine/Orime-Release/main/install.ps1 | iex"
```

*Trình cài đặt tự động tải bản mới nhất, cấu hình vào hệ thống và tạo shortcut ngoài Desktop.*

---

## 📦 Bản Portable (Tải trực tiếp)

Dành cho người dùng muốn mở trực tiếp không qua script:
- Tải file nén tại [GitHub Releases](https://github.com/Nahvine/Orime-Release/releases/latest).
- Giải nén và chạy file `Orime.exe`.

---

## 🔑 Mã kích hoạt (License Key)

| Gói | Thời hạn | Nhận mã |
| :--- | :---: | :--- |
| **🎁 Trải nghiệm** | **30 tiếng** | [Lấy Key Free](https://link.osteup.io.vn/01d69e65) |
| **⭐ Chính thức** | **Dài hạn / Vĩnh viễn** | [Mua Key VIP](https://orime.osteup.io.vn/buy-key.html) |

---

## ⚙️ Cơ chế hoạt động

- **Đồng hồ hệ thống:** Kéo chu kỳ ngắt kernel xuống 0.5ms để thu hẹp độ trễ nhận diện tín hiệu từ chuột và bàn phím.
- **Phân bổ tài nguyên:** Ưu tiên luồng render cho tiến trình chính, nén bộ nhớ đệm và tạm dừng các dịch vụ nền không cần thiết.
- **Định tuyến mạng:** Đo độ trễ thực tế qua các cổng DNS độc lập nhằm chọn tuyến phân giải ngắn nhất.
- **Hoàn nguyên nguyên trạng:** Tạo snapshot toàn bộ trạng thái trước khi can thiệp và tự động phục hồi 100% khi kết thúc phiên chơi game.

---

## 📄 Bản quyền

Phần mềm thuộc quyền sở hữu của Osteup / Nahvine. Nghiêm cấm dịch ngược hoặc phân phối trái phép. Xem chi tiết tại [LICENSE](LICENSE).
