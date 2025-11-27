# TK-va-QT-CSDL
Dự án quản lí thư viện
[Uploading baitapdoancuoiky.sql…]()
--Bài tập nhóm quản lí thư viện
--Thành viên : Võ Duy Bình , Dương Tấn Phát
--Câu 1ER Diagram - Mapping to Relational Diagram

--Câu 2Viết các lệnh tạo Database – Table – Primary key – Foreign key, nhập dữ liệu (1 điểm)

--1. Tạo database và sử dụng database
-- Tạo CSDL mới có tên QL_THUVIEN 
CREATE DATABASE QL_THUVIEN
GO

USE QL_THUVIEN
GO
--2. Tạo bảng và khóa chính
--Lưu thông tin table 
CREATE TABLE QUYENSACH
(
	MSSach char(50),
	TenSach nvarchar(100),
	TacGia nvarchar(100),
	MSNhaXB Char(50),
	MaLoaiSach char(50),
	NamXB int,
	LanXB int,
	SoLuong int,
	NoiDungTomLuoc Nvarchar(200),
	Primary Key (MSSach)
)
GO

CREATE TABLE DOCGIA
(
	MSDG char(50),
	TenDG nvarchar(100),
	DiaChi nvarchar(200),
	NgaySinh date,
	Email char(100),
	GioiTinh nchar(3),
	ThongTinKhac nvarchar(200),
	Primary Key (MSDG)
)
GO

CREATE TABLE NHANVIEN
(
	MSNV char(50),
	HoTenNV nvarchar(100),
	DiaChiNV nvarchar(200),
	NgaySinhNV date,
	GioiTinhNV nchar(3),
	DienThoaiNV char(50),
	EmailNV char(100),
	NgayVaoLam date,
	PRIMARY KEY (MSNV)
)
GO

CREATE TABLE MUONSACH
(
	SoPhieuMuon char(50),
	MSDG char(50),
	MSNV char(50),
	NgayMuon date,
	PRIMARY KEY (SoPhieuMuon)
)
GO

CREATE TABLE CHITIETPHIEUMUON
(
	SoPhieuMuon char(50),
	MSSach char(50),
	HanTra date,
	Primary key (SoPhieuMuon, MSSach)
)
GO

CREATE TABLE LOAISACH 
(
	MaLoaiSach char(50),
	LoaiSach nvarchar(200),
	Primary key (MaLoaiSach)
)
GO

CREATE TABLE PHAT
(
	MSSach char(50),
	MSDG char(50),
	LyDoPhat nvarchar(200),
	Primary key (MSSach, MSDG)
)
GO

CREATE TABLE NHAXUATBAN
(
	MSNXB char(50),
	TenNXB nvarchar(200),
	DiaChiNXB nvarchar(200),
	WebSiteNXB char(100),
	ThongTinKhac nvarchar(200),
	Primary Key (MSNXB)
)
GO

CREATE TABLE TRASACH
(
	SoPhieuMuon char(50),
	MSSach char(50),
	MSNV char(50),
	NgayTra date,
	Primary key (SoPhieuMuon, MSSach)
)
GO

--3.Tạo khóa ngoại'
-- Tạo khóa ngoại ở bảng QUYỂN SÁCH
Alter table QUYENSACH
	add constraint FK_QS_MLS
	foreign key (MaLoaiSach)
	references LOAISACH(MaLoaiSach)
	go
--Tạo khóa ngoại ở bảng QUYỂN SÁCH
Alter table QUYENSACH
	add constraint FK_QS_MSNXB
	foreign key (MSNhaXB)
	references NHAXUATBAN(MSNXB)
	go
--Tạo khóa ngoại ở bảng CHITIETPHIEUMUON
Alter table CHITIETPHIEUMUON
	add constraint FK_PM_MSSach
	foreign key (MSSach)
	references QUYENSACH(MSSach)
	go
--Tạo khóa ngoại ở bảng CHITIETPHIEUMUON
Alter table CHITIETPHIEUMUON
	add constraint FK_PM_SPM
	foreign key (SoPhieuMuon)
	references MUONSACH(SoPhieuMuon)
	go
--Tạo khóa ngoại ở bảng MUONSACH
Alter table MUONSACH
	add constraint FK_MS_MSNV
	foreign key (MSNV)
	references NHANVIEN(MSNV)
	go
--Tạo khóa ngoại ở bãng MUONSACH
--Tác dụng : Đảm bỏ MSDG trong bảng MUONSACH phải tồn tại trong bảng DOCGIA, tránh nhập sai độc giả
Alter table MUONSACH
	add constraint FK_MS_MSDG
	foreign key (MSDG)
	references DOCGIA(MSDG)
	go
--Tạo khóa ngoại ỡ bảng TRASACH
Alter table TRASACH
	add constraint FK_TS_MSNV
	foreign key (MSNV)
	references NHANVIEN(MSNV)
	go
--Tạo khóa ngoại ở bảng TRASACH
Alter table TRASACH
	add constraint FK_TS_MSSACH
	foreign key	(MSSach)
	references QUYENSACH(MSSach)
	go
--Tạo khóa ngoại ở bảng TRASACH
Alter table TRASACH
	add constraint	FK_TS_SPM
	foreign key	(SoPhieuMuon)
	references	MUONSACH(SoPhieuMuon)
	go
