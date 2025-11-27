--1.Viết câu lệnh thêm trường HireDate (ngày vào làm) vào bảng Employee. Viết câu lệnh tạo ràng buộc (Default) tên def_EmpHireDate để khi thêm một nhân viên mới thì mặc nhiên HireDate là ngày hiện hành.
--Lệnh
----SQL1
ALTER TABLE Employee
ADD HireDate DATE;
GO

ALTER TABLE Employee
ADD CONSTRAINT def_EmpHireDate DEFAULT GETDATE() FOR HireDate;
GO
--Thực hiện – Kết quả (kiểm chứng)
--(Chụp màn hình kết quả dán vào đây)

--2.Viết câu lệnh tạo ràng buộc kiểm tra (check) tên chk_EmpSex để khi nhập, sửa giới tính (Sex) nhân viên chỉ nhận giá trị ‘M’ hoặc ‘F’.
--Lệnh
----SQL1
ALTER TABLE Employee
ADD CONSTRAINT chk_EmpSex CHECK (Sex IN ('M', 'F'));
GO
--Thực hiện – Kết quả (kiểm chứng)

--3.Viết câu lệnh tạo ràng buộc kiểm tra (check) tên chk_EmpSal để khi thêm hay cập nhật lương (Salary) một nhân viên tối thiểu là 25000.
--Lệnh
----SQL1
ALTER TABLE Employee
ADD CONSTRAINT chk_EmpSal CHECK (Salary >= 25000);
GO
--Thực hiện – Kết quả (kiểm chứng)
--4.Viết câu lệnh tạo ràng buộc kiểm tra (check) tên chk_EmpAge18 để khi thêm hay cập nhật ngày vào làm (HireDate) phải từ 18 tuổi trở lên.
--Lệnh
----SQL1
ALTER TABLE Employee
ADD CONSTRAINT chk_EmpAge18 
CHECK (DATEDIFF(YEAR, BDate, HireDate) >= 18);
GO
--Thực hiện – Kết quả (kiểm chứng)

--5.Viết câu lệnh thêm cột Password sử dụng kiểu dữ liệu varchar(20) vào bảng Employee. Viết câu lệnh tạo ràng buộc kiểm tra (check) tên chk_EmpPwd để khi nhập, hiệu chỉnh dữ liệu cho trường này có thể bỏ trống (rỗng) hoặc phải từ 8 ký tự trở lên.
--Lệnh
----SQL1
ALTER TABLE Employee
ADD Password VARCHAR(20);
GO

ALTER TABLE Employee
ADD CONSTRAINT chk_EmpPwd 
CHECK (Password IS NULL OR LEN(Password) = 0 OR LEN(Password) >= 8);
GO

--Thực hiện – Kết quả (kiểm chứng)
--6.Viết câu lệnh tạo mặc định (default) tên df_sex với giá trị có sẵn (mặc định) là nữ nếu người dùng không nhập dữ liệu. Thực hiện gán/áp dụng  default df_sex cho giới tính (Sex) trong bảng Nhân viên (Employee).
--Lệnh
----SQL1
ALTER TABLE Employee
ADD CONSTRAINT df_sex DEFAULT 'F' FOR Sex;
GO
--7.Viết câu lệnh tạo một qui tắc nhập liệu (rule) tên rule_Salary cho phép người dùng nhập lương lơn hơn hoặc bằng zero và nhỏ hơn bằng 100000. Thực hiện gán/áp dụng rule rule_Salary cho lương (Salary) trong bảng Nhân viên (Employee).
--Lệnh
----SQL1
CREATE RULE rule_Salary 
AS @Salary >= 0 AND @Salary <= 100000;
GO

EXEC sp_bindrule 'rule_Salary', 'Employee.Salary';
GO
--8.Viết câu lệnh liệt kê các ràng buộc đang tồn tại trong 1 CSDL, ví dụ: Company
--Lệnh 
----SQL1
USE Company;
GO

