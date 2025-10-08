USE quan_ly_kho;

-- 1) dia_diem
INSERT INTO dia_diem (id_dia_diem, ten_dia_diem) VALUES
('DD01','Quận 1, TP.HCM'),
('DD02','Quận 3, TP.HCM'),
('DD03','Hà Đông, Hà Nội'),
('DD04','Thuận An, Bình Dương');

-- 2) chuc_vu
INSERT INTO chuc_vu (id_chuc_vu, ten_chuc_vu, luong_co_ban) VALUES
('CV01','Nhân viên kho',8000000),
('CV02','Kế toán',10000000),
('CV03','Quản lý',15000000);

-- 3) phan_loai_mat_hang
INSERT INTO phan_loai_mat_hang (id_phan_loai_mat_hang, ten_mat_hang) VALUES
('PL01','Thời trang'),
('PL02','Gia dụng');

-- 4) loai_hang
INSERT INTO loai_hang (id_loai_hang, id_phan_loai_mat_hang, ten_loai_hang) VALUES
('LH01','PL01','Áo thun'),
('LH02','PL01','Quần jean'),
('LH03','PL02','Đồ nhà bếp');

-- 5) khach_hang
INSERT INTO khach_hang (id_khach_hang, ho, ten_dem, ten, so_dien_thoai, id_dia_chi) VALUES
('KH01','Nguyễn','Văn','An','0909123123','DD01'),
('KH02','Trần','Thị','Bích','0911222333','DD03'),
('KH03','Lê',NULL,'Hùng','0988111222','DD02');

-- 6) nha_cung_cap
INSERT INTO nha_cung_cap (id_nha_cung_cap, ten_nha_cung_cap, so_dien_thoai_nha_cung_cap, id_dia_chi) VALUES
('NCC01','Công ty Dệt May Miền Nam','02811112222','DD04'),
('NCC02','Gia Dụng Việt','02433334444','DD03');

-- 7) xe_van_chuyen
INSERT INTO xe_van_chuyen (id_xe_van_chuyen, bien_so, ho, ten_dem, ten, so_dien_thoai_tai_xe) VALUES
('XE01','51H-123.45','Phạm','Văn','Tài','0903000111'),
('XE02','60A-678.90','Đỗ','Quang','Minh','0903000222');

-- 8) nhan_vien
INSERT INTO nhan_vien (id_nhan_vien, ho, ten_dem, ten, ngay_sinh, so_dien_thoai_nhan_vien, id_chuc_vu) VALUES
('NV01','Nguyễn','Thị','Lan','1995-03-12','0909000001','CV02'),
('NV02','Phạm','Văn','Long','1992-08-20','0909000002','CV01'),
('NV03','Trần',NULL,'Khánh','1988-12-05','0909000003','CV03');

-- 9) san_pham
INSERT INTO san_pham (id_san_pham, ten_san_pham, size, chat_lieu, mau, id_loai_hang) VALUES
('SP01','Áo thun cổ tròn','M','Cotton','Trắng','LH01'),
('SP02','Áo thun cổ tròn','L','Cotton','Đen','LH01'),
('SP03','Quần jean slim','32','Denim','Xanh đậm','LH02'),
('SP04','Bộ dao nhà bếp 5 món',NULL,'Thép không gỉ','Bạc','LH03');

-- 10) hoa_don_nhap (chi tiết nhập)
-- Giả sử mỗi id_hoa_don_nhap có thể có nhiều dòng
INSERT INTO hoa_don_nhap
(id_san_pham_hoa_don_nhap, id_hoa_don_nhap, id_san_pham, so_san_pham_nhap, gia_nhap, ngay_nhap, id_nhan_vien, id_nha_cung_cap) VALUES
('HDN001-1','HDN001','SP01',100,80000,'2025-01-05 09:30:00','NV01','NCC01'),
('HDN001-2','HDN001','SP02',80, 82000,'2025-01-05 09:30:00','NV01','NCC01'),
('HDN002-1','HDN002','SP03',60,180000,'2025-02-10 14:10:00','NV02','NCC01'),
('HDN003-1','HDN003','SP04',40,250000,'2025-02-20 10:05:00','NV02','NCC02');

-- 11) hoa_don_xuat (chi tiết xuất)
INSERT INTO hoa_don_xuat
(id_san_pham_hoa_don_xuat, id_hoa_don_xuat, id_san_pham, so_san_pham_xuat, gia_ban, ngay_xuat, id_nhan_vien, id_xe_van_chuyen, id_khach_hang) VALUES
('HDX001-1','HDX001','SP01',5,120000,'2025-03-01 11:00:00','NV02','XE01','KH01'),
('HDX001-2','HDX001','SP02',3,125000,'2025-03-01 11:00:00','NV02','XE01','KH01'),
('HDX002-1','HDX002','SP03',2,260000,'2025-03-03 15:20:00','NV01','XE02','KH02'),
('HDX003-1','HDX003','SP04',1,360000,'2025-03-05 09:45:00','NV03','XE01','KH03');