--Tạo khóa ngoại ở bảng PHAT
Alter table PHAT
	add constraint FK_P_MSDG
	foreign key (MSDG)
	references	DOCGIA(MSDG)
	go
--Tạo khóa ngoại ở bảng PHAT
Alter table PHAT
	add constraint	FK_P_MSSach
	foreign key	(MSSach)
	references	QUYENSACH(MSSach)
	go

-- 4. Nhập data
--Nhập data cho bảng LOAISACH
Insert into LOAISACH(MaLoaiSach,LoaiSach)
Values ('MSL01', N'Văn Học')
Insert into LOAISACH(MaLoaiSach,LoaiSach)
Values ('MSL02', N'Hóa Học')
Insert into LOAISACH(MaLoaiSach,LoaiSach)
Values ('MSL03', N'Tâm Lý Học')
Insert into LOAISACH(MaLoaiSach,LoaiSach)
Values ('MSL04', N'Sử Học')
Insert into LOAISACH(MaLoaiSach,LoaiSach)
Values ('MSL05', N'Đời Sống')
Insert into LOAISACH(MaLoaiSach,LoaiSach)
Values ('MSL06', N'Pháp Luật')
Insert into LOAISACH(MaLoaiSach,LoaiSach)
Values ('MSL07', N'Công Nghệ')
Insert into LOAISACH(MaLoaiSach,LoaiSach)
Values ('MSL08', N'Sách Thiếu Nhi')
Insert into LOAISACH(MaLoaiSach,LoaiSach)
Values ('MSL09', N'Lập Trình')

--Nhập data cho bảng NHAXUATBAN
Insert Into NHAXUATBAN
(MSNXB, TenNXB, DiaChiNXB, WebSiteNXB, ThongTinKhac)
Values ('NXB01',N'Nhà xuất bản Thanh Hà',N'Hai Bà Trưng - Hà Nội','www.nxbth.org.vn',N'Không')
Insert Into NHAXUATBAN
(MSNXB, TenNXB, DiaChiNXB, WebSiteNXB, ThongTinKhac)
Values ('NXB02',N'Nhà xuất bản Giáo Dục',N'Cầu Giấy - Hà Nội','www.nxbgd.giv.vn',N'Không')
Insert Into NHAXUATBAN
(MSNXB, TenNXB, DiaChiNXB, WebSiteNXB, ThongTinKhac)
Values ('NXB03',N'Nhà xuất bản Quân Đội',N'Từ Liêm - Hà Nội','www.qdndvn.vn',N'Không')
Insert Into NHAXUATBAN
(MSNXB, TenNXB, DiaChiNXB, WebSiteNXB, ThongTinKhac)
Values ('NXB04',N'Nhà xuất bản Kim Đồng',N'Hoàn Kiếm - Hà Nội','www.nxbkimdong.com',N'Không')
Insert Into NHAXUATBAN
(MSNXB, TenNXB, DiaChiNXB, WebSiteNXB, ThongTinKhac)
Values ('NXB05',N'Nhà xuất bản Khoa Học',N'Hai Bà Trưng - Hà Nội','www.nxbkhoahoc.com.vn',N'Không')
Insert Into NHAXUATBAN
(MSNXB, TenNXB, DiaChiNXB, WebSiteNXB, ThongTinKhac)
Values ('NXB06',N'Nhà xuất bản Tư Pháp',N'Hoàn Kiếm - Hà Nội','www.tuphapvn.com',N'Không')
Insert Into NHAXUATBAN
(MSNXB, TenNXB, DiaChiNXB, WebSiteNXB, ThongTinKhac)
Values ('NXB07',N'Nhà xuất bản Lao Động',N'Ba Đình - Hà Nội','www.laodong.org.vn',N'Không')
Insert Into NHAXUATBAN
(MSNXB, TenNXB, DiaChiNXB, WebSiteNXB, ThongTinKhac)
Values ('NXB08',N'Nhà xuất bản Kim Lân',N'Cầu Giấy - Hà Nội','www.kimlan.vn',N'Không')
Insert Into NHAXUATBAN
(MSNXB, TenNXB, DiaChiNXB, WebSiteNXB, ThongTinKhac)
Values ('NXB09',N'Nhà xuất bản Thanh Thiếu Niên',N'Từ Liêm - Hà Nội','www.ththieunien.edu.vn',N'Không')