SELECT 
    OBJECT_NAME(parent_object_id) AS TableName,
    name AS ConstraintName,
    type_desc AS ConstraintType
FROM sys.objects
WHERE type IN ('C', 'F', 'PK', 'UQ', 'D');  -- Check, Foreign key, Primary key, Unique, Default
--Thực hiện – Kết quả (kiểm chứng)

--9.Viết câu lệnh tạo cho biết tên ràng buộc khóa chính (Primary key) trong bảng Employee của 1 CSDL. ví dụ: CSDL Company.
--Lệnh 
----SQL1
USE Company;
GO

SELECT 
    tc.CONSTRAINT_NAME AS PrimaryKeyName
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
WHERE 
    tc.TABLE_NAME = 'Employee' 
    AND tc.CONSTRAINT_TYPE = 'PRIMARY KEY';

--Thực hiện – Kết quả (kiểm chứng)

--10.Viết câu lệnh xóa các ràng buộc đã tạo ở câu 1, 2 ,3, 5 gồm: def_EmpHireDate, chk_EmpSex, chk_EmpSal, chk_EmpPwd.
--Lệnh 
----SQL1
ALTER TABLE Employee DROP CONSTRAINT def_EmpHireDate;
ALTER TABLE Employee DROP CONSTRAINT chk_EmpSex;
ALTER TABLE Employee DROP CONSTRAINT chk_EmpSal;
ALTER TABLE Employee DROP CONSTRAINT chk_EmpPwd;
GO
--11.Viết câu lệnh gỡ bỏ các mặc định (default) đã tạo (nếu có) trên trường Sex bảng Employee và xóa các mặc định (default) này.
--Lệnh 
----SQL1
ALTER TABLE Employee DROP CONSTRAINT df_sex;
GO

--12.Viết câu lệnh gỡ bỏ các các quy tắc nhập liệu (rule) đã tạo (nếu có) trên trường Salary bảng Employee và xóa các quy tắc nhập liệu (rule) này.
--Lệnh
----SQL1
EXEC sp_unbindrule 'Employee.Salary';
GO

DROP RULE rule_Salary;
GO

--13.Liệt kê các ràng buộc trong SQL mà bạn biết, lưu ý tối thiểu 3 ràng buộc.
--Thực hiện – Kết quả (kiểm chứng)
SELECT 
    OBJECT_NAME(parent_object_id) AS TableName,
    name AS ConstraintName,
    type_desc AS ConstraintType
FROM sys.objects
WHERE type IN ('C', 'F', 'PK', 'UQ', 'D')
ORDER BY TableName, ConstraintType;

--B.Bảng ảo - View
--Viết câu lệnh tạo các view và thực hiện các yêu cầu:
--14.Viết câu lệnh tạo view tên v_EmpSuperSSN: cho biết các thông tin tên phòng ban, họ tên nhân viên giám sát (Supper_SSN), họ tên nhân viên.
--Lệnh
----SQL1
CREATE VIEW v_EmpSuperSSN AS
SELECT 
    d.DName,
    sup.FName + ' ' + ISNULL(sup.MInit + '. ', '') + sup.LName AS SupervisorName,
    emp.FName + ' ' + ISNULL(emp.MInit + '. ', '') + emp.LName AS EmployeeName
FROM Employee emp
LEFT JOIN Employee sup ON emp.SuperSSN = sup.SSN
LEFT JOIN Department d ON emp.DNo = d.DNumber;

----Xem view đã tồn tại?
	
--Thực hiện – Kết quả (kiểm chứng)
----Truy vấn dữ liệu từ view để kiểm tra kết quả
	
--15.Viết câu lệnh tạo view tên v_DepEmp: cho biết các thông tin Tên phòng ban, Tên trưởng phòng, Họ tên nhân viên của mỗi phòng ban.
--Lệnh
----SQL1
CREATE VIEW v_DepEmp AS
SELECT 
    d.DName,
    -- Tên trưởng phòng
    mgr.FName + ' ' + ISNULL(mgr.MInit + '. ', '') + mgr.LName AS ManagerName,
    -- Họ tên nhân viên trong phòng ban
    emp.FName + ' ' + ISNULL(emp.MInit + '. ', '') + emp.LName AS EmployeeName
