# Cơ sỏ dữ liệu 'Quan lý kho hàng nhỏ'
CREATE DATABASE QLKHN;
USE QLKHN;

# Cấu trúc bảng cho bảng 'SanPham'
CREATE TABLE SanPham(
	product_id  INT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(50),
    ten_san_pham VARCHAR(255),
    mo_ta TEXT,
    don_vi VARCHAR(20),
    muc_bao_cao INT
);

/*
 Đang đổ dữ liệu vào bảng 'SanPham'
*/
INSERT INTO SanPham (sku, ten_san_pham, mo_ta, don_vi, muc_bao_cao) VALUES
('SP001', 'Bút bi', 'Bút bi mực xanh', 'cái', 100),
('SP002', 'Vở 200 trang', 'Vở học sinh 200 trang', 'quyển', 50),
('SP003', 'Thước kẻ 30cm', 'Thước nhựa 30cm', 'cái', 30),
('SP004', 'Tẩy', 'Tẩy nhỏ trắng', 'cái', 20),
('SP005', 'Bảng trắng', 'Bảng trắng treo tường', 'cái', 10);


# Cấu trúc bảng cho bảng 'Kho'
CREATE TABLE Kho(
	ma_kho INT AUTO_INCREMENT PRIMARY KEY,
    ma_kho_code VARCHAR(50),
    ten_kho VARCHAR(255),
    dia_chi TEXT
);

/*
 Đang đổ dữ liệu vào bảng 'Kho'
*/
INSERT INTO Kho (ma_kho_code, ten_kho, dia_chi) VALUES
('K001', 'Kho chính', 'Số 1, Đường ABC, Hà Nội'),
('K002', 'Kho chi nhánh 1', 'Số 2, Đường XYZ, Hà Nội'),
('K003', 'Kho chi nhánh 2', 'Số 3, Đường DEF, Hà Nội');


# Cấu trúc bảng cho bảng 'TonKho'
CREATE TABLE TonKho(
    ma_ton INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    ma_kho INT,
    so_luong INT,
    ngay_cap_nhat DATETIME,
    FOREIGN KEY (product_id) REFERENCES SanPham(product_id),
    FOREIGN KEY (ma_kho) REFERENCES Kho(ma_kho)
);

/*
 Đang đổ dữ liệu vào bảng 'TonKho'
*/
INSERT INTO TonKho (product_id, ma_kho, so_luong, ngay_cap_nhat) VALUES
(1, 1, 500, NOW()),
(2, 1, 300, NOW()),
(3, 2, 150, NOW()),
(4, 2, 200, NOW()),
(5, 3, 50, NOW());