--Nhập data cho bảng QUYENSACH
Insert Into 
QUYENSACH(MSSach,TenSach,TacGia,MSNhaXB,MaLoaiSach,NamXB,LanXB,SoLuong,NoiDungTomLuoc)
Values ('MSS01',N'Ngữ Văn',N'Nam Cao','NXB01','MSL01',1968,2,50,N'Không')
Insert Into 
QUYENSACH(MSSach,TenSach,TacGia,MSNhaXB,MaLoaiSach,NamXB,LanXB,SoLuong,NoiDungTomLuoc)
Values ('MSS02',N'Pháp Luật Đại Cương',N'Quang Anh','NXB03','MSL06',1952,3,49,N'Không')
Insert Into 
QUYENSACH(MSSach,TenSach,TacGia,MSNhaXB,MaLoaiSach,NamXB,LanXB,SoLuong,NoiDungTomLuoc)
Values ('MSS03',N'Hóa Học',N'Thanh Lan','NXB02','MSL02',1999,2,30,N'Không')
Insert Into 
QUYENSACH(MSSach,TenSach,TacGia,MSNhaXB,MaLoaiSach,NamXB,LanXB,SoLuong,NoiDungTomLuoc)
Values ('MSS04',N'Đời Sống Và Xã Hội',N'Kim Dung','NXB07','MSL05',1990,1,28,N'Không')
Insert Into 
QUYENSACH(MSSach,TenSach,TacGia,MSNhaXB,MaLoaiSach,NamXB,LanXB,SoLuong,NoiDungTomLuoc)
Values ('MSS05',N'Lập Trình Java',N'Hoàng Nam','NXB05','MSL09',1972,1,10,N'Không')
Insert Into 
QUYENSACH(MSSach,TenSach,TacGia,MSNhaXB,MaLoaiSach,NamXB,LanXB,SoLuong,NoiDungTomLuoc)
Values ('MSS06',N'Tâm Lý Học',N'Đoàn Quân','NXB06','MSL03',1977,2,60,N'Không')
Insert Into 
QUYENSACH(MSSach,TenSach,TacGia,MSNhaXB,MaLoaiSach,NamXB,LanXB,SoLuong,NoiDungTomLuoc)
Values ('MSS07',N'Công Nghệ Web',N'Bình Minh','NXB04','MSL07',1985,1,30,N'Không')
Insert Into 
QUYENSACH(MSSach,TenSach,TacGia,MSNhaXB,MaLoaiSach,NamXB,LanXB,SoLuong,NoiDungTomLuoc)
Values ('MSS08',N'Lịch Sử',N'Hoàng Kim','NXB08','MSL04',1955,1,20,N'Không')
Insert Into 
QUYENSACH(MSSach,TenSach,TacGia,MSNhaXB,MaLoaiSach,NamXB,LanXB,SoLuong,NoiDungTomLuoc)
Values ('MSS09',N'Hoa Học Trò',N'Nguyễn Huệ','NXB09','MSL08',1944,1,52,N'Không')

--Nhập data cho bảng NHANVIEN
Insert Into 
NHANVIEN(MSNV,HoTenNV,DiaChiNV,NgaySinhNV,GioiTinhNV,DienThoaiNV,EmailNV,NgayVaoLam)
Values('NV001',N'Đinh Văn Thăng',N'Hà Nội','1990-05-20',N'Nam','033 686 1010','lathang1990@gmail.com','2020-05-22')
Insert Into 
NHANVIEN(MSNV,HoTenNV,DiaChiNV,NgaySinhNV,GioiTinhNV,DienThoaiNV,EmailNV,NgayVaoLam)
Values('NV002',N'Cao Thùy Linh',N'Hà Nam','1992-10-30',N'Nữ','034 999 1331','thuylinhne92@gmail.com','2021-01-12')
Insert Into 
NHANVIEN(MSNV,HoTenNV,DiaChiNV,NgaySinhNV,GioiTinhNV,DienThoaiNV,EmailNV,NgayVaoLam)
Values('NV003',N'Trần Mạnh Cường',N'Hà Nội','1999-01-10',N'Nam','097 484 1999','cuongmanh99@gmail.com','2022-03-29')

--Nhập data cho bảng DOCGIA
--Tác dụng : thêm dữ liệu giả lập test hệ thống . bạn có dữ liệu cho tất cả bảng
Insert Into 
DOCGIA(MSDG,TenDG,DiaChi,NgaySinh,Email,GioiTinh,ThongTinKhac)
Values('MSD01',N'Nguyễn Văn Cường',N'Hà Nội','1993-05-19','cuongnv@gmail.com',N'Nam',N'Không')
Insert Into 
DOCGIA(MSDG,TenDG,DiaChi,NgaySinh,Email,GioiTinh,ThongTinKhac)
Values('MSD02',N'Trần Hoàng Khải',N'Hà Nam','1999-10-18','khaitran@gmail.com',N'Nam',N'Không')
Insert Into 
DOCGIA(MSDG,TenDG,DiaChi,NgaySinh,Email,GioiTinh,ThongTinKhac)
Values('MSD03',N'Đỗ Thị Hiền',N'Hà Nội','2000-08-28','hiendo@gmail.com',N'Nữ',N'Không')
Insert Into 
DOCGIA(MSDG,TenDG,DiaChi,NgaySinh,Email,GioiTinh,ThongTinKhac)
Values('MSD04',N'Nguyễn Thị Mai',N'Hà Giang','2002-01-11','mainguyen@gmail.com',N'Nữ',N'Không')
Insert Into 
DOCGIA(MSDG,TenDG,DiaChi,NgaySinh,Email,GioiTinh,ThongTinKhac)
Values('MSD05',N'Phí Mạnh Ý',N'Ninh Bình','1995-11-10','manhyphi@gmail.com',N'Nam',N'Không')
Insert Into 
DOCGIA(MSDG,TenDG,DiaChi,NgaySinh,Email,GioiTinh,ThongTinKhac)
Values('MSD06',N'Nguyễn Thị Loan',N'Nam Định','2003-05-22','loannguyen@gmail.com',N'Nữ',N'Không')
Insert Into 
DOCGIA(MSDG,TenDG,DiaChi,NgaySinh,Email,GioiTinh,ThongTinKhac)
Values('MSD07',N'Trần Hào Quang',N'Hà Giang','2002-12-12','haoquang@gmail.com',N'Nam',N'Không')
Insert Into 
DOCGIA(MSDG,TenDG,DiaChi,NgaySinh,Email,GioiTinh,ThongTinKhac)
Values('MSD08',N'Lung Thị Linh',N'Hà Nội','2003-06-20','lunglinh@gmail.com',N'Nữ',N'Không')
Insert Into 
DOCGIA(MSDG,TenDG,DiaChi,NgaySinh,Email,GioiTinh,ThongTinKhac)
Values('MSD09',N'Trần Thế Trung',N'Nam Định','1993-03-23','trungthe@gmail.com',N'Nam',N'Không')