FROM Department d
LEFT JOIN Employee mgr ON d.MgrSSN = mgr.SSN
LEFT JOIN Employee emp ON emp.DNo = d.DNumber;

--Thực hiện – Kết quả (kiểm chứng)

--16.Viết câu lệnh tạo view tên v_PrjEmp: cho biết các thông tin Tên dự án, địa điểm dự án, Tên nhân viên tham gia dự án.
--Lệnh
----SQL1
CREATE VIEW v_PrjEmp AS
SELECT 
    p.PName,
    p.PLocation,
    emp.FName + ' ' + ISNULL(emp.MInit + '. ', '') + emp.LName AS EmployeeName
FROM Project p
JOIN Works_On w ON p.PNumber = w.PNo
JOIN Employee emp ON w.ESSN = emp.SSN;

--Thực hiện – Kết quả (kiểm chứng)

--17.Viết câu lệnh tạo view tên v_EmpDep: cho biết các thông tin tên nhân viên, tên thân nhân (nếu có), mối quan hệ (relationship) của tất cả các nhân viên.
--Lệnh
----SQL1
CREATE VIEW v_EmpDep AS
SELECT 
    emp.FName + ' ' + ISNULL(emp.MInit + '. ', '') + emp.LName AS EmployeeName,
    dep.Dependent_Name,
    dep.Relationship
FROM Employee emp
LEFT JOIN Dependent dep ON emp.SSN = dep.ESSN;

--Thực hiện – Kết quả (kiểm chứng)
--18.Viết câu lệnh tạo view tên v_DeptPrj: cho biết các thông tin tên phòng ban, tên dự án, địa điểm dự án, số lượng nhân viên và tổng thời gian dự án.
--Lệnh
----SQL1
CREATE VIEW v_DeptPrj AS
SELECT
    d.DName,
    p.PName,
    p.PLocation,
    COUNT(w.ESSN) AS NumberOfEmployees,
    SUM(ISNULL(w.Hours, 0)) AS TotalHours
FROM Department d
JOIN Project p ON d.DNumber = p.DNum
LEFT JOIN Works_On w ON p.PNumber = w.PNo
GROUP BY d.DName, p.PName, p.PLocation;

--Thực hiện – Kết quả (kiểm chứng)

--19.Viết câu lệnh liệt kê các view vừa tạo.
--Lệnh
----SQL1
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.VIEWS
ORDER BY TABLE_NAME;

--20.Viết câu lệnh truy vấn dữ liệu từ view đã tạo ở câu 1, 2, 3, 4, 5.
--Lệnh
----SQL1
----Truy vấn dữ liệu từ view để kiểm tra kết quả, câu 1
SELECT * FROM v_EmpSuperSSN;
SELECT * FROM v_DepEmp;
SELECT * FROM v_PrjEmp;
SELECT * FROM v_EmpDep;
SELECT * FROM v_DeptPrj;

--21.Viết câu lệnh xóa các view vừa tạo ở câu 1, 2, 3, 4, 5.
--Lệnh
----SQL1
DROP VIEW IF EXISTS v_EmpSuperSSN;
DROP VIEW IF EXISTS v_DepEmp;
DROP VIEW IF EXISTS v_PrjEmp;
DROP VIEW IF EXISTS v_EmpDep;
DROP VIEW IF EXISTS v_DeptPrj;

--C.Chỉ mục - INDEX
--Viết câu lệnh tạo các chỉ mục (index) và thực hiện các yêu cầu:
--22.Liệt kê các kiểu chỉ mục (index) có trong SQL mà bạn biết.
--Thực hiện – Kết quả (kiểm chứng)
SELECT 
    OBJECT_NAME(i.object_id) AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType,
    COL_NAME(ic.object_id, ic.column_id) AS ColumnName,
    ic.key_ordinal AS ColumnPosition
