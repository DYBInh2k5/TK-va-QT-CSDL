--Bài tập nhóm quản lí thư viện
--Thành viên : Võ Duy Bình , Dương Tấn Phát
--Câu 1ER Diagram - Mapping to Relational Diagram

--Câu 2Viết các lệnh tạo Database – Table – Primary key – Foreign key, nhập dữ liệu (1 điểm)

--1. Tạo database và sử dụng database
-- Tạo CSDL mới có tên QL_THUVIEN 
CREATE DATABASE QL_THUVIEN       -- Tạo một cơ sở dữ liệu mới có tên là QL_THUVIEN (Quản Lý Thư Viện)
GO                                -- Kết thúc batch lệnh để thực thi tạo database

USE QL_THUVIEN                   -- Chuyển ngữ cảnh làm việc sang cơ sở dữ liệu QL_THUVIEN
GO                                -- Bắt đầu thực hiện các lệnh tiếp theo trong CSDL này

--2. Tạo bảng và khóa chính
--Lưu thông tin table 
-- Tạo bảng QUYENSACH: quản lý thông tin sách trong thư viện
CREATE TABLE QUYENSACH (
	MSSach char(50),                   -- Mã số sách (Khóa chính)
	TenSach nvarchar(100),            -- Tên sách (Unicode, tối đa 100 ký tự)
	TacGia nvarchar(100),             -- Tên tác giả
	MSNhaXB Char(50),                 -- Mã số nhà xuất bản (khóa ngoại sau này)
	MaLoaiSach char(50),              -- Mã loại sách (khóa ngoại sau này)
	NamXB int,                        -- Năm xuất bản
	LanXB int,                        -- Lần xuất bản
	SoLuong int,                      -- Số lượng sách còn
	NoiDungTomLuoc Nvarchar(200),     -- Mô tả ngắn nội dung sách
	Primary Key (MSSach)              -- Đặt MSSach là khóa chính (duy nhất)
)
GO

-- Tạo bảng DOCGIA: lưu thông tin độc giả
CREATE TABLE DOCGIA (
	MSDG char(50),                    -- Mã số độc giả (Khóa chính)
	TenDG nvarchar(100),              -- Tên độc giả
	DiaChi nvarchar(200),             -- Địa chỉ liên hệ
	NgaySinh date,                    -- Ngày sinh
	Email char(100),                  -- Email
	GioiTinh nchar(3),                -- Giới tính (Nam/Nữ)
	ThongTinKhac nvarchar(200),       -- Thông tin thêm (ghi chú)
	Primary Key (MSDG)                -- MSDG là khóa chính
)
GO

-- Tạo bảng NHANVIEN: lưu thông tin nhân viên thư viện
CREATE TABLE NHANVIEN (
	MSNV char(50),                    -- Mã số nhân viên (Khóa chính)
	HoTenNV nvarchar(100),            -- Họ tên nhân viên
	DiaChiNV nvarchar(200),           -- Địa chỉ nhân viên
	NgaySinhNV date,                  -- Ngày sinh nhân viên
	GioiTinhNV nchar(3),              -- Giới tính
	DienThoaiNV char(50),             -- Số điện thoại
	EmailNV char(100),                -- Email
	NgayVaoLam date,                  -- Ngày bắt đầu làm việc
	PRIMARY KEY (MSNV)                -- MSNV là khóa chính
)
GO

-- Tạo bảng MUONSACH: lưu thông tin mỗi lần mượn sách
CREATE TABLE MUONSACH (
	SoPhieuMuon char(50),             -- Số phiếu mượn (Khóa chính)
	MSDG char(50),                    -- Mã độc giả (Khóa ngoại đến DOCGIA)
	MSNV char(50),                    -- Mã nhân viên cho mượn (Khóa ngoại đến NHANVIEN)
	NgayMuon date,                    -- Ngày mượn sách
	PRIMARY KEY (SoPhieuMuon)         -- Khóa chính là số phiếu mượn
)
GO