--Nhập data cho bảng MUONSACH
Insert Into MUONSACH(SoPhieuMuon,MSDG,MSNV,NgayMuon)
Values('SPM01','MSD01','NV001','2023-02-10')
Insert Into MUONSACH(SoPhieuMuon,MSDG,MSNV,NgayMuon)
Values('SPM02','MSD03','NV002','2023-02-10')
Insert Into MUONSACH(SoPhieuMuon,MSDG,MSNV,NgayMuon)
Values('SPM03','MSD02','NV001','2023-02-15')
Insert Into MUONSACH(SoPhieuMuon,MSDG,MSNV,NgayMuon)
Values('SPM04','MSD05','NV002','2023-02-15')
Insert Into MUONSACH(SoPhieuMuon,MSDG,MSNV,NgayMuon)
Values('SPM05','MSD06','NV002','2023-02-19')
Insert Into MUONSACH(SoPhieuMuon,MSDG,MSNV,NgayMuon)
Values('SPM06','MSD04','NV003','2023-02-19')
Insert Into MUONSACH(SoPhieuMuon,MSDG,MSNV,NgayMuon)
Values('SPM07','MSD07','NV003','2023-02-25')
Insert Into MUONSACH(SoPhieuMuon,MSDG,MSNV,NgayMuon)
Values('SPM08','MSD08','NV002','2023-04-10')
Insert Into MUONSACH(SoPhieuMuon,MSDG,MSNV,NgayMuon)
Values('SPM09','MSD09','NV001','2023-04-10')

--Nhập data cho bảng CHITIETPHIEUMUON
Insert Into 
CHITIETPHIEUMUON(SoPhieuMuon,MSSach,HanTra)
Values('SPM01','MSS01','2023-02-20')
Insert Into 
CHITIETPHIEUMUON(SoPhieuMuon,MSSach,HanTra)
Values('SPM01','MSS02','2023-02-20')
Insert Into 
CHITIETPHIEUMUON(SoPhieuMuon,MSSach,HanTra)
Values('SPM02','MSS03','2023-02-20')
Insert Into 
CHITIETPHIEUMUON(SoPhieuMuon,MSSach,HanTra)
Values('SPM02','MSS05','2023-02-20')
Insert Into 
CHITIETPHIEUMUON(SoPhieuMuon,MSSach,HanTra)
Values('SPM03','MSS02','2023-02-25')
Insert Into 
CHITIETPHIEUMUON(SoPhieuMuon,MSSach,HanTra)
Values('SPM04','MSS05','2023-02-25')
Insert Into 
CHITIETPHIEUMUON(SoPhieuMuon,MSSach,HanTra)
Values('SPM05','MSS04','2023-03-29')
Insert Into 
CHITIETPHIEUMUON(SoPhieuMuon,MSSach,HanTra)
Values('SPM06','MSS07','2023-03-29')
Insert Into 
CHITIETPHIEUMUON(SoPhieuMuon,MSSach,HanTra)
Values('SPM07','MSS09','2023-04-05')
Insert Into 
CHITIETPHIEUMUON(SoPhieuMuon,MSSach,HanTra)
Values('SPM08','MSS06','2023-04-20')

--Nhập data cho bảnh TRASACH
Insert Into TRASACH(SoPhieuMuon,MSSach,MSNV,NgayTra)
Values('SPM01','MSS01','NV001','2023-02-15')
Insert Into TRASACH(SoPhieuMuon,MSSach,MSNV,NgayTra)
Values('SPM01','MSS02','NV002','2023-02-17')
Insert Into TRASACH(SoPhieuMuon,MSSach,MSNV,NgayTra)
Values('SPM02','MSS03','NV003','2023-02-18')
Insert Into TRASACH(SoPhieuMuon,MSSach,MSNV,NgayTra)
Values('SPM02','MSS05','NV003','2023-02-18')
Insert Into TRASACH(SoPhieuMuon,MSSach,MSNV,NgayTra)
Values('SPM03','MSS02','NV001','2023-02-20')
Insert Into TRASACH(SoPhieuMuon,MSSach,MSNV,NgayTra)
Values('SPM04','MSS05','NV002','2023-02-20')
Insert Into TRASACH(SoPhieuMuon,MSSach,MSNV,NgayTra)
Values('SPM05','MSS04','NV001','2023-03-30')
Insert Into TRASACH(SoPhieuMuon,MSSach,MSNV,NgayTra)
Values('SPM06','MSS07','NV003','2023-03-30')

--Nhập data cho bảng PHAT
Insert Into PHAT(MSSach,MSDG,LyDoPhat)
Values('MSS04','MSD05',N'Quá hạn')
Insert Into PHAT(MSSach,MSDG,LyDoPhat)
Values('MSS07','MSD04',N'Quá hạn')

