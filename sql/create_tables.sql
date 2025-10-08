-- Tạo CSDL và chọn CSDL
CREATE DATABASE IF NOT EXISTS quan_ly_kho
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE quan_ly_kho;

-- Luôn dùng InnoDB để hỗ trợ FK
SET default_storage_engine=INNODB;

-- 1) Địa điểm
CREATE TABLE dia_diem (
  id_dia_diem   VARCHAR(100) PRIMARY KEY,
  ten_dia_diem  VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

-- 2) Chức vụ
CREATE TABLE chuc_vu (
  id_chuc_vu    VARCHAR(100) PRIMARY KEY,
  ten_chuc_vu   VARCHAR(255) NOT NULL,
  luong_co_ban  DECIMAL(15,2) NOT NULL
) ENGINE=InnoDB;

-- 3) Phân loại mặt hàng
CREATE TABLE phan_loai_mat_hang (
  id_phan_loai_mat_hang VARCHAR(100) PRIMARY KEY,
  ten_mat_hang          VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

-- 4) Loại hàng
CREATE TABLE loai_hang (
  id_loai_hang          VARCHAR(100) PRIMARY KEY,
  id_phan_loai_mat_hang VARCHAR(100) NOT NULL,
  ten_loai_hang         VARCHAR(255) NOT NULL,
  CONSTRAINT fk_loai_hang_phan_loai_mat_hang
    FOREIGN KEY (id_phan_loai_mat_hang)
    REFERENCES phan_loai_mat_hang(id_phan_loai_mat_hang)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 5) Khách hàng
CREATE TABLE khach_hang (
  id_khach_hang  VARCHAR(100) PRIMARY KEY,
  ho             VARCHAR(100),
  ten_dem        VARCHAR(100),
  ten            VARCHAR(100),
  so_dien_thoai  VARCHAR(20),
  id_dia_chi     VARCHAR(100),
  CONSTRAINT fk_khach_hang_dia_diem
    FOREIGN KEY (id_dia_chi)
    REFERENCES dia_diem(id_dia_diem)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;

-- 6) Nhà cung cấp
CREATE TABLE nha_cung_cap (
  id_nha_cung_cap            VARCHAR(100) PRIMARY KEY,
  ten_nha_cung_cap           VARCHAR(255) NOT NULL,
  so_dien_thoai_nha_cung_cap VARCHAR(20),
  id_dia_chi                 VARCHAR(100),
  CONSTRAINT fk_ncc_dia_diem
    FOREIGN KEY (id_dia_chi)
    REFERENCES dia_diem(id_dia_diem)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;

-- 7) Xe vận chuyển
CREATE TABLE xe_van_chuyen (
  id_xe_van_chuyen     VARCHAR(100) PRIMARY KEY,
  bien_so              VARCHAR(100) NOT NULL,
  ho                   VARCHAR(100),
  ten_dem              VARCHAR(100),
  ten                  VARCHAR(100),
  so_dien_thoai_tai_xe VARCHAR(20)
) ENGINE=InnoDB;

-- 8) Nhân viên
CREATE TABLE nhan_vien (
  id_nhan_vien              VARCHAR(100) PRIMARY KEY,
  ho                        VARCHAR(100),
  ten_dem                   VARCHAR(100),
  ten                       VARCHAR(100),
  ngay_sinh                 DATE,
  so_dien_thoai_nhan_vien   VARCHAR(20),
  id_chuc_vu                VARCHAR(100),
  CONSTRAINT fk_nv_chuc_vu
    FOREIGN KEY (id_chuc_vu)
    REFERENCES chuc_vu(id_chuc_vu)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;

-- 9) Sản phẩm
CREATE TABLE san_pham (
  id_san_pham   VARCHAR(100) PRIMARY KEY,
  ten_san_pham  VARCHAR(255) NOT NULL,
  size          VARCHAR(100),
  chat_lieu     VARCHAR(100),
  mau           VARCHAR(100),
  id_loai_hang  VARCHAR(100),
  CONSTRAINT fk_sp_loai_hang
    FOREIGN KEY (id_loai_hang)
    REFERENCES loai_hang(id_loai_hang)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;

-- 10) Hóa đơn nhập (dòng chi tiết)
CREATE TABLE hoa_don_nhap (
  id_san_pham_hoa_don_nhap VARCHAR(100) PRIMARY KEY,
  id_hoa_don_nhap          VARCHAR(100) NOT NULL,
  id_san_pham              VARCHAR(100) NOT NULL,
  so_san_pham_nhap         INT UNSIGNED NOT NULL,
  gia_nhap                 DECIMAL(15,2) NOT NULL,
  ngay_nhap                DATETIME NOT NULL,
  id_nhan_vien             VARCHAR(100),
  id_nha_cung_cap          VARCHAR(100),
  CONSTRAINT fk_hdn_sp
    FOREIGN KEY (id_san_pham)
    REFERENCES san_pham(id_san_pham)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT fk_hdn_nv
    FOREIGN KEY (id_nhan_vien)
    REFERENCES nhan_vien(id_nhan_vien)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  CONSTRAINT fk_hdn_ncc
    FOREIGN KEY (id_nha_cung_cap)
    REFERENCES nha_cung_cap(id_nha_cung_cap)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  INDEX (id_hoa_don_nhap),
  INDEX (id_san_pham),
  INDEX (id_nhan_vien),
  INDEX (id_nha_cung_cap)
) ENGINE=InnoDB;

-- 11) Hóa đơn xuất (dòng chi tiết)
CREATE TABLE hoa_don_xuat (
  id_san_pham_hoa_don_xuat VARCHAR(100) PRIMARY KEY,
  id_hoa_don_xuat          VARCHAR(100) NOT NULL,
  id_san_pham              VARCHAR(100) NOT NULL,
  so_san_pham_xuat         INT UNSIGNED NOT NULL,
  gia_ban                  DECIMAL(15,2) NOT NULL,
  ngay_xuat                DATETIME NOT NULL,
  id_nhan_vien             VARCHAR(100),
  id_xe_van_chuyen         VARCHAR(100),
  id_khach_hang            VARCHAR(100),
  CONSTRAINT fk_hdx_sp
    FOREIGN KEY (id_san_pham)
    REFERENCES san_pham(id_san_pham)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT fk_hdx_nv
    FOREIGN KEY (id_nhan_vien)
    REFERENCES nhan_vien(id_nhan_vien)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  CONSTRAINT fk_hdx_xe
    FOREIGN KEY (id_xe_van_chuyen)
    REFERENCES xe_van_chuyen(id_xe_van_chuyen)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  CONSTRAINT fk_hdx_kh
    FOREIGN KEY (id_khach_hang)
    REFERENCES khach_hang(id_khach_hang)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  INDEX (id_hoa_don_xuat),
  INDEX (id_san_pham),
  INDEX (id_nhan_vien),
  INDEX (id_xe_van_chuyen),
  INDEX (id_khach_hang)
) ENGINE=InnoDB;