# Cấu trúc bảng cho bảng 'NhapXuatKho'
CREATE TABLE NhapXuatKho (
    ma_phieu INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    ma_kho INT NOT NULL,
    so_luong INT NOT NULL,
    loai_giao_dich ENUM('NHAP', 'XUAT', 'DIEUCHINH') NOT NULL,
    ma_tham_chieu VARCHAR(100),
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_nxk_sanpham FOREIGN KEY (product_id)
        REFERENCES SanPham(product_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_nxk_kho FOREIGN KEY (ma_kho)
        REFERENCES Kho(ma_kho)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*
 Đang đổ dữ liệu vào bảng 'NhapXuatKho'
*/
INSERT INTO NhapXuatKho (product_id, ma_kho, so_luong, loai_giao_dich, ma_tham_chieu) VALUES
(1, 1, 200, 'NHAP', 'PN001'),
(2, 1, 100, 'NHAP', 'PN002'),
(3, 2, 50, 'NHAP', 'PN003'),
(4, 2, 20, 'NHAP', 'PN004'),
(5, 3, 10, 'NHAP', 'PN005');


# Cấu trúc bảng cho bảng 'NhaCungCap'
CREATE TABLE NhaCungCap (
    ma_ncc INT AUTO_INCREMENT PRIMARY KEY,
    ten_ncc VARCHAR(255) NOT NULL,
    lien_he TEXT
);

/*
 Đang đổ dữ liệu vào bảng 'NhaCungCap'
*/
INSERT INTO NhaCungCap (ten_ncc, lien_he) VALUES
('Công ty Văn phòng phẩm ABC', '0123456789'),
('Công ty Văn phòng phẩm XYZ', '0987654321'),
('Công ty Thiết bị học tập DEF', '0112233445');


# Cấu trúc bảng cho bảng 'DonNhanHang'
CREATE TABLE DonNhapHang (
    ma_don_nhap INT AUTO_INCREMENT PRIMARY KEY,
    ma_ncc INT NOT NULL,
    so_don_nhap VARCHAR(50),
    trang_thai ENUM('CHO_XU_LY','DA_NHAP','HUY') DEFAULT 'CHO_XU_LY',
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    ngay_du_kien DATE,
    CONSTRAINT fk_dnh_ncc FOREIGN KEY (ma_ncc)
        REFERENCES NhaCungCap(ma_ncc)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*
 Đang đổ dữ liệu vào bảng 'DonNhapHang'
*/
INSERT INTO DonNhapHang (ma_ncc, so_don_nhap, trang_thai, ngay_du_kien) VALUES
(1, 'DN001', 'CHO_XU_LY', '2025-10-10'),
(2, 'DN002', 'DA_NHAP', '2025-10-08');

# Cấu trúc bảng cho bảng 'ChiTietDonHang'
CREATE TABLE ChiTietDonHang (
    ma_ct_nhap INT AUTO_INCREMENT PRIMARY KEY,
    ma_don_nhap INT NOT NULL,
    product_id INT NOT NULL,
    so_luong INT NOT NULL,
    don_gia DECIMAL(12,2) NOT NULL,
    CONSTRAINT fk_ctdn_donnhap FOREIGN KEY (ma_don_nhap)
        REFERENCES DonNhapHang(ma_don_nhap)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_ctdn_sanpham FOREIGN KEY (product_id)
        REFERENCES SanPham(product_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*
 Đang đổ dữ liệu vào bảng 'ChiTietDonHang'
*/
INSERT INTO ChiTietDonHang (ma_don_nhap, product_id, so_luong, don_gia) VALUES
(1, 1, 200, 5000),
(1, 2, 100, 10000),
(2, 3, 50, 3000);

# Cấu trúc bảng cho bảng 'KhachHang'
CREATE TABLE KhachHang (
    ma_kh INT AUTO_INCREMENT PRIMARY KEY,
    ten_kh VARCHAR(255) NOT NULL,
    lien_he TEXT
);

/*
 Đang đổ dữ liệu vào bảng 'KhachHang'
*/
INSERT INTO KhachHang (ten_kh, lien_he) VALUES
('Nguyễn Văn A', '0123456789'),
('Trần Thị B', '0987654321'),
('Công ty Cổ phần Giáo Dục', '0245678901');


# Cấu trúc bảng cho bảng 'DonBanHang'
CREATE TABLE DonBanHang (
    ma_don_ban INT AUTO_INCREMENT PRIMARY KEY,
    ma_kh INT NOT NULL,
    so_don_ban VARCHAR(50),
    trang_thai ENUM('MOI','DANG_XU_LY','DA_GIAO','HUY') DEFAULT 'MOI',
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    tong_tien DECIMAL(12,2) DEFAULT 0,
    CONSTRAINT fk_dbh_khachhang FOREIGN KEY (ma_kh)
        REFERENCES KhachHang(ma_kh)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*
 Đang đổ dữ liệu vào bảng 'DonBanHang'
*/
INSERT INTO DonBanHang (ma_kh, so_don_ban, trang_thai, tong_tien) VALUES
(1, 'DB001', 'MOI', 0),
(2, 'DB002', 'DANG_XU_LY', 0);


# Cấu trúc bảng cho bảng 'ChiTietDonBan'
CREATE TABLE ChiTietDonBan (
    ma_ct_ban INT AUTO_INCREMENT PRIMARY KEY,
    ma_don_ban INT NOT NULL,
    product_id INT NOT NULL,
    so_luong INT NOT NULL,
    don_gia DECIMAL(12,2) NOT NULL,
    CONSTRAINT fk_ctdb_donban FOREIGN KEY (ma_don_ban)
        REFERENCES DonBanHang(ma_don_ban)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_ctdb_sanpham FOREIGN KEY (product_id)
        REFERENCES SanPham(product_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


/*
 Đang đổ dữ liệu vào bảng 'ChiTietDonBan'
*/
INSERT INTO ChiTietDonHang (ma_don_nhap, product_id, so_luong, don_gia) VALUES
(1, 1, 200, 5000),
(1, 2, 100, 10000),
(2, 3, 50, 3000);
INSERT INTO ChiTietDonBan (ma_don_ban, product_id, so_luong, don_gia) VALUES
(1, 1, 5, 6000),
(1, 2, 2, 12000),
(2, 3, 1, 3500);

# Cấu trúc bảng cho bảng 'GiaoHang'
CREATE TABLE GiaoHang (
    ma_giao_hang INT AUTO_INCREMENT PRIMARY KEY,
    ma_don_ban INT NOT NULL,
    don_vi_vc VARCHAR(100),
    ma_van_don VARCHAR(100),
    trang_thai ENUM('CHUAN_BI','DANG_GIAO','DA_GIAO') DEFAULT 'CHUAN_BI',
    ngay_giao DATETIME,
    CONSTRAINT fk_gh_donban FOREIGN KEY (ma_don_ban)
        REFERENCES DonBanHang(ma_don_ban)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

/*
 Đang đổ dữ liệu vào bảng 'GiaoHang'
*/
INSERT INTO GiaoHang (ma_don_ban, don_vi_vc, ma_van_don, trang_thai, ngay_giao) VALUES
(1, 'Viettel Post', 'VD001', 'CHUAN_BI', '2025-10-06 10:00:00'),
(2, 'Giao Hàng Nhanh', 'VD002', 'DANG_GIAO', '2025-10-06 15:00:00');


# Cấu trúc bảng cho bảng 'CanhBaoTonKho'
CREATE TABLE CanhBaoTonKho (
    ma_cb INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    ma_kho INT NOT NULL,
    muc_ton INT NOT NULL,
    noi_dung TEXT,
    ngay_tao DATETIME DEFAULT CURRENT_TIMESTAMP,
    da_xu_ly BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_cbtk_sanpham FOREIGN KEY (product_id)
        REFERENCES SanPham(product_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_cbtk_kho FOREIGN KEY (ma_kho)
        REFERENCES Kho(ma_kho)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/*
 Đang đổ dữ liệu vào bảng 'CanhBaoTonKho'
*/
INSERT INTO GiaoHang (ma_don_ban, don_vi_vc, ma_van_don, trang_thai, ngay_giao) VALUES
(1, 'Viettel Post', 'VD001', 'CHUAN_BI', '2025-10-06 10:00:00'),
(2, 'Giao Hàng Nhanh', 'VD002', 'DANG_GIAO', '2025-10-06 15:00:00');