--Câu 3Ràng buộc CHECK, DEFAULT (Mỗi SV 3 ràng buộc) ((1 điểm)
--Đề xuất tối thiểu 5 ràng buộc check, 1 DEFAULT
--Tạo các ràng buộc CHECK, DEFAULT.
--Thêm dữ liệu để kiểm tra các ràng buộc

--Check&Default
--Check : ràng buộc logic , ví dụ số lượng không âm
--Default : nếu người dùng không nhập NgayMuon, sẽ tự động lấy ngày hiện tại
ALTER TABLE QUYENSACH
ADD CONSTRAINT chk_SoLuong CHECK (SoLuong >= 0);

ALTER TABLE DOCGIA
ADD CONSTRAINT chk_GioiTinh CHECK (GioiTinh IN (N'Nam', N'Nữ'));

ALTER TABLE MUONSACH
ADD CONSTRAINT df_NgayMuon DEFAULT GETDATE() FOR NgayMuon;

ALTER TABLE QUYENSACH
ADD CONSTRAINT chk_NamXB CHECK (NamXB >= 1900);

ALTER TABLE QUYENSACH 
ADD CONSTRAINT chk_LanXB CHECK (LanXB >= 1);

ALTER TABLE NHANVIEN 
ADD CONSTRAINT chk_GioiTinhNV CHECK (GioiTinhNV IN (N'Nam', N'Nữ'));

ALTER TABLE NHANVIEN
ADD CONSTRAINT df_NgayVaoLam DEFAULT GETDATE() FOR NgayVaoLam;

ALTER TABLE DOCGIA 
ADD CONSTRAINT chk_Email CHECK (Email LIKE '%@%');

--Câu4Điều chỉnh 1 database ớ mức physical (Cả nhóm) (0.5 điểm)

--Ước lượng độ lớn database
--Điều chỉnh các file của database dựa trên ước lượng
--Tạo các file group, đặt dữ liệu của các table vào các file group phù hợp 
--Đề xuất các chỉ mục
--Tạo các chỉ mục

-- Ước lượng:
-- DOCGIA: ~1,000; QUYENSACH: ~5,000; MUONSACH: ~10,000; CHITIETPHIEUMUON: ~20,000

-- Tạo index:
CREATE INDEX idx_TenDG ON DOCGIA(TenDG);
CREATE INDEX idx_TenSach ON QUYENSACH(TenSach);
CREATE INDEX idx_NgayMuon ON MUONSACH(NgayMuon);

--Câu 6Viết các script (Mỗi SV 2 script) (1 điểm)

--Đề xuất các script\
--Viết các script

--5.Thao tác SQL
--Truy vấn dữ liệu để trả lời các câu hỏi quản lí như 
--Ai đã mượn/trả/quá hạn
--Tổng số sách là bao nhiêu
--Độc giả mượn nhiều nhất
--5.1,Update số lượng quyển sách có trong thư viện tăng lên 1
UPDATE QUYENSACH SET SoLuong = SoLuong + 1;
select * from QUYENSACH

--5.2, Số lượng độc giả mượn sách cùng 1 ngày
SELECT MS.NgayMuon,COUNT(DISTINCT MS.MSDG) AS N'Số Lượng'
FROM MUONSACH AS MS
GROUP BY MS.NgayMuon;

--5.3, Hiển thị tên độc giả đã tạo thẻ mượn sách
SELECT DISTINCT DG.TenDG
FROM MUONSACH AS MS, DOCGIA AS DG
WHERE MS.MSDG = DG.MSDG 

--5.4, Hiển thị danh sách các sách đã mượn sách
SELECT QS.TenSach, COUNT(QS.MSSach) AS N'Số Lượng'
FROM CHITIETPHIEUMUON AS CT, QUYENSACH AS QS
WHERE CT.MSSach = QS.MSSach
GROUP BY QS.TenSach

--5.5, Giảm số lượng sách còn lại trong thư viện khi đã cho mượn
UPDATE QUYENSACH 
SET SoLuong = SoLuong - (SELECT COUNT(*) FROM
CHITIETPHIEUMUON WHERE MSSach = QUYENSACH.MSSach)
GO

SELECT TenSach, SoLuong FROM QUYENSACH 

--5.6, Những độc giả đã mượn sách
SELECT DG.TenDG N'Tên Độc Giả'
FROM CHITIETPHIEUMUON AS CT, MUONSACH AS MS, DOCGIA AS DG
WHERE CT.SoPhieuMuon = MS.SoPhieuMuon
AND MS.MSDG = DG.MSDG
GROUP BY DG.TenDG

--5.7, Những độc giả đã trả sách
SELECT DG.TenDG
FROM TRASACH AS TS, CHITIETPHIEUMUON AS CT,
MUONSACH AS MS, DOCGIA AS DG
WHERE TS.SoPhieuMuon = CT.SoPhieuMuon AND MS.MSDG = 
DG.MSDG AND MS.SoPhieuMuon = CT.SoPhieuMuon 
GROUP BY DG.TenDG

--5.8, Những độc giả chưa trả sách và độc giả trả quá hạn
SELECT DISTINCT dg.TenDG
FROM DOCGIA AS dg
JOIN MUONSACH AS ms ON dg.MSDG =ms.MSDG
JOIN CHITIETPHIEUMUON AS ctpm ON ms.SoPhieuMuon = ctpm.SoPhieuMuon
LEFT JOIN TRASACH AS ts ON ctpm.SoPhieuMuon = ts.SoPhieuMuon AND ctpm.MSSach = ts.MSSach
WHERE ts.SoPhieuMuon IS NULL OR ts.NgayTra > ctpm.HanTra;

--5.9, Hiển thị những độc giả có giới tính là nữ và tuổi của họ
SELECT DG.TenDG , YEAR(GETDATE()) -
YEAR(DG.NgaySinh) AS N'Tuổi'
FROM DOCGIA AS DG
WHERE DG.Gioitinh = N'Nữ'

--5.10, Thêm cột tuổi bảng DOCGIA và cập nhật tuổi của các độc giả
ALTER TABLE DOCGIA ADD Tuoi INT;
GO

UPDATE DOCGIA SET Tuoi = YEAR(GETDATE()) - 
YEAR(DOCGIA.NgaySinh)
GO

SELECT * FROM DOCGIA

--5.11, Xóa cột tuổi bảng DOCGIA
ALTER TABLE DOCGIA
DROP COLUMN Tuoi;
GO

--5.12, Sắp xếp giảm dần theo tuổi của độc giả
SELECT DG.TenDG , YEAR(GETDATE()) - 
YEAR(DG.NgaySinh) AS N'Tuổi'
FROM DOCGIA AS DG
ORDER BY YEAR(GETDATE()) - YEAR(DG.NgaySinh) DESC

--5.13, Hiển thị danh sách độc giả đã mượn sách, nhân viên nào cho mượn
SELECT DG.TenDG N'Tên Độc Giả', NV.HoTenNV
FROM CHITIETPHIEUMUON AS CT, MUONSACH AS MS, DOCGIA AS DG, NHANVIEN AS NV
WHERE CT.SoPhieuMuon = MS.SoPhieuMuon AND MS.MSDG = DG.MSDG AND NV.MSNV = MS.MSNV 
GROUP BY DG.TenDG, NV.HoTenNV 

--5.14, Hiển thị tên sách có mã số MSS01
SELECT QS.TenSach
FROM QUYENSACH AS QS
WHERE QS.MSSach = 'MSS01'

--5.15, Hiển thị độc giả có họ là Nguyễn
SELECT * 
FROM DOCGIA AS DG
WHERE DG.TenDG LIKE N'Nguyễn%'

---5.16, Hiển thị NHANVIEN có tuổi lớn nhất
SELECT *, YEAR(GETDATE()) - YEAR(NgaySinhNV) AS N'Tuổi'
FROM NHANVIEN
WHERE YEAR(GETDATE()) - YEAR(NgaySinhNV) =
(SELECT MAX(YEAR(GETDATE()) - YEAR(NgaySinhNV)) FROM NHANVIEN)

--5.17, Hiển thị nhân viên vào làm lâu nhất
SELECT *, YEAR(GETDATE()) - YEAR(NgayVaoLam) AS N'Năm'
FROM NHANVIEN
WHERE YEAR(GETDATE()) - YEAR(NgayVaoLam) = 
(SELECT MAX(YEAR(GETDATE()) - YEAR(NgayVaoLam)) FROM NHANVIEN)

--5.18, Hiển thị tổng số sách trong thư viện
SELECT SUM(SoLuong) AS 'SL Sách'
FROM QUYENSACH

--5.19, Hiển thị tên, mã số độc giả, giới tính nam và tên, mã số nhân viên 
SELECT TenDG, MSDG, NULL AS MSNV FROM DOCGIA
WHERE GioiTinh = 'NAM'
UNION 
SELECT HoTenNV, NULL AS MSDG, MSNV FROM NHANVIEN

--5.20, Hiên thị thông tin và tên sách, tác giả và mã số nhà xuất bản của các cuốn sách thuộc thể loại "Lập trình'
SELECT TenSach, TacGia, MSNhaXB
FROM QUYENSACH
WHERE MaLoaiSach IN(
	SELECT MaLoaiSach
	FROM LOAISACH
	WHERE LoaiSach = N'Lập Trình'
)
--5.21, Liệt kê những độc giả có số lượng mượn sách lớn hơn 1
SELECT TenDG
FROM DOCGIA 
WHERE MSDG IN (
	SELECT MSDG
	FROM CHITIETPHIEUMUON AS CT, MUONSACH AS MS
	WHERE CT.SoPhieuMuon = MS.SoPhieuMuon
	GROUP BY MSDG
	HAVING COUNT(*) > 1
)
--5.22, In ra tên sách được mượn nhiều nhất và số lần mượn
DECLARE @TenSachMax NVARCHAR(50)
DECLARE @SoLanMuonMax INT 

SELECT TOP 1 @TenSachMax = QS.TenSach, @SoLanMuonMax = COUNT(QS.MSSach)
FROM MUONSACH AS MS
JOIN CHITIETPHIEUMUON AS CT ON MS.SoPhieuMuon = CT.SoPhieuMuon
JOIN QUYENSACH AS QS ON CT.MSSach = QS.MSSach
GROUP BY QS.TENSACH
ORDER BY COUNT(QS.MSSach)  DESC

SELECT @TenSachMax AS 'Tên sách', @SoLanMuonMax AS 'Số lần mượn'

--5.23, In ra tên sách có số lượng nhỏ nhất
DECLARE @MIN INT
SELECT @MIN = MIN(SoLuong)
FROM QUYENSACH 
SELECT TenSach, @MIN
FROM QUYENSACH AS QS
WHERE QS.SoLuong = @MIN

--5.24, So sánh tuổi của 2 nhân viên có mã là NV001 và NV002, sau đó in ra ai lớn hơn
DECLARE @AGE_NV1 INT
DECLARE @AGE_NV2 INT

SELECT @AGE_NV1 = YEAR(GETDATE()) - YEAR(NgaySinhNV)
FROM NHANVIEN WHERE MSNV = 'NV001'
SELECT @AGE_NV2 = YEAR(GETDATE()) - YEAR(NgaySinhNV)
FROM NHANVIEN WHERE MSNV = 'NV002'

IF(@AGE_NV1 > @AGE_NV2)
	BEGIN 
	PRINT N'Nhân viên 1 lớn tuổi hơn'
	PRINT @AGE_NV1
	PRINT @AGE_NV2
	END
ELSE
	BEGIN
	PRINT N'Nhân viên 2 lớn tuổi hơn'
	PRINT @AGE_NV1
	PRINT @AGE_NV2
	END

--5.25, Tạo function truyền tuổi của 1 độc giả vào xem là số chẵn hay lẻ
--Kiểm tra số tuổi chẵn hay lẻ - dùng như hàm tiện ích nhỏ
CREATE FUNCTION UF_ISODD(@NUM INT)
RETURNS NVARCHAR(20)
AS
BEGIN 
	IF(@NUM % 2 = 0)
		RETURN N'Số Chẵn'
	ELSE 
		RETURN N'Số lẻ'

	RETURN N'Không xác định'
END
GO

DECLARE @TUOI INT
SELECT @TUOI = YEAR(GETDATE()) - YEAR(NgaySinh)
FROM DOCGIA WHERE MSDG = 'MSD02'
SELECT @TUOI AS N'Tuổi', dbo.UF_ISODD(@TUOI) AS N'Loại'
GO

--Câu 5Tạo view  (Mỗi SV 5 view) (1 điểm)

--Liệt kê các nhóm đối tượng người dùng
--Đề xuất các view cho các nhóm đối tượng người dùng 
--Tạo các view
--Tác dụng : Tạo "bảng ảo" giúp người dùng (ví dụ thủ thư) dễ xam thông tin như 
--Ai trả sách trễ
--Sách còn hàng
--Thống kê mượn
--View 
CREATE VIEW V_DanhSachSachConHang AS
SELECT MSSach, TenSach FROM QUYENSACH WHERE SoLuong > 0;

CREATE VIEW V_DocGiaQuaHan AS
SELECT DG.TenDG FROM DOCGIA DG
JOIN MUONSACH MS ON DG.MSDG = MS.MSDG
JOIN CHITIETPHIEUMUON CT ON MS.SoPhieuMuon = CT.SoPhieuMuon
LEFT JOIN TRASACH TS ON CT.SoPhieuMuon = TS.SoPhieuMuon AND CT.MSSach = TS.MSSach
WHERE TS.NgayTra > CT.HanTra OR TS.SoPhieuMuon IS NULL;

CREATE VIEW V_DanhSachMuon AS
SELECT MS.SoPhieuMuon, DG.TenDG, NV.HoTenNV
FROM MUONSACH MS
JOIN DOCGIA DG ON MS.MSDG = DG.MSDG
JOIN NHANVIEN NV ON MS.MSNV = NV.MSNV;

CREATE VIEW V_ThongKeMuonSach AS
SELECT MSSach, COUNT(*) AS SoLanMuon
FROM CHITIETPHIEUMUON
GROUP BY MSSach;

CREATE VIEW V_TraQuaHan AS
SELECT DG.TenDG, QS.TenSach, CT.HanTra, TS.NgayTra
FROM DOCGIA DG
JOIN MUONSACH MS ON DG.MSDG = MS.MSDG
JOIN CHITIETPHIEUMUON CT ON MS.SoPhieuMuon = CT.SoPhieuMuon
JOIN TRASACH TS ON TS.SoPhieuMuon = CT.SoPhieuMuon AND TS.MSSach = CT.MSSach
JOIN QUYENSACH QS ON QS.MSSach = CT.MSSach
WHERE TS.NgayTra > CT.HanTra;

CREATE VIEW V_NhanVienTreNhat AS
SELECT TOP 1 * FROM NHANVIEN ORDER BY NgaySinhNV DESC;

CREATE VIEW V_DocGiaMoiTao AS
SELECT TOP 3 * FROM DOCGIA ORDER BY NgaySinh DESC;

CREATE VIEW V_SachTheoTheLoai AS
SELECT LoaiSach, COUNT(*) AS SoLuong
FROM QUYENSACH Q JOIN LOAISACH L ON Q.MaLoaiSach = L.MaLoaiSach
GROUP BY LoaiSach;

CREATE VIEW V_SachHetHang AS
SELECT * FROM QUYENSACH WHERE SoLuong = 0;

CREATE VIEW V_DocGiaTheoTinhThanh AS
SELECT DiaChi, COUNT(*) AS SoDocGia
FROM DOCGIA
GROUP BY DiaChi;

--Câu 7Stored Procedure (Mỗi SV 3 script) (1 điểm)

--Đề xuất các Stored Procedure
--Viết các Stored Procedure
--Chạy thử các Stored Procedure

--Stored Procedure
--Tác dụng : thủ tục lưu sẵn , giúp thực hiện nhanh một hành động như
--Thêm độc giả mới
--Ghi nhận phiếu mượn
--Xóa độc giả
CREATE PROCEDURE sp_ThemDocGia
    @MSDG CHAR(50), @TenDG NVARCHAR(100), @NgaySinh DATE
AS
BEGIN
    INSERT INTO DOCGIA (MSDG, TenDG, NgaySinh) VALUES (@MSDG, @TenDG, @NgaySinh);
END

CREATE PROCEDURE sp_MuonSach
    @SoPhieu CHAR(50), @MSDG CHAR(50), @MSNV CHAR(50), @NgayMuon DATE
AS
BEGIN
    INSERT INTO MUONSACH VALUES (@SoPhieu, @MSDG, @MSNV, @NgayMuon);
END
GO

CREATE PROCEDURE sp_XoaDocGia
    @MSDG CHAR(50)
AS
BEGIN
    DELETE FROM DOCGIA WHERE MSDG = @MSDG;
END
GO

CREATE PROCEDURE sp_TraSach
    @SoPhieu CHAR(50), @MSSach CHAR(50), @MSNV CHAR(50), @NgayTra DATE
AS
BEGIN
    INSERT INTO TRASACH VALUES (@SoPhieu, @MSSach, @MSNV, @NgayTra)
END
GO

CREATE PROCEDURE sp_ThemNhanVien
    @MSNV CHAR(50), @HoTen NVARCHAR(100)
AS
BEGIN
    INSERT INTO NHANVIEN (MSNV, HoTenNV) VALUES (@MSNV, @HoTen)
END
GO

CREATE PROCEDURE sp_XoaSach
    @MSSach CHAR(50)
AS
BEGIN
    DELETE FROM QUYENSACH WHERE MSSach = @MSSach
END
GO

--Câu 8 Trigger (Mỗi SV 2 Trigger) 
--Đề xuất các Trigger
--Viết các Trigger
--Chạy thử các Trigger

--Trigger
--Tác dụng Tự động chạy khi có thao tác INSERT
--ví dụ : nếu mượn sách mà sách đã hết -> chặn lại bảng Raiserror
CREATE TRIGGER trg_KiemTraSoLuong
ON CHITIETPHIEUMUON
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted i
        JOIN QUYENSACH q ON i.MSSach = q.MSSach
        WHERE q.SoLuong <= 0
    )
    BEGIN
        RAISERROR('Sách đã hết hàng!', 16, 1);
        ROLLBACK;
    END
