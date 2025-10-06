# BTL_Python
Dự án web quản lý kho hàng nhỏ
# Dự án: Quản lý kho hàng nhỏ

## 1. Mô tả
Hệ thống quản lý kho hàng nhỏ, gồm các chức năng như:
- Quản lý sản phẩm, kho, tồn kho
- Nhập / xuất / điều chỉnh kho
- Quản lý đơn nhập từ nhà cung cấp
- Quản lý đơn bán, giao hàng và thanh toán
- Cảnh báo tồn kho thấp
- Quản lý người dùng (nhân viên) & lịch sử đăng nhập

## 2. Cấu trúc thư mục

| Thư mục | Mô tả |
|--------|-------|
| `sql/` | Chứa các file SQL: tạo bảng, dữ liệu mẫu, trigger, view, procedure |
| `src/` | Mã nguồn backend (model, controller, route, util) |
| `docs/` | Tài liệu: ERD, hướng dẫn thiết kế, cách dùng |
| `tests/` | Test tự động nếu có |
| `.gitignore` | Các file / thư mục không đẩy lên Git (ví dụ: `node_modules/`, `*.pyc`) |
| `README.md` | Giới thiệu dự án + hướng dẫn thiết lập môi trường |

## 3. Cách thiết lập môi trường

1. Clone repo:
   ```bash
   git clone https://github.com/username/QL_KhoHangNho.git
   cd QL_KhoHangNho
