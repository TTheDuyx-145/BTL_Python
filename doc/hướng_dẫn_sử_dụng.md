# Hướng dẫn sử dụng hệ thống Quản lý kho hàng nhỏ

## 1. Giới thiệu
Hệ thống hỗ trợ quản lý kho hàng, nhập – xuất sản phẩm, theo dõi đơn hàng và cảnh báo tồn kho.

### Đối tượng sử dụng:
- **Admin:** Quản trị hệ thống, quản lý nhân viên, cấu hình kho.
- **Nhân viên kho:** Thực hiện nhập, xuất, kiểm kê hàng.
- **Kế toán:** Theo dõi đơn hàng, hóa đơn, báo cáo tồn kho.

---

## 2. Cài đặt ban đầu

### Bước 1: Tạo cơ sở dữ liệu
1. Mở MySQL Workbench hoặc phpMyAdmin.  
2. Chạy lần lượt các file trong thư mục `sql/`:
3. Kiểm tra các bảng đã tạo thành công.

### Bước 2: Cấu hình ứng dụng
- Mở file `.env` hoặc file cấu hình trong `src/`  
(ví dụ `config.py` hoặc `config.js`)
- Sửa thông tin kết nối:

### Bước 3: Khởi động ứng dụng
Nếu backend là **Python Flask**:
```bash
pip install -r requirements.txt
python app.py
