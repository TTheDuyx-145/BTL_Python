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



# Cấu trúc bảng cho bảng 'NhaCungCap'
CREATE TABLE NhaCungCap (
    ma_ncc INT AUTO_INCREMENT PRIMARY KEY,
    ten_ncc VARCHAR(255) NOT NULL,
    lien_he TEXT
);

/*
 Đang đổ dữ liệu vào bảng 'NhaCungCap'
*/



# Cấu trúc bảng cho bảng 'DonNhapHang'
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


# Cấu trúc bảng cho bảng 'KhachHang'
CREATE TABLE KhachHang (
    ma_kh INT AUTO_INCREMENT PRIMARY KEY,
    ten_kh VARCHAR(255) NOT NULL,
    lien_he TEXT
);

/*
 Đang đổ dữ liệu vào bảng 'KhachHang'
*/



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



/*
 Cấu trúc bảng cho bảng 'NhanVien'
*/
CREATE TABLE NhanVien (
    ma_nv INT AUTO_INCREMENT PRIMARY KEY,
    ten_nv VARCHAR(255),
    chuc_vu VARCHAR(100),
    username VARCHAR(100) UNIQUE,
    password VARCHAR(255)
);

/*
 Đang đổ dữ liệu vào bảng 'NhanVien'
*/



CREATE TABLE ThanhToan (
    ma_tt INT AUTO_INCREMENT PRIMARY KEY,
    ma_don_ban INT,
    hinh_thuc ENUM('TIEN_MAT','CHUYEN_KHOAN','THE'),
    so_tien DECIMAL(15,2),
    ngay_tt DATETIME DEFAULT CURRENT_TIMESTAMP,
    trang_thai ENUM('DA_THANH_TOAN','CHUA_THANH_TOAN') DEFAULT 'CHUA_THANH_TOAN',
    FOREIGN KEY (ma_don_ban) REFERENCES DonBanHang(ma_don_ban)
);

/*
 Đang đổ dữ liệu vào bảng 'ThanhToan'
*/



# Cấu trúc bảng cho bảng 'LichSuDangNhap'
CREATE TABLE LichSuDangNhap (
    ma_ls_dn INT AUTO_INCREMENT PRIMARY KEY,
    ma_nv INT,
    thoi_gian_dang_nhap DATETIME DEFAULT CURRENT_TIMESTAMP,
    dia_chi_ip VARCHAR(50),
    trang_thai ENUM('THANH_CONG', 'THAT_BAI') DEFAULT 'THANH_CONG',
    FOREIGN KEY (ma_nv) REFERENCES NhanVien(ma_nv)
);

/*
 Đang đổ dữ liệu vào bảng 'LichSuDangNhap'
*/


CREATE INDEX idx_tensp ON SanPham(ten_san_pham);
CREATE INDEX idx_kho_tenkho ON Kho(ten_kho);
CREATE INDEX idx_tonkho_productkho ON TonKho(product_id, ma_kho);
CREATE INDEX idx_donban_khachhang ON DonBanHang(ma_kh);
CREATE INDEX idx_thanh_toan_trangthai ON ThanhToan(trang_thai);
CREATE INDEX idx_nhanvien_username ON NhanVien(username);
CREATE INDEX idx_dangnhap_nv ON LichSuDangNhap(ma_nv);