END

CREATE TRIGGER trg_LogXoaSach
ON QUYENSACH
AFTER DELETE
AS
BEGIN
    PRINT N'Một quyển sách đã bị xóa khỏi hệ thống.';
END;
GO

-- Ghi log khi xóa độc giả
CREATE TRIGGER trg_LogXoaDocGia
ON DOCGIA
AFTER DELETE
AS
BEGIN
    PRINT N'Một độc giả đã bị xóa.';
END;
GO

-- Kiểm tra email độc giả hợp lệ trước khi INSERT
CREATE TRIGGER trg_KiemTraEmailDocGia
ON DOCGIA
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Email NOT LIKE '%@%')
    BEGIN
        RAISERROR('Email không hợp lệ.', 16, 1);
        RETURN;
    END
    ELSE
    BEGIN
        INSERT INTO DOCGIA SELECT * FROM inserted
    END
END;
GO

--Câu 9 User (làm chung cả nhóm) (0.75 điểm)

--Đề xuất các nhóm user, tạo các role trên đề xuất này
--Phân quyền cho các role
--Tạo user (vị trí làm việc của user) , đưa các user này vào các nhóm phù hợp
--Kiểm thử quyền của user
-- Tác dụng:
--Tạo nhóm người dùng (role) như ThuThu, QuanLy
--Cấp quyền SELECT/INSERT cho role
--Tạo user & gán vào role đó
-- Tạo User
--User
-- Tạo role
CREATE ROLE ThuThu;
CREATE ROLE QuanLy;

