CẤU TRÚC DỰ ÁN CHI TIẾT
QL_KhoHangNho/
├── sql/
│   ├── create_tables.sql
│   ├── insert_data.sql
│   ├── triggers_views.sql
│   └── stored_procedures.sql
├── backend/
│   ├── models/
│   ├── controllers/
│   ├── routes/
│   ├── utils/
│   ├── app.js
│   └── package.json
├── frontend/
│   ├── public/
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── services/
│   │   ├── App.js
│   │   └── index.js
│   ├── package.json
│   └── README.md
├── docs/
│   ├── ERD.png
│   ├── thiết_kế_kiến_trúc.md
│   └── hướng_dẫn_sử_dụng.md
├── tests/
├── .gitignore
└── README.md

sql/ — Thư mục Cơ sở dữ liệu MySQL
File	Mô tả
create_tables.sql	Chứa các lệnh CREATE TABLE tạo cấu trúc bảng như SanPham, Kho, TonKho, PhieuNhap, PhieuXuat, NhanVien, ...
insert_data.sql	Chứa dữ liệu mẫu (INSERT INTO) để test hệ thống: vài sản phẩm, kho, nhân viên, phiếu nhập/xuất, ...
triggers_views.sql	Gồm các TRIGGER (kích hoạt khi nhập/xuất hàng) và VIEW (tổng hợp dữ liệu như "Danh sách hàng sắp hết").
stored_procedures.sql	Chứa các PROCEDURE hỗ trợ xử lý logic như cập nhật tồn kho, tạo phiếu nhập, kiểm tra hàng sắp hết, ...

Mục đích: Giúp backend thao tác dữ liệu nhanh và gọn hơn, tránh viết SQL rời rạc.

backend/ — Phần Server (Xử lý logic, API)

Đây là nơi bạn viết Node.js + Express (hoặc Flask/Django/PHP nếu muốn).
Backend là cầu nối giữa frontend và database.

Mục	Mô tả chi tiết
models/	Chứa các mô hình (model) biểu diễn bảng trong DB — ví dụ SanPhamModel.js, KhoModel.js. Mỗi model định nghĩa truy vấn SQL tương ứng.
controllers/	Chứa các file xử lý yêu cầu từ client. Ví dụ: SanPhamController.js sẽ nhận request từ frontend, gọi model và trả về JSON.
routes/	Chứa định nghĩa endpoint API, ví dụ /api/sanpham, /api/kho. Mỗi route liên kết với 1 controller tương ứng.
utils/	Chứa các tiện ích (helper) như kết nối MySQL (db.js), xử lý lỗi, log, xác thực JWT, ...
app.js	File chính khởi động server: import Express, định nghĩa middleware, kết nối DB, lắng nghe cổng (localhost:5000).
package.json	Danh sách thư viện dùng trong backend (như express, mysql2, cors, dotenv).

 Ví dụ API:

// backend/routes/sanpham.js
router.get("/", SanPhamController.getAll);
router.post("/", SanPhamController.create);
router.put("/:id", SanPhamController.update);
router.delete("/:id", SanPhamController.delete);

frontend/ — Phần Giao diện người dùng (Web UI)

Viết bằng React.js, nơi hiển thị dữ liệu và cho phép người dùng thao tác.

Mục	Mô tả chi tiết
public/	Chứa các file tĩnh: ảnh logo, icon, favicon, index.html.
src/	Nơi chứa toàn bộ mã React chính.
├── components/	Các khối tái sử dụng được: thanh menu, bảng sản phẩm, modal nhập hàng, form đăng nhập, ...
├── pages/	Các trang chính: HomePage.js, SanPhamPage.js, KhoPage.js, NhapXuatPage.js, LoginPage.js, ...
├── services/	Nơi viết hàm gọi API (dùng axios), ví dụ getAllProducts(), updateKho(), ...
├── App.js	Thành phần gốc của app — khai báo router (React Router), hiển thị layout.
└── index.js	Điểm khởi động ứng dụng React, render <App /> lên DOM.
package.json	Gồm thư viện frontend như react, react-router-dom, axios, bootstrap, tailwindcss.
README.md	Ghi chú hướng dẫn chạy frontend (npm install, npm start).

Frontend giao tiếp với backend qua API — ví dụ http://localhost:5000/api/sanpham.

docs/ — Tài liệu dự án
File	Mô tả
ERD.png	Ảnh sơ đồ quan hệ giữa các bảng trong CSDL.
thiết_kế_kiến_trúc.md	Mô tả kiến trúc hệ thống (frontend ↔ backend ↔ database), công nghệ dùng, sơ đồ hoạt động.
hướng_dẫn_sử_dụng.md	Hướng dẫn người dùng cuối: cách đăng nhập, nhập/xuất hàng, kiểm tra tồn kho, xuất báo cáo.