-- Tạo bảng CHITIETPHIEUMUON: chi tiết các cuốn sách trong mỗi phiếu mượn
CREATE TABLE CHITIETPHIEUMUON (
	SoPhieuMuon char(50),             -- Số phiếu mượn (Khóa chính 1)
	MSSach char(50),                  -- Mã sách mượn (Khóa chính 2)
	HanTra date,                      -- Hạn trả sách
	Primary key (SoPhieuMuon, MSSach) -- Khóa chính kép: mỗi sách chỉ xuất hiện 1 lần trong phiếu
)
GO


-- Tạo bảng LOAISACH: phân loại các đầu sách
CREATE TABLE LOAISACH (
	MaLoaiSach char(50),              -- Mã loại sách (Khóa chính)
	LoaiSach nvarchar(200),           -- Tên thể loại sách
	Primary key (MaLoaiSach)
)
GO

-- Tạo bảng PHAT: ghi lại các trường hợp phạt độc giả
CREATE TABLE PHAT (
	MSSach char(50),                  -- Mã sách vi phạm
	MSDG char(50),                    -- Mã độc giả bị phạt
	LyDoPhat nvarchar(200),           -- Lý do bị phạt
	Primary key (MSSach, MSDG)        -- Mỗi độc giả chỉ bị phạt 1 lần cho mỗi cuốn sách
)
GO

-- Tạo bảng NHAXUATBAN: thông tin nhà xuất bản
CREATE TABLE NHAXUATBAN (
	MSNXB char(50),                   -- Mã số NXB (Khóa chính)
	TenNXB nvarchar(200),             -- Tên nhà xuất bản
	DiaChiNXB nvarchar(200),          -- Địa chỉ NXB
	WebSiteNXB char(100),             -- Website NXB
	ThongTinKhac nvarchar(200),       -- Thông tin thêm
	Primary Key (MSNXB)
)
GO

-- Tạo bảng TRASACH: lưu thông tin trả sách
CREATE TABLE TRASACH (
	SoPhieuMuon char(50),             -- Số phiếu mượn (Khóa chính 1)
	MSSach char(50),                  -- Mã sách trả (Khóa chính 2)
	MSNV char(50),                    -- Mã nhân viên xử lý trả
	NgayTra date,                     -- Ngày trả sách
	Primary key (SoPhieuMuon, MSSach) -- Khóa chính kép: 1 sách chỉ trả 1 lần trong 1 phiếu
)
GO


--3.Tạo khóa ngoại
-- Tạo khóa ngoại từ bảng QUYENSACH đến bảng LOAISACH
ALTER TABLE QUYENSACH
	ADD CONSTRAINT FK_QS_MLS                      -- Tên constraint: Khóa ngoại từ Quyensach → Maloaisach
	FOREIGN KEY (MaLoaiSach)                      -- Cột MaLoaiSach trong bảng QUYENSACH
	REFERENCES LOAISACH(MaLoaiSach)               -- Phải tồn tại trong bảng LOAISACH
GO

-- Tạo khóa ngoại từ bảng QUYENSACH đến NHAXUATBAN
ALTER TABLE QUYENSACH
	ADD CONSTRAINT FK_QS_MSNXB                    -- Khóa ngoại từ Quyensach → NHAXUATBAN
	FOREIGN KEY (MSNhaXB)
	REFERENCES NHAXUATBAN(MSNXB)                  -- Đảm bảo mỗi quyển sách phải có nhà xuất bản hợp lệ
GO

-- Tạo khóa ngoại từ CHITIETPHIEUMUON → QUYENSACH
ALTER TABLE CHITIETPHIEUMUON
	ADD CONSTRAINT FK_PM_MSSach                   -- FK: mã sách mượn
	FOREIGN KEY (MSSach)
	REFERENCES QUYENSACH(MSSach)                  -- Mỗi dòng mượn sách phải trỏ đến 1 cuốn sách có thật
GO