-- Phân quyền
GRANT SELECT, INSERT ON QUYENSACH TO ThuThu;
GRANT SELECT, INSERT, UPDATE, DELETE ON QUYENSACH TO QuanLy;


CREATE LOGIN UserThuThu WITH PASSWORD = '123456';
CREATE USER UserThuThu FOR LOGIN UserThuThu;
EXEC sp_addrolemember 'ThuThu', 'UserThuThu';

--Câu 10Import – Export- Back up - Restore: (trình bày step by step) (Cả nhóm) (0.75 điểm)

--Đề xuất các tình huống import, export dữ liệu. 
--Chuẩn bị data cho import dữ liệu
--Thực hiện import, export
--Lên các kế hoạch sao lưu . Giả lập thực hiện.
--Tác dụng:
--Backup: Lưu lại toàn bộ CSDL → dùng khi gặp sự cố.
--Restore: Phục hồi lại từ file backup.
--Import: Thêm dữ liệu từ file ngoài (CSV...).
--Export: Có thể dùng Wizard trong SSMS để xuất dữ liệu ra Excel/CSV.
--Import/Export/Backup
-- Backup
BACKUP DATABASE QL_THUVIEN TO DISK = 'D:\Backup\QL_THUVIEN.bak'

-- Restore
RESTORE DATABASE QL_THUVIEN FROM DISK = 'D:\Backup\QL_THUVIEN.bak' WITH REPLACE

-- Import CSV
BULK INSERT DOCGIA
FROM 'D:\data\docgia.csv'
WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', FIRSTROW = 2)