FROM sys.indexes i
JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
WHERE OBJECT_NAME(i.object_id) = 'Employee'
ORDER BY i.name, ic.key_ordinal;

--23.Viết câu lệnh tạo Single Column Index với tên index là idx_fname cho trường Fname trong bảng Employee.
--Lệnh
----SQL1
CREATE INDEX idx_fname
ON Employee (FName);

--24.Viết câu lệnh tạo Single Column Index với tên idx_DepdName cho trường Dependent_Name trong bảng Dependent.
--Lệnh
----SQL1
CREATE INDEX idx_DepdName
ON Dependent (Dependent_Name);

--25.Viết câu lệnh tạo Single Column Index với tên idx_Dloca cho trường DLocation trong bảng Dept_Location.
--Lệnh
----SQL1
CREATE INDEX idx_Dloca
ON DEPT_LOCATIONS (DLocation);
--26.Viết câu lệnh tạo Single Column Index với tên idx_PrjLoc cho trường PLocation trong bảng Project.
--Lệnh
----SQL1
CREATE INDEX idx_PrjLoc  
ON PROJECT (PLocation);

--27.Viết câu lệnh tạo Unique Index với tên index là idx_ssn cho trường ssn trong bảng Employee.
--Lệnh
----SQL1
CREATE UNIQUE INDEX idx_ssn
ON Employee (SSN);

--28.Viết câu lệnh tạo Unique Index với tên index là idx_address cho trường address trong bảng Employee.
--Lệnh
----SQL1
CREATE INDEX idx_address
ON Employee (Address);

--29.Viết câu lệnh tạo Composite Index với tên idx_EmpFLName cho 2 trường: (FName + Lname) trong bảng Employee.
--Lệnh
----SQL1
CREATE INDEX idx_EmpFLName  
ON Employee (FName, LName);

--30.Viết câu lệnh tạo Composite Index với tên idx_EmpLFName cho 2 trường: (LName + Fname) trong bảng Employee.
--Lệnh
----SQL1
CREATE INDEX idx_EmpLFName  
ON Employee (LName, FName);

--31.Liệt kê tên các chỉ mục Implicit Index được tạo tự động cho các ràng buộc Primary key hoặc các ràng buộc Unique trong CSDL Company.
--Lệnh
----SQL1
SELECT name AS IndexName,
       object_name(object_id) AS TableName,
       type_desc AS IndexType,
       is_primary_key,
       is_unique_constraint
FROM sys.indexes
WHERE (is_primary_key = 1 OR is_unique_constraint = 1)
  AND object_schema_name(object_id) = 'dbo';

--32.Xem thời gian thực thi câu lệnh sau khi thực hiện tạo index. “Liệt kê thông tin bảng nhân viên. Lưu ý: Sinh viên viết câu lệnh và chụp màn hình kết quả.
--Lệnh
----SQL1
SET STATISTICS TIME ON;
SELECT * FROM Employee;
SET STATISTICS TIME OFF;

--Kết quả

--33.Viết câu lệnh liệt kê các index vừa tạo.
--Lệnh và kết quả
----SQL1
SELECT 
    i.name AS IndexName,
    i.type_desc AS IndexType,
    t.name AS TableName,
    c.name AS ColumnName
FROM 
    sys.indexes i
JOIN 
    sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN 
    sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
JOIN 
    sys.tables t ON i.object_id = t.object_id
WHERE 
    i.is_primary_key = 0  -- Loại bỏ chỉ mục mặc định của primary key
    AND i.is_unique_constraint = 0  -- Loại bỏ chỉ mục của unique constraint
ORDER BY 
    t.name, i.name;

--34.Viết câu lệnh xóa các index tối thiểu 3 index vừa tạo.
--Lệnh
----SQL1
DROP INDEX idx_fname ON Employee;
DROP INDEX idx_DepdName ON Dependent;
DROP INDEX idx_EmpFLName ON Employee;
