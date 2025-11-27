CREATE DATABASE QL_THUVIEN
GO

USE QL_THUVIEN
GO

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

--t?o khóa ngo?i

Alter table QUYENSACH
	add constraint FK_QS_MLS
	foreign key (MaLoaiSach)
	references LOAISACH(MaLoaiSach)
	go

Alter table QUYENSACH
	add constraint FK_QS_MSNXB
	foreign key (MSNhaXB)
	references NHAXUATBAN(MSNXB)
	go

Alter table CHITIETPHIEUMUON
	add constraint FK_PM_MSSach
	foreign key (MSSach)
	references QUYENSACH(MSSach)
	go

Alter table CHITIETPHIEUMUON
	add constraint FK_PM_SPM
	foreign key (SoPhieuMua)
	references MUONSACH(SoPhieuMuon)
	go

Alter table MUONSACH
	add constraint FK_MS_MSNV
	foreign key (MSNV)
	references NHANVIEN(MSNV)
	go

Alter table MUONSACH
	add constraint FK_MS_MSDG
	foreign key (MSDG)
	references DOCGIA(MSDG)
	go

Alter table TRASACH
	add constraint FK_TS_MSNV
	foreign key (MSNV)
	references NHANVIEN(MSNV)
	go
Alter table TRASACH
	add constraint FK_TS_MSSACH
	foreign key	(MSSach)
	references QUYENSACH(MSSach)
	go
Alter table TRASACH
	add constraint	FK_TS_SPM
	foreign key	(SoPhieuMuon)
	references	MUONSACH(SoPhieuMuon)
	go

Alter table PHAT
	add constraint FK_P_MSDG
	foreign key (MSDG)
	references	DOCGIA(MSDG)
	go
Alter table PHAT
	add constraint	FK_P_MSSach
	foreign key	(MSSach)
	references	QUYENSACH(MSSach)
	go