-- Tạo view

USE quan_ly_kho;

-- Xóa nếu đã tồn tại (tránh lỗi khi chạy lại)
DROP VIEW IF EXISTS ds_nv, ds_ql, ds_kt, ds_kh, ds_ncc, bang_luong, ds_sp, ds_sp_het;

-- ===== Các view theo chức vụ =====
CREATE VIEW ds_nv AS
SELECT  nv.id_nhan_vien,
        CONCAT_WS(' ', nv.ho, nv.ten_dem, nv.ten) AS ten_nhan_vien,
        nv.ngay_sinh,
        nv.so_dien_thoai_nhan_vien,
        cv.ten_chuc_vu            AS chuc_vu_nhan_vien,
        cv.luong_co_ban
FROM nhan_vien nv
LEFT JOIN chuc_vu cv ON cv.id_chuc_vu = nv.id_chuc_vu
WHERE cv.ten_chuc_vu = 'Nhân viên';

CREATE VIEW ds_ql AS
SELECT  nv.id_nhan_vien,
        CONCAT_WS(' ', nv.ho, nv.ten_dem, nv.ten) AS ten_nhan_vien,
        nv.ngay_sinh,
        nv.so_dien_thoai_nhan_vien,
        cv.ten_chuc_vu            AS chuc_vu_nhan_vien,
        cv.luong_co_ban
FROM nhan_vien nv
LEFT JOIN chuc_vu cv ON cv.id_chuc_vu = nv.id_chuc_vu
WHERE cv.ten_chuc_vu = 'Quản lý';

CREATE VIEW ds_kt AS
SELECT  nv.id_nhan_vien,
        CONCAT_WS(' ', nv.ho, nv.ten_dem, nv.ten) AS ten_nhan_vien,
        nv.ngay_sinh,
        nv.so_dien_thoai_nhan_vien,
        cv.ten_chuc_vu            AS chuc_vu_nhan_vien,
        cv.luong_co_ban
FROM nhan_vien nv
LEFT JOIN chuc_vu cv ON cv.id_chuc_vu = nv.id_chuc_vu
WHERE cv.ten_chuc_vu = 'Kế toán';

-- ===== Danh sách khách hàng / nhà cung cấp =====
CREATE VIEW ds_kh AS
SELECT  kh.id_khach_hang,
        CONCAT_WS(' ', kh.ho, kh.ten_dem, kh.ten) AS ten_khach_hang,
        kh.so_dien_thoai,
        dd.ten_dia_diem AS dia_chi
FROM khach_hang kh
LEFT JOIN dia_diem dd ON dd.id_dia_diem = kh.id_dia_chi;

CREATE VIEW ds_ncc AS
SELECT  ncc.id_nha_cung_cap,
        ncc.ten_nha_cung_cap,
        ncc.so_dien_thoai_nha_cung_cap,
        dd.ten_dia_diem AS dia_chi_nha_cung_cap
FROM nha_cung_cap ncc
LEFT JOIN dia_diem dd ON dd.id_dia_diem = ncc.id_dia_chi;

-- ===== Bảng lương (ghép chức vụ để lấy lương) =====
CREATE VIEW bang_luong AS
SELECT  nv.id_nhan_vien,
        CONCAT_WS(' ', nv.ho, nv.ten_dem, nv.ten) AS ten_nhan_vien,
        cv.ten_chuc_vu AS chuc_vu_nhan_vien,
        cv.luong_co_ban
FROM nhan_vien nv
LEFT JOIN chuc_vu cv ON cv.id_chuc_vu = nv.id_chuc_vu;

-- ===== Danh sách sản phẩm kèm tồn kho & giá gần nhất =====
-- so_luong_san_pham = Tổng nhập - Tổng xuất
-- gia_nhap_san_pham / gia_ban_san_pham = đơn giá gần nhất theo thời gian
CREATE VIEW ds_sp AS
SELECT  sp.id_san_pham,
        sp.ten_san_pham,
        -- Tồn kho
        COALESCE(n.tong_nhap, 0) - COALESCE(x.tong_xuat, 0) AS so_luong_san_pham,
        -- Giá gần nhất (nếu chưa có nhập/xuất thì NULL)
        (SELECT hdn.gia_nhap
           FROM hoa_don_nhap hdn
          WHERE hdn.id_san_pham = sp.id_san_pham
          ORDER BY hdn.ngay_nhap DESC
          LIMIT 1) AS gia_nhap_san_pham,
        (SELECT hdx.gia_ban
           FROM hoa_don_xuat hdx
          WHERE hdx.id_san_pham = sp.id_san_pham
          ORDER BY hdx.ngay_xuat DESC
          LIMIT 1) AS gia_ban_san_pham
FROM san_pham sp
LEFT JOIN (
    SELECT id_san_pham, SUM(so_san_pham_nhap) AS tong_nhap
    FROM hoa_don_nhap
    GROUP BY id_san_pham
) n  ON n.id_san_pham = sp.id_san_pham
LEFT JOIN (
    SELECT id_san_pham, SUM(so_san_pham_xuat) AS tong_xuat
    FROM hoa_don_xuat
    GROUP BY id_san_pham
) x  ON x.id_san_pham = sp.id_san_pham;

-- Sản phẩm sắp hết (tồn < 10)
CREATE VIEW ds_sp_het AS
SELECT id_san_pham, ten_san_pham, so_luong_san_pham
FROM ds_sp
WHERE so_luong_san_pham < 10;