-- Tạo khóa ngoại từ CHITIETPHIEUMUON → MUONSACH
ALTER TABLE CHITIETPHIEUMUON
	ADD CONSTRAINT FK_PM_SPM
	FOREIGN KEY (SoPhieuMuon)
	REFERENCES MUONSACH(SoPhieuMuon)              -- Mỗi dòng mượn phải thuộc một phiếu mượn có thật
GO
-- Tạo khóa ngoại từ MUONSACH → NHANVIEN
ALTER TABLE MUONSACH
	ADD CONSTRAINT FK_MS_MSNV
	FOREIGN KEY (MSNV)
	REFERENCES NHANVIEN(MSNV)                     -- Người xử lý việc mượn sách phải là nhân viên hợp lệ
GO

--Tác dụng : Đảm bỏ MSDG trong bảng MUONSACH phải tồn tại trong bảng DOCGIA, tránh nhập sai độc giả
-- Tạo khóa ngoại từ MUONSACH → DOCGIA
ALTER TABLE MUONSACH
	ADD CONSTRAINT FK_MS_MSDG
	FOREIGN KEY (MSDG)
	REFERENCES DOCGIA(MSDG)                       -- Đảm bảo MSDG trong bảng MUONSACH phải tồn tại trong bảng DOCGIA
GO

-- Tạo khóa ngoại từ TRASACH → NHANVIEN
ALTER TABLE TRASACH
	ADD CONSTRAINT FK_TS_MSNV
	FOREIGN KEY (MSNV)
	REFERENCES NHANVIEN(MSNV)                     -- Người xử lý việc trả sách là nhân viên hợp lệ
GO

-- Tạo khóa ngoại từ TRASACH → QUYENSACH
ALTER TABLE TRASACH
	ADD CONSTRAINT FK_TS_MSSACH
	FOREIGN KEY (MSSach)
	REFERENCES QUYENSACH(MSSach)                  -- Mỗi dòng trả sách phải thuộc một cuốn sách có thật
GO

-- Tạo khóa ngoại từ TRASACH → MUONSACH
ALTER TABLE TRASACH
	ADD CONSTRAINT FK_TS_SPM
	FOREIGN KEY (SoPhieuMuon)
	REFERENCES MUONSACH(SoPhieuMuon)              -- Phiếu mượn trả phải trỏ đến phiếu mượn gốc
GO

-- Tạo khóa ngoại từ PHAT → DOCGIA
ALTER TABLE PHAT
	ADD CONSTRAINT FK_P_MSDG
	FOREIGN KEY (MSDG)
	REFERENCES DOCGIA(MSDG)                       -- Người bị phạt phải là độc giả có thật
GO

-- Tạo khóa ngoại từ PHAT → QUYENSACH
ALTER TABLE PHAT
	ADD CONSTRAINT FK_P_MSSach
	FOREIGN KEY (MSSach)
	REFERENCES QUYENSACH(MSSach)                  -- Cuốn sách vi phạm phải là sách tồn tại trong hệ thống
GO


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

-- Ước lượng độ lớn dữ liệu theo bảng:
-- DOCGIA: ~1.000 dòng     → bảng độc giả (vừa phải)
-- QUYENSACH: ~5.000 dòng → bảng lưu sách (lớn hơn)
-- MUONSACH: ~10.000 dòng → bảng phiếu mượn (lớn)
-- CHITIETPHIEUMUON: ~20.000 dòng → chi tiết mượn (rất lớn)

-- Gợi ý: Những bảng có từ vài nghìn bản ghi trở lên nên được tối ưu bằng chỉ mục (index)


-- Tạo chỉ mục (index) để tăng hiệu năng truy vấn

CREATE INDEX idx_TenDG ON DOCGIA(TenDG);
-- Mục đích: tăng tốc độ tìm kiếm độc giả theo tên
-- Ứng dụng: SELECT * FROM DOCGIA WHERE TenDG = 'Nguyễn Văn A'

CREATE INDEX idx_TenSach ON QUYENSACH(TenSach);
-- Mục đích: tăng hiệu năng khi tìm kiếm sách theo tên
-- Ứng dụng: SELECT * FROM QUYENSACH WHERE TenSach LIKE N'%SQL%'

CREATE INDEX idx_NgayMuon ON MUONSACH(NgayMuon);
-- Mục đích: giúp truy vấn thống kê số lượng mượn theo ngày nhanh hơn
-- Ứng dụng: SELECT COUNT(*) FROM MUONSACH WHERE NgayMuon BETWEEN '2024-01-01' AND '2024-12-31'


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
-- View 1: Liệt kê những sách còn tồn trong thư viện (sách > 0)
CREATE VIEW V_DanhSachSachConHang AS
SELECT MSSach, TenSach 
FROM QUYENSACH 
WHERE SoLuong > 0;
-- Người dùng: Thủ thư, quản lý
-- Mục đích: Giúp biết những sách còn để sẵn sàng cho mượn

-- View 2: Liệt kê độc giả đã mượn sách nhưng chưa trả hoặc trả trễ
CREATE VIEW V_DocGiaQuaHan AS
SELECT DG.TenDG 
FROM DOCGIA DG
JOIN MUONSACH MS ON DG.MSDG = MS.MSDG
JOIN CHITIETPHIEUMUON CT ON MS.SoPhieuMuon = CT.SoPhieuMuon
LEFT JOIN TRASACH TS ON CT.SoPhieuMuon = TS.SoPhieuMuon AND CT.MSSach = TS.MSSach
WHERE TS.NgayTra > CT.HanTra OR TS.SoPhieuMuon IS NULL;
-- Người dùng: Quản lý, nhân viên xử lý trả
-- Mục đích: Theo dõi những ai đang nợ sách

-- View 3: Hiển thị danh sách các phiếu mượn với người mượn và nhân viên phụ trách
CREATE VIEW V_DanhSachMuon AS
SELECT MS.SoPhieuMuon, DG.TenDG, NV.HoTenNV
FROM MUONSACH MS
JOIN DOCGIA DG ON MS.MSDG = DG.MSDG
JOIN NHANVIEN NV ON MS.MSNV = NV.MSNV;
-- Người dùng: Nhân viên mượn/trả
-- Mục đích: Theo dõi lịch sử phiếu mượn

-- View 4: Thống kê số lần mượn của từng cuốn sách
CREATE VIEW V_ThongKeMuonSach AS
SELECT MSSach, COUNT(*) AS SoLanMuon
FROM CHITIETPHIEUMUON
GROUP BY MSSach;
-- Người dùng: Quản lý thư viện
-- Mục đích: Biết sách nào mượn nhiều → phục vụ mua thêm, ưu tiên

-- View 5: Liệt kê những trường hợp trả sách quá hạn
CREATE VIEW V_TraQuaHan AS
SELECT DG.TenDG, QS.TenSach, CT.HanTra, TS.NgayTra
FROM DOCGIA DG
JOIN MUONSACH MS ON DG.MSDG = MS.MSDG
JOIN CHITIETPHIEUMUON CT ON MS.SoPhieuMuon = CT.SoPhieuMuon
JOIN TRASACH TS ON TS.SoPhieuMuon = CT.SoPhieuMuon AND TS.MSSach = CT.MSSach
JOIN QUYENSACH QS ON QS.MSSach = CT.MSSach
WHERE TS.NgayTra > CT.HanTra;
-- Người dùng: Thủ thư, người quản lý xử lý phạt
-- Mục đích: Xác định người trả trễ để xử lý phạt

-- View 6: Nhân viên trẻ nhất trong hệ thống
CREATE VIEW V_NhanVienTreNhat AS
SELECT TOP 1 * 
FROM NHANVIEN 
ORDER BY NgaySinhNV DESC;
-- Người dùng: Quản lý
-- Mục đích: Biết nhân viên trẻ nhất (nâng cao)

-- View 7: 3 độc giả sinh gần đây nhất (có thể là đăng ký mới)
CREATE VIEW V_DocGiaMoiTao AS
SELECT TOP 3 * 
FROM DOCGIA 
ORDER BY NgaySinh DESC;
-- Người dùng: Quản lý
-- Mục đích: Biết nhóm độc giả mới nhất để chăm sóc

-- View 8: Thống kê số lượng sách theo từng thể loại
CREATE VIEW V_SachTheoTheLoai AS
SELECT LoaiSach, COUNT(*) AS SoLuong
FROM QUYENSACH Q 
JOIN LOAISACH L ON Q.MaLoaiSach = L.MaLoaiSach
GROUP BY LoaiSach;
-- Người dùng: Quản lý kho sách
-- Mục đích: Biết thể loại nào đang phổ biến, số lượng ra sao

-- View 9: Liệt kê những sách hết hàng (số lượng = 0)
CREATE VIEW V_SachHetHang AS
SELECT * 
FROM QUYENSACH 
WHERE SoLuong = 0;
-- Người dùng: Quản lý mua sách
-- Mục đích: Phát hiện sách nào cần mua thêm

-- View 10: Thống kê số lượng độc giả theo từng địa chỉ/tỉnh thành
CREATE VIEW V_DocGiaTheoTinhThanh AS
SELECT DiaChi, COUNT(*) AS SoDocGia
FROM DOCGIA
GROUP BY DiaChi;
-- Người dùng: Quản lý
-- Mục đích: Biết phân bố độc giả theo khu vực địa lý


--Câu 7Stored Procedure (Mỗi SV 3 script) (1 điểm)

--Đề xuất các Stored Procedure
--Viết các Stored Procedure
--Chạy thử các Stored Procedure

--Stored Procedure
--Tác dụng : thủ tục lưu sẵn , giúp thực hiện nhanh một hành động như
--Thêm độc giả mới
--Ghi nhận phiếu mượn
--Xóa độc giả
-- Stored Procedure 1: Thêm một độc giả mới vào bảng DOCGIA
CREATE PROCEDURE sp_ThemDocGia
    @MSDG CHAR(50),                     -- Mã số độc giả
    @TenDG NVARCHAR(100),              -- Tên độc giả
    @NgaySinh DATE                     -- Ngày sinh
AS
BEGIN
    INSERT INTO DOCGIA (MSDG, TenDG, NgaySinh) 
    VALUES (@MSDG, @TenDG, @NgaySinh); -- Thêm dòng dữ liệu vào bảng DOCGIA
END
-- Người dùng: Thủ thư, nhân viên tiếp nhận
-- Mục đích: Tạo nhanh hồ sơ độc giả khi đăng ký mới

-- Stored Procedure 2: Ghi nhận một phiếu mượn mới
CREATE PROCEDURE sp_MuonSach
    @SoPhieu CHAR(50),                 -- Số phiếu mượn
    @MSDG CHAR(50),                    -- Mã độc giả
    @MSNV CHAR(50),                    -- Mã nhân viên xử lý
    @NgayMuon DATE                     -- Ngày mượn
AS
BEGIN
    INSERT INTO MUONSACH 
    VALUES (@SoPhieu, @MSDG, @MSNV, @NgayMuon);
END
GO
-- Người dùng: Thủ thư
-- Mục đích: Thực hiện thao tác mượn sách, ghi lại phiếu

-- Stored Procedure 3: Xóa một độc giả khỏi hệ thống
CREATE PROCEDURE sp_XoaDocGia
    @MSDG CHAR(50)                     -- Mã độc giả cần xóa
AS
BEGIN
    DELETE FROM DOCGIA 
    WHERE MSDG = @MSDG;                -- Xóa dòng dữ liệu theo mã
END
GO
-- Người dùng: Quản lý
-- Mục đích: Gỡ bỏ độc giả cũ, sai, hoặc vi phạm

-- Stored Procedure 4: Ghi nhận việc trả sách
CREATE PROCEDURE sp_TraSach
    @SoPhieu CHAR(50),                -- Số phiếu mượn
    @MSSach CHAR(50),                 -- Mã sách được trả
    @MSNV CHAR(50),                   -- Mã nhân viên tiếp nhận
    @NgayTra DATE                     -- Ngày trả
AS
BEGIN
    INSERT INTO TRASACH 
    VALUES (@SoPhieu, @MSSach, @MSNV, @NgayTra);
END
GO
-- Người dùng: Thủ thư, người xử lý trả sách
-- Mục đích: Lưu lịch sử trả sách và cập nhật hệ thống

-- Stored Procedure 5: Thêm một nhân viên mới vào bảng NHANVIEN
CREATE PROCEDURE sp_ThemNhanVien
    @MSNV CHAR(50),                   -- Mã nhân viên
    @HoTen NVARCHAR(100)             -- Họ tên nhân viên
AS
BEGIN
    INSERT INTO NHANVIEN (MSNV, HoTenNV) 
    VALUES (@MSNV, @HoTen);           -- Thêm nhân viên mới
END
GO
-- Người dùng: Quản lý nhân sự
-- Mục đích: Cập nhật danh sách nhân viên thư viện

-- Stored Procedure 6: Xóa một quyển sách khỏi hệ thống
CREATE PROCEDURE sp_XoaSach
    @MSSach CHAR(50)                  -- Mã sách cần xóa
AS
BEGIN
    DELETE FROM QUYENSACH 
    WHERE MSSach = @MSSach;           -- Xóa cuốn sách theo mã
END
GO
-- Người dùng: Quản lý thư viện
-- Mục đích: Xóa sách hư, sai, hoặc không còn sử dụng

--Câu 8 Trigger (Mỗi SV 2 Trigger) 
--Đề xuất các Trigger
--Viết các Trigger
--Chạy thử các Trigger

--Trigger
--Tác dụng Tự động chạy khi có thao tác INSERT
--ví dụ : nếu mượn sách mà sách đã hết -> chặn lại bảng Raiserror
-- Trigger 1: Kiểm tra số lượng sách còn trước khi thêm vào chi tiết phiếu mượn
CREATE TRIGGER trg_KiemTraSoLuong
ON CHITIETPHIEUMUON                 -- Gắn vào bảng CHITIETPHIEUMUON
AFTER INSERT                        -- Kích hoạt sau khi có lệnh INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted i
        JOIN QUYENSACH q ON i.MSSach = q.MSSach
        WHERE q.SoLuong <= 0         -- Nếu sách hết hàng
    )
    BEGIN
        RAISERROR('Sách đã hết hàng!', 16, 1);  -- Báo lỗi và hủy thao tác
        ROLLBACK;
    END
END
--Mục đích: Ngăn không cho mượn sách đã hết
--Người dùng tác động: Thủ thư, hệ thống
--Bảo vệ dữ liệu, tránh lỗi logic khi số lượng sách không đủ

-- Trigger 2: In thông báo khi xóa sách khỏi hệ thống
CREATE TRIGGER trg_LogXoaSach
ON QUYENSACH
AFTER DELETE
AS
BEGIN
    PRINT N'Một quyển sách đã bị xóa khỏi hệ thống.';
END;
GO
--Mục đích: Ghi log mỗi khi có sách bị xóa
--Người dùng: Quản lý
--Tăng tính minh bạch và theo dõi hành vi người dùng

-- Trigger 3: In thông báo khi xóa độc giả
CREATE TRIGGER trg_LogXoaDocGia
ON DOCGIA
AFTER DELETE
AS
BEGIN
    PRINT N'Một độc giả đã bị xóa.';
END;
GO
--Mục đích: Ghi log khi có người dùng xóa độc giả
--Người dùng: Quản lý thư viện
--Theo dõi hành vi, kiểm tra lịch sử chỉnh sửa dữ liệu

-- Trigger 4: Kiểm tra định dạng email của độc giả khi thêm mới
CREATE TRIGGER trg_KiemTraEmailDocGia
ON DOCGIA
INSTEAD OF INSERT                -- Thay thế thao tác INSERT gốc
AS
BEGIN
    IF EXISTS (
        SELECT * 
        FROM inserted 
        WHERE Email NOT LIKE '%@%'   -- Kiểm tra email không hợp lệ
    )
    BEGIN
        RAISERROR('Email không hợp lệ.', 16, 1); -- Thông báo lỗi
        RETURN;
    END
    ELSE
    BEGIN
        INSERT INTO DOCGIA SELECT * FROM inserted -- Nếu hợp lệ, thực hiện insert
    END
END;
GO
--Mục đích: Bảo vệ dữ liệu email đầu vào hợp lệ
--Người dùng: Nhân viên thêm độc giả
--Đảm bảo chất lượng dữ liệu, tránh lỗi do nhập sai định dạng

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
-- Tạo role (nhóm người dùng) tên là ThuThu
CREATE ROLE ThuThu;
--Mục đích: Nhóm dành cho nhân viên thủ thư (có quyền xem và thêm sách)

-- Tạo role (nhóm người dùng) tên là QuanLy
CREATE ROLE QuanLy;
--Mục đích: Nhóm dành cho quản lý thư viện (có toàn quyền trên dữ liệu sách)


-- Phân quyền cho nhóm ThuThu: được xem và thêm sách
GRANT SELECT, INSERT ON QUYENSACH TO ThuThu;

-- Phân quyền cho nhóm QuanLy: được xem, thêm, sửa, xóa sách
GRANT SELECT, INSERT, UPDATE, DELETE ON QUYENSACH TO QuanLy;
--Mục đích: Phân quyền chi tiết trên bảng QUYENSACH cho từng vai trò
--Bảo vệ dữ liệu, phân tách trách nhiệm rõ ràng

-- Tạo tài khoản đăng nhập SQL Server có tên UserThuThu
CREATE LOGIN UserThuThu WITH PASSWORD = '123456';

-- Tạo user trong database gắn với login bên trên
CREATE USER UserThuThu FOR LOGIN UserThuThu;

-- Thêm user này vào nhóm (role) ThuThu
EXEC sp_addrolemember 'ThuThu', 'UserThuThu';
--Kết quả: UserThuThu chỉ được SELECT và INSERT vào bảng QUYENSACH
--Khi người dùng này đăng nhập, họ sẽ bị giới hạn đúng theo quyền của role


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

-- Backup: sao lưu cơ sở dữ liệu QL_THUVIEN ra file QL_THUVIEN.bak
BACKUP DATABASE QL_THUVIEN TO DISK = 'D:\Backup\QL_THUVIEN.bak';
--Mục đích: Tạo bản sao dự phòng CSDL để khôi phục khi xảy ra sự cố
--Ứng dụng: Thực hiện định kỳ hàng tuần, hàng ngày hoặc trước khi nâng cấp hệ thống


-- Restore: khôi phục lại CSDL từ file backup đã tạo
RESTORE DATABASE QL_THUVIEN 
FROM DISK = 'D:\Backup\QL_THUVIEN.bak' 
WITH REPLACE;
--Mục đích: Phục hồi lại dữ liệu trong trường hợp mất mát, hỏng hóc hoặc rollback dữ liệu
--Lưu ý: WITH REPLACE ghi đè lên CSDL hiện có, nên cần cẩn trọng


-- Import dữ liệu từ file CSV vào bảng DOCGIA
BULK INSERT DOCGIA
FROM 'D:\data\docgia.csv'
WITH (
    FIELDTERMINATOR = ',',        -- Dữ liệu cách nhau bằng dấu phẩy
    ROWTERMINATOR = '\n',         -- Kết thúc mỗi dòng bằng xuống dòng
    FIRSTROW = 2                  -- Bỏ qua dòng đầu (tiêu đề cột)
);
--Mục đích: Nhập nhanh dữ liệu từ file Excel/CSV vào bảng trong SQL Server
--Ứng dụng: Khi cần thêm dữ liệu hàng loạt từ file bên ngoài
--Yêu cầu: File CSV phải có đường dẫn hợp lệ và SQL Server phải cho phép truy cập thư mục đó
















