# Thiết kế kiến trúc hệ thống – Quản lý kho hàng nhỏ

## 1. Tổng quan
Hệ thống **Quản lý kho hàng nhỏ** giúp doanh nghiệp vừa và nhỏ quản lý toàn bộ hoạt động kho hàng:
- Theo dõi số lượng tồn, nhập, xuất của sản phẩm
- Quản lý nhà cung cấp, khách hàng và đơn hàng
- Cảnh báo khi sản phẩm sắp hết hàng
- Ghi nhận và lưu vết thao tác của nhân viên

## 2. Mô hình kiến trúc

Hệ thống được thiết kế theo mô hình **3 lớp (Three-tier Architecture)**:

- **Client (UI):** Giao diện web (HTML/CSS/JS hoặc framework như React)
- **Server / API:** Xử lý nghiệp vụ bằng Python (Flask/FastAPI) hoặc Node.js (Express)
- **Database Layer:** Lưu trữ dữ liệu bằng MySQL

## 3. Thành phần hệ thống

| Thành phần | Mô tả |
|-------------|-------|
| **Frontend** | Cung cấp giao diện cho người dùng (Admin, nhân viên, kế toán) |
| **Backend** | Xử lý logic: quản lý sản phẩm, kho, đơn hàng, người dùng |
| **Database (MySQL)** | Lưu trữ dữ liệu, đảm bảo toàn vẹn và quan hệ giữa các bảng |
| **API** | Giao tiếp giữa frontend và backend qua RESTful endpoints |
| **Authentication** | Quản lý đăng nhập, phân quyền (Admin / Nhân viên) |

## 4. Luồng dữ liệu (Data Flow)

1. Người dùng gửi yêu cầu (vd: “Xem danh sách sản phẩm tồn kho”)
2. Server nhận request qua API `/api/sanpham/tonkho`
3. Backend gọi đến model tương ứng để truy vấn DB
4. MySQL trả kết quả → Backend xử lý và trả JSON về cho frontend
5. Giao diện hiển thị dữ liệu cho người dùng

## 5. Công nghệ sử dụng

| Thành phần | Công nghệ đề xuất |
|-------------|------------------|
| **Frontend** | HTML, CSS, JS, Bootstrap hoặc React |
| **Backend** | Python (Flask / FastAPI) hoặc Node.js (Express) |
| **Database** | MySQL |
| **Công cụ vẽ ERD** | MySQL Workbench / Draw.io |
| **Quản lý mã nguồn** | Git + GitHub |
| **Công cụ hỗ trợ** | VS Code, Postman, XAMPP / MySQL Server |

## 6. Mô hình triển khai (Deployment)

Ứng dụng có thể chạy cục bộ hoặc triển khai trên server:
