
--Trigger
--1 T?o trigger tên trg_check_lblank ki?m tra khi nh?p ho?c s?a d? li?u các tr??ng fname,lname cho b?ng nhân viên có ch?a kí t? tr?ng bên trái? N?u có, h? th?ng c?n s? d?ng trigger ?? x? lý xóa b? các ký t? tr?ng này.
--L?nh
----SQL1
--SQL1
--SQL1
CREATE TRIGGER trg_check_lblank
ON Employee
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE EMPLOYEE
    SET fname = LTRIM(E.fname),
        lname = LTRIM(E.lname)
    FROM Employee e
    JOIN inserted i ON e.ssn = i.ssn;
END;
GO


--Vi?t câu l?nh th?c hi?n nh?p fname, lname r?ng (null) ho?c c?p nh?t fname, lname có ch?a ký t? tr?ng bên trái ?? ki?m ch?ng trigger v?a t?o.
--L?nh
----SQL1
-- Th? thêm d? li?u có kho?ng tr?ng ??u
INSERT INTO Employee (ssn, fname, lname, salary, Dno)
VALUES ('888665555', '   John', '   Smith', 40000, 5);

-- Ki?m tra l?i k?t qu?
SELECT fname, lname FROM Employee WHERE ssn = '888665555';


--2 T?o trigger tên trg_check_number ki?m tra khi nh?p ho?c s?a d? li?u cho tr??ng ssn,supperssn cho b?ng nhân viên b?t bu?c ph?i là 9 ký s?? 
--n?u nh?p sai h? th?ng c?n kích ho?t trigger ng?n ch?n không cho phép nh?p ?? ??m b?o tính ?úng ??n nh?p li?u vào b?ng và hi?n th? thông ?i?p h??ng d?n ng??i dùng nh?p l?i ?úng theo cú pháp: 111111111. 
--L?nh
----SQL1
--SQL1
CREATE TRIGGER trg_check_number
ON Employee
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM inserted
        WHERE LEN(ssn) != 9 OR ssn LIKE '%[^0-9]%' 
           OR (superssn IS NOT NULL AND (LEN(superssn) != 9 OR superssn LIKE '%[^0-9]%'))
    )
    BEGIN
        RAISERROR('ssn và superssn ph?i là 9 ch? s?. Ví d?: 111111111', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

	
--Th?c hi?n – K?t qu? (ki?m ch?ng)
-- Th? d? li?u sai
INSERT INTO Employee (ssn, fname, lname, salary, Dno)
VALUES ('abc123', 'Fake', 'Person', 30000, 5);

--3 Vi?t trigger tên trg_NoDel_Dept không cho phép xóa d? li?u b?ng phòng ban (Department) và khi hành ??ng di?n ra thì h? th?ng hi?n th? thông ?i?p 'Deletion of Department is not allowed', khôi ph?c tr?ng thái ban ??u nh? ch?a xóa.
--L?nh
----SQL1
--SQL1
CREATE TRIGGER trg_NoDel_Dept
ON Department
INSTEAD OF DELETE
AS
BEGIN
    PRINT 'Deletion of Department is not allowed';
    -- Không làm gì c?, nên không xóa
END;
GO

--Th?c hi?n – K?t qu? (ki?m ch?ng)
-- C? g?ng xóa
DELETE FROM Department WHERE Dnumber = 5;

--4 Vi?t trigger tên trg_NoUpdateName_Dept không cho phép s?a tên phòng ban.
--G?i ý: 
--BT10_TriggerCurTrans.docx		1
--a T?o 1 b?ng Temp v?i c?u trúc b?ng gi?ng b?ng Department nh? bên d??i.
--CREATE TABLE Temp
--(
--[DName] varchar(15),
--[DNumber] numeric(4,0),
--[Mgrssn] char(9),
--[MgrStartdate] datetime
--)
--b K? ti?p, t?o trigger INSTEAD OF UPDATE nh?p d? li?u vào b?ng Temp này.
--L?nh
----SQL1
--SQL1
CREATE TABLE Temp
(
    DName VARCHAR(15),
    DNumber NUMERIC(4,0),
    Mgrssn CHAR(9),
    MgrStartdate DATETIME
);
GO

CREATE TRIGGER trg_NoUpdateName_Dept
ON Department
INSTEAD OF UPDATE
AS
BEGIN
    INSERT INTO Temp (DName, DNumber, Mgrssn, MgrStartdate)
    SELECT d.DName, d.DNumber, d.Mgrssn, d.MgrStartDate
    FROM deleted d;

    PRINT 'Tên phòng ban không ???c s?a. D? li?u ?ã l?u vào b?ng Temp';
END;
GO

--Th?c hi?n – K?t qu? (ki?m ch?ng)
UPDATE Department
SET DName = 'NewName'
WHERE DNumber = 5;

-- Xem b?ng Temp
SELECT * FROM Temp;

--Ch?p màn hình k?t qu?

--5 Gi? s? sinh vien A ?ã t?o m?t csdl tên mysales g?m 2 b?ng tbl_product,tbl_order nh? bên d??i:
--L?nh
----SQL1
--create database mysales
--use mysales
--CREATE TABLE tbl_product
--(
--	ID INT IDENTITY(1,1) PRIMARY KEY,
--	productID varchar(15) NOT NULL UNIQUE,
--	productName NVARCHAR(200) NOT NULL UNIQUE,
--	productQTY DECIMAL(6,2),
--	productPrice DECIMAL(10,2) NOT NULL,
--	lineTotal DECIMAL(18,2),
--	productDate DATETIME NOT NULL
--)
--CREATE TABLE tbl_order
--(
--	orderID INT NOT NULL,
--	productID varchar(15) NOT NULL,
--	orderQty DECIMAL(6,2),
--	productName NVARCHAR(100),
--	TOTAL DECIMAL(18,2),
--	orderDate DATETIME DEFAULT GETDATE(),
--	CONSTRAINT PK_tbl_Order_OrderID_productID PRIMARY KEY(orderID,productID), 
--	CONSTRAINT FK_tbl_Order_productID FOREIGN KEY(productID) REFERENCES tbl_product(productID)
--)
----Yêu c?u:
--a. T?o trigger th?c hi?n tính t? ??ng lineTotal=productQTY*productPrice m?i khi nh?p ho?c c?p nh?t (thay ??i) d? li?u cho b?ng tbl_product
--SQL1
CREATE TRIGGER trg_calc_lineTotal
ON tbl_product
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE p
    SET lineTotal = p.productQTY * p.productPrice
    FROM tbl_product p
    JOIN inserted i ON p.productID = i.productID;
END;
GO

--b. T?o trigger th?c hi?n tính t? ??ng gi?m s? l??ng(productQTY)trong b?ng tbl_product m?i khi nh?p d? li?u theo t?ng mã s?n ph?m (productID) trên b?ng tbl_order
--SQL1
CREATE TRIGGER trg_reduce_productQTY
ON tbl_order
AFTER INSERT
AS
BEGIN
    UPDATE p
    SET p.productQTY = p.productQTY - i.orderQty
    FROM tbl_product p
    JOIN inserted i ON p.productID = i.productID;
END;
GO

--c. T?o trigger th?c hi?n tính t? ??ng c?p nh?t s? l??ng(productQTY)trong b?ng 
--SQL1
CREATE TRIGGER trg_update_productQTY
ON tbl_order
AFTER UPDATE
AS
BEGIN
    UPDATE p
    SET p.productQTY = p.productQTY + d.orderQty - i.orderQty
    FROM tbl_product p
    JOIN inserted i ON p.productID = i.productID
    JOIN deleted d ON i.productID = d.productID;
END;
GO

--SQL1
DISABLE TRIGGER trg_calc_lineTotal ON tbl_product;

ENABLE TRIGGER trg_calc_lineTotal ON tbl_product;

--SQL1
DROP TRIGGER trg_calc_lineTotal;

--BT10_TriggerCurTrans.docx		1
--tbl_product m?i khi c?p nh?t (thay ??i)d? li?u theo t?ng mã s?n ph?m (productID) trên b?ng tbl_order
---------------------- 
--L?nh
----SQL1
-----câu a

--L?nh
----SQL1
-----câu b

--L?nh
----SQL1
-----câu c

--Vi?t l?nh vô hi?u hóa trigger v?a t?o ? câu 1.
--L?nh
----SQL1

--Vi?t l?nh kích ho?t trigger v?a t?o ? câu 1.
--L?nh
----SQL1

--Vi?t l?nh xóa trigger v?a t?o câu 1.
--L?nh
----SQL1

--Cursor
--9 Li?t kê các b??c c? b?n ?? thao tác v?i cursor
--L?nh
----SQL1
--SQL1
DECLARE @ssn CHAR(9), @fname NVARCHAR(50), @lname NVARCHAR(50);

DECLARE cur_emp CURSOR FOR
SELECT ssn, fname, lname FROM Employee;

OPEN cur_emp;
FETCH NEXT FROM cur_emp INTO @ssn, @fname, @lname;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'SSN: ' + @ssn + ' | H? tên: ' + @fname + ' ' + @lname;
    FETCH NEXT FROM cur_emp INTO @ssn, @fname, @lname;
END;

CLOSE cur_emp;
DEALLOCATE cur_emp;

--Th?c hi?n – K?t qu? (ki?m ch?ng)

--10 T?o cursor tên cur_emp ?? truy c?p t?t c? các dòng k?t qu? tr? v? t? truy v?n rút trích thông tin các nhân viên b?ng nhân viên.
--L?nh
----SQL1
--SQL1
DECLARE @ssn CHAR(9), @fname NVARCHAR(50), @lname NVARCHAR(50), @salary NUMERIC(10,2);

-- Bước 1: Khai báo Cursor cur_emp
DECLARE cur_emp CURSOR FOR
SELECT ssn, fname, lname, salary
FROM Employee;

-- Bước 2: Mở Cursor
OPEN cur_emp;

-- Bước 3: Lấy dòng đầu tiên
FETCH NEXT FROM cur_emp INTO @ssn, @fname, @lname, @salary;

-- Bước 4: Duyệt và xử lý từng dòng
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'SSN: ' + @ssn + ' | Họ tên: ' + @fname + ' ' + @lname + ' | Lương: ' + CAST(@salary AS VARCHAR);
    
    FETCH NEXT FROM cur_emp INTO @ssn, @fname, @lname, @salary;
END;

-- Bước 5: Đóng cursor
CLOSE cur_emp;

-- Bước 6: Giải phóng bộ nhớ
DEALLOCATE cur_emp;

	

--11 T?o cursor tên cur_emp_3rows ?? truy c?p dòng k?t qu? tr? v? t? truy v?n rút trích thông tin các nhân viên b?ng nhân viên.
--L?nh
----SQL1
--SQL1
DECLARE @ssn CHAR(9), @fname NVARCHAR(50), @lname NVARCHAR(50), @salary NUMERIC(10,2);

-- Bước 1: Khai báo Cursor chỉ lấy 3 dòng
DECLARE cur_emp_3rows CURSOR FOR
SELECT TOP 3 ssn, fname, lname, salary
FROM Employee;

-- Bước 2: Mở Cursor
OPEN cur_emp_3rows;

-- Bước 3: Lấy dòng đầu tiên
FETCH NEXT FROM cur_emp_3rows INTO @ssn, @fname, @lname, @salary;

-- Bước 4: Duyệt từng dòng và hiển thị thông tin
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'SSN: ' + @ssn + ' | Họ tên: ' + @fname + ' ' + @lname + ' | Lương: ' + CAST(@salary AS VARCHAR);
    
    FETCH NEXT FROM cur_emp_3rows INTO @ssn, @fname, @lname, @salary;
END;

-- Bước 5: Đóng Cursor
CLOSE cur_emp_3rows;

-- Bước 6: Giải phóng bộ nhớ
DEALLOCATE cur_emp_3rows;


--Transaction
--12 Gi? s? sinh vien A ?ã t?o m?t csdl tên myDB g?m 2 b?ng tabProducts, tabEmployees.
--create database myDB
--go
--create table tabEmployees
--BT10_TriggerCurTrans.docx		1
--(
--Id int constraint pk_tabEmp primary key,
--Name varchar(100),
--Gender Char(1)
--);
--Go
--create table tabProducts
--(
--Id int constraint pk_tabPro primary key,
--Name varchar(100),
--Quantity int
--);
--Go
--Sau ?ó nh?p d? li?u vào b?ng gi?ng slide 68, slide 76 ???c cung c?p trong t?p tin DB11_TriggerCussorTrans.pptx.
--Yêu c?u:
--Vi?t câu l?nh t?o các transaction 1, 2 gi?ng Slide 69 và ch?p màn hình k?t qu?.
--L?nh
----SQL1

--K?t qu? ki?m ch?ng
--SQL1
CREATE DATABASE myDB;
GO

USE myDB;
GO

CREATE TABLE tabEmployees (
    Id INT CONSTRAINT pk_tabEmp PRIMARY KEY,
    Name VARCHAR(100),
    Gender CHAR(1)
);
GO

CREATE TABLE tabProducts (
    Id INT CONSTRAINT pk_tabPro PRIMARY KEY,
    Name VARCHAR(100),
    Quantity INT
);
GO

--SQL1
INSERT INTO tabEmployees VALUES (1, 'Nguyen Van A', 'M');
INSERT INTO tabEmployees VALUES (2, 'Tran Thi B', 'F');
INSERT INTO tabEmployees VALUES (3, 'Le Van C', 'M');

INSERT INTO tabProducts VALUES (1, 'Laptop Acer', 10);
INSERT INTO tabProducts VALUES (2, 'iPhone 15', 5);
INSERT INTO tabProducts VALUES (3, 'Chuột không dây', 50);

--SQL1
BEGIN TRANSACTION;

INSERT INTO tabEmployees VALUES (4, 'Pham Thi D', 'F');
INSERT INTO tabProducts VALUES (4, 'Bàn phím cơ', 20);

COMMIT;

--SQL1
BEGIN TRANSACTION;

-- Chèn đúng
INSERT INTO tabEmployees VALUES (5, 'Vo Duy Binh', 'M');

-- Câu sau cố tình gây lỗi (trùng khóa chính)
INSERT INTO tabEmployees VALUES (1, 'Trung Duplicate', 'M');

-- Kiểm tra lỗi và rollback nếu có
IF @@ERROR <> 0
BEGIN
    ROLLBACK;
    PRINT '❌ Có lỗi xảy ra! Đã rollback toàn bộ Transaction.';
END
ELSE
BEGIN
    COMMIT;
    PRINT '✅ Transaction thành công.';
END

SELECT * FROM tabEmployees;
SELECT * FROM tabProducts;

--13Vi?t câu l?nh t?o các transaction 1, 2 gi?ng Slide 71 và ch?p màn hình k?t qu?.
--L?nh
----SQL1
--SQL1 -- Transaction 1 - Tạm giữ thay đổi
BEGIN TRANSACTION;

UPDATE tabProducts
SET Quantity = Quantity - 2
WHERE Id = 1; -- Laptop Acer

-- Kiểm tra tạm thời trong T1
SELECT * FROM tabProducts WHERE Id = 1;

-- Lưu ý: KHÔNG COMMIT ngay → Giữ nguyên trạng thái để kiểm chứng từ T2
-- COMMIT sẽ thực hiện sau để quan sát hiệu ứng

--SQL1 -- Transaction 2 - Đọc dữ liệu bị ảnh hưởng
SELECT * FROM tabProducts WHERE Id = 1;

--K?t qu? ki?m ch?ng

--14Vi?t câu l?nh t?o các transaction 1, 2 gi?ng Slide 73 và ch?p màn hình k?t qu?.
--L?nh
----SQL1

--K?t qu? ki?m ch?ng
--SQL1 -- Transaction 1
BEGIN TRANSACTION;

-- Lấy thông tin ban đầu
SELECT * FROM tabProducts WHERE Id = 2;

-- Giả lập người dùng cập nhật tồn kho sản phẩm 2 (iPhone 15)
UPDATE tabProducts
SET Quantity = Quantity - 1
WHERE Id = 2;

-- KHÔNG COMMIT ngay để giữ lại giao dịch đang mở
-- Chờ T2 can thiệp để kiểm chứng Lost Update

-- Bạn có thể COMMIT sau để kiểm tra kết quả
-- COMMIT;
--SQL1 -- Transaction 2
BEGIN TRANSACTION;

-- Đọc thông tin (trước khi T1 commit)
SELECT * FROM tabProducts WHERE Id = 2;

-- Cập nhật tồn kho tiếp (có thể dựa trên dữ liệu cũ)
UPDATE tabProducts
SET Quantity = Quantity - 1
WHERE Id = 2;

COMMIT;

--SQL1 -- Quay lại T1
COMMIT;

--15Vi?t câu l?nh t?o các transaction 1, 2 gi?ng Slide 74 và ch?p màn hình k?t qu?.
--L?nh
----SQL1

--K?t qu? ki?m ch?ng

--16Vi?t câu l?nh t?o các transaction 1, 2 gi?ng Slide 77 và ch?p màn hình k?t qu?.
--L?nh
----SQL1

--K?t qu? ki?m ch?ng

--17Vi?t câu l?nh t?o các transaction 1, 2 gi?ng Slide 78 và ch?p màn hình k?t qu?.

--BT10_TriggerCurTrans.docx		1
--L?nh
----SQL1

--K?t qu? ki?m ch?ng