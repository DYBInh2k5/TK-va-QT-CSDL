--1Liệt kê thông tin nhân viên gồm họ tên, ID (SSN) và địa chỉ của nhân viên mà có ngày sinh (Bdate) hoặc SupperSSN không xác định (null). Gợi ý: truy vấn dữ liệu trên 1 bảng Nhân viên (Employee).
--SQL:

--Result:
SELECT Fname, Lname, SSN, Address
FROM Employee
WHERE Bdate IS NULL OR SuperSSN IS NULL;


--2Liệt kê thông tin đầy đủ của những nhân viên có lương (Salary) từ 30000 đến 50000 và hiển thị kết quả theo lương giảm dần.
--SQL:
--BT07_TruyVan.docx		1

--Result:
SELECT * FROM Employee
WHERE Salary BETWEEN 30000 AND 50000
ORDER BY Salary DESC;


--3Hiển thị Mã dự án đã có nhân viên tham gia. Lưu ý, không hiển thị trùng mã dự án, gợi ý: sử dụng distinct.
--SQL:

--Result:
SELECT DISTINCT Pno
FROM Works_On;


--4Hiển thị 3 nhân viên lương cao nhất công ty. Gợi ý: sử dụng Top n.
--SQL:

--Result:
SELECT TOP 3 *
FROM Employee
ORDER BY Salary DESC;


--5Liệt kê thông tin nhân viên gồm Họ tên, SSN và địa chỉ của nhân viên có ngày sinh 'Jul-31-1972'.
--SQL:
--`	
--Result:
SELECT Fname, Lname, SSN, Address
FROM Employee
WHERE Bdate = '1972-07-31';


--6Liệt kê đầy đủ thông tin nhân viên có Tên (Fname) có kí tự đầu là nguyên âm: U,E,O,A,I giới tính là nữ và có lương dưới 30000.
--SQL:

--Result:
SELECT *
FROM Employee
WHERE Fname LIKE '[UEOAI]%' AND Sex = 'F' AND Salary < 30000;



--7Liệt kê đầy đủ thông tin nhân viên có Tên đệm (Minit) là nguyên âm: U,E,O,A,I giới tính là nữ và có lương từ 30000 trở lên làm việc trong phòng ban 4 hoặc 5.
--SQL1:

--Result:
SELECT *
FROM Employee
WHERE Minit IN ('U','E','O','A','I') AND Sex = 'F'
  AND Salary >= 30000 AND Dno IN (4, 5);


--8Viết câu truy vấn tìm Họ, Tên, Địa Chỉ, Ngày Sinh của nhân viên có ngày sinh từ 01/06/1959 đến 31/12/1959.
--SQL:

--Result:
SELECT Lname, Fname, Address, Bdate
FROM Employee
WHERE Bdate BETWEEN '1959-06-01' AND '1959-12-31';


--9Viết câu truy vấn tìm Họ Tên, Địa Chỉ, Ngày Sinh của nhân viên sinh từ sau năm 1945.
--Biết rằng Họ tên (Fullname) là chuỗi nối gồm 3 trường: Fname, Minit, Lname ví dụ: John B Smith. Gợi ý: sử dụng hàm ngày tháng như: Datepart ( datepart,date) hoặc Year(date).
--SQL1:

--Result:
SELECT CONCAT(Fname, ' ', Minit, ' ', Lname) AS Fullname, Address, Bdate
FROM Employee
WHERE YEAR(Bdate) > 1945;


--10Viết câu lệnh cho biết lương cao nhất, lương thấp nhất, lương bình quân và số lượng nhân viên công ty với các bí danh (aliases) lần lượt là 'sal_max', 
--BT07_TruyVan.docx		1
--'sal_min', 'sal_avg', 'emp_qty'. Lưu ý, sinh viên đặt bí danh (aliases) theo 3 cách mà SQL cung cấp.
--SQL:

--Result:
SELECT 
  MAX(Salary) AS sal_max,
  MIN(Salary) sal_min,
  AVG(Salary) AS "sal_avg",
  COUNT(*) emp_qty
FROM Employee;


--11Cho biết lương trung bình của các nhân viên nữ.
--SQL1:
	
--Result:
-- SQL1:
SELECT AVG(Salary) AS avg_salary_female
FROM Employee
WHERE Sex = 'F';


--12Cho biết Tên phòng ban, Số lượng nhân viên và Lương trung bình của mỗi phòng ban.
--Gợi ý: truy vấn dữ liệu từ 2 bảng: Department, Employee.
--SQL:

--Result:
SELECT D.Dname AS Ten_Phong, COUNT(E.SSN) AS So_Nhan_Vien, AVG(E.Salary) AS Luong_TB
FROM Department D
JOIN Employee E ON D.Dnumber = E.Dno
GROUP BY D.Dname;



--13Ứng với mỗi dự án, cho biết tên dự án và tổng số giờ/tuần của dự án đó.
--SQL:

--Result:
SELECT P.Pname, SUM(W.Hours) AS Tong_Gio
FROM Project P
JOIN Works_On W ON P.Pnumber = W.Pno
GROUP BY P.Pname;



--14Cho biết mã phòng ban, tên phòng ban mà có số lượng nhân viên lớn hơn 3. Kết quả hiển thị nên sắp xếp giảm dần theo số lượng nhân viên. Gợi ý: sử dụng Having.
--SQL:

--Result:
SELECT D.Dnumber, D.Dname, COUNT(E.SSN) AS So_Nhan_Vien
FROM Department D
JOIN Employee E ON D.Dnumber = E.Dno
GROUP BY D.Dnumber, D.Dname
HAVING COUNT(E.SSN) > 3
ORDER BY COUNT(E.SSN) DESC;



--15Liệt kê các mã số dự án trong bảng Project hoặc trong bảng Works_on.
--Gợi ý: sử dụng Union.
--SQL:
	
--Result:
SELECT Pnumber FROM Project
UNION
SELECT Pno FROM Works_On;



--16Liệt kê các mã số dự án có trong cả hai bảng Project, Works_on. Gợi ý: sử dụng Intersect.
--SQL:
	
--Result:
SELECT Pnumber FROM Project
INTERSECT
SELECT Pno FROM Works_On;


--17Liệt kê các mã số dự án có trong bảng Project nhưng chưa triển khai thực hiện trong Works_on. Gợi ý: sử dụng Except.
--SQL:
	
--Result:
SELECT Pnumber FROM Project
EXCEPT
SELECT Pno FROM Works_On;


--18Liệt kê thông tin dự án có trong bảng Project nhưng nếu chưa triển khai thực 
--BT07_TruyVan.docx		1
--hiện trong Works_on thì hiển thị null. Gợi ý: sử dụng Left Outer join.
--SQL:

--Result:
SELECT P.*, W.Pno
FROM Project P
LEFT OUTER JOIN Works_On W ON P.Pnumber = W.Pno;


--19Liệt kê thông tin dự án có trong bảng Project nhưng nếu chưa triển khai thực hiện trong Works_on thì hiển thị null. Gợi ý: sử dụng Right Outer join.
--SQL:
	
--Result:
SELECT P.*, W.Pno
FROM Works_On W
RIGHT OUTER JOIN Project P ON P.Pnumber = W.Pno;


--20Cho biết Họ Tên (FName Minit LName) các nhân viên thuộc phòng số 5 có tham gia dự án ProductX với thời gian trên 10 giờ/tuần. Gợi ý: truy vấn dữ liệu từ 4 bảng: employee, department, project, workson và sử dụng Inner join, Groub by, Having.
--SQL:
	
--Result:
SELECT E.Fname, E.Minit, E.Lname
FROM Employee E
JOIN Department D ON E.Dno = D.Dnumber
JOIN Works_On W ON E.SSN = W.Essn
JOIN Project P ON W.Pno = P.Pnumber
WHERE D.Dnumber = 5 AND P.Pname = 'ProductX'
GROUP BY E.Fname, E.Minit, E.Lname
HAVING SUM(W.Hours) > 10;


--21Cho biết Họ Tên (FName Minit LName) các nhân viên thuộc sự giám sát (Directly Supervised) bời nhân viên có tên là ‘Franklin Wong’. Gợi ý: sử dụng Self join.
--SQL:

--Result:
SELECT E.Fname, E.Minit, E.Lname
FROM Employee E
JOIN Employee S ON E.Super_ssn = S.SSN
WHERE S.Fname = 'Franklin' AND S.Lname = 'Wong';


--22Cho biết Họ Tên (FName Minit LName) các nhân viên viên có thân nhân trùng tên.
--Lưu ý: các nhân viên khác mã nv nhưng đặt tên con giống nhau.Gợi ý: sử dụng Self join.
--SQL:
	
--Result:
SELECT DISTINCT E1.Fname, E1.Minit, E1.Lname
FROM Employee E1
JOIN Dependent D1 ON E1.SSN <> D1.Essn
JOIN Employee E2 ON D1.Dependent_name = E2.Fname
WHERE E1.Fname = D1.Dependent_name;


--23Cho biết Họ Tên (FName Minit LName) các nhân viên tham gia tất cả các dự án.
--Gợi ý: sử dụng Subquery và hàm Count.
--SQL:

--Result:
SELECT Fname, Minit, Lname
FROM Employee
WHERE NOT EXISTS (
  SELECT Pnumber FROM Project
  EXCEPT
  SELECT Pno FROM Works_On WHERE Employee.SSN = Works_On.Essn
);


--24Cho biết Họ Tên (FName Minit LName) các nhân viên không tham gia dự án nào.
--Gợi ý: sử dụng Subquery.
--SQL:
	
--Result:
SELECT Fname, Minit, Lname
FROM Employee
WHERE SSN NOT IN (SELECT Essn FROM Works_On);

--25Cho biết Họ Tên (FName Minit LName) và địa chỉ tham gia ít nhất một dự án tại Houston nhưng phòng ban của họ không có địa chỉ tại Houston. Gợi ý: sử dụng Subquery.
--BT07_TruyVan.docx		1
--SQL:
	
--Result:
SELECT Fname, Minit, Lname, Address
FROM Employee
WHERE SSN IN (
    SELECT W.Essn
    FROM Works_On W, Project P
    WHERE W.Pno = P.Pnumber AND P.Plocation = 'Houston'
) AND Dno NOT IN (
    SELECT Dnumber
    FROM Department
    WHERE Dlocation = 'Houston'
);


--26Cho biết Họ Tên (FName Minit LName) người quản lý (trưởng phòng) không có thân nhân. Gợi ý: sử dụng Subquery.
--SQL:
	
--Result:
SELECT E.Fname, E.Minit, E.Lname
FROM Employee E
JOIN Department D ON E.SSN = D.MgrSSN
WHERE E.SSN NOT IN (SELECT Essn FROM Dependent);


--27Viết câu lệnh cập nhật tăng lương 10% cho tất cả nhân viên phòng ban 'Research'.
--Gợi ý: sử dụng Update và Subquery.
--SQL:

--Result:
UPDATE Employee
SET Salary = Salary * 1.1
WHERE Dno IN (SELECT Dnumber FROM Department WHERE Dname = 'Research');


--28Viết câu lệnh tạo bảng employee_Backup mà cấu trúc tạo bảng và dữ liệu của bảng này thuộc bảng Employee. Gợi ý: sử dụng Select … into.
--SQL:

--Result:
SELECT * INTO Employee_Backup FROM Employee;


--29Liệt kê họ tên những nhân viên nữ có lương từ 30000 đến 50000, hiển thị kết quả theo lương tăng dần. Lưu ý, định dạng tiền lương theo kiểu 1,000.0.
--Gợi ý: sử dụng hàm Format([salary],'#,##0.0').
--SQL:S

--Result:
SELECT Fname + ' ' + Lname AS FullName, Salary
FROM Employee
WHERE Sex = 'F' AND Salary BETWEEN 30000 AND 50000
ORDER BY Salary ASC;


--30Liệt kê họ tên, ID, Ngày sinh 1 nhân viên nữ có lương cao nhất. Lưu ý, định dạng ngày sinh theo kiểu dd-mm-yyyy. Gợi ý: sử dụng hàm convert(varchar,[BDate],103).
--SQL:

--Result:
SELECT TOP 1 Fname + ' ' + Lname AS FullName, SSN, CONVERT(VARCHAR, Bdate, 103) AS Birthdate
FROM Employee
WHERE Sex = 'F'
ORDER BY Salary DESC;


--31Liệt kê 5 hàm aggregate - tổng hợp thường dùng để thống kê dữ liệu và thường sử dụng cùng với Group by. Gợi ý: Sum(*),…
--Result:
1. COUNT(*) – đếm số dòng  
2. SUM(column) – tính tổng  
3. AVG(column) – tính trung bình  
4. MAX(column) – giá trị lớn nhất  
5. MIN(column) – giá trị nhỏ nhất  


--32Liệt kê 10 hàm làm việc với text/string và mô tả công dụng của hàm. Gợi ý: Len(‘text’),…
--Result:
1. LEN(string) – độ dài chuỗi  
2. LEFT(string, n) – lấy n ký tự từ trái  
3. RIGHT(string, n) – lấy n ký tự từ phải  
4. CHARINDEX(sub, string) – tìm vị trí chuỗi con  
5. REPLACE(string, old, new) – thay thế  
6. UPPER(string) – chuyển thành chữ hoa  
7. LOWER(string) – chuyển thành chữ thường  
8. LTRIM(string) – xóa khoảng trắng đầu  
9. RTRIM(string) – xóa khoảng trắng cuối  
10. CONCAT(a, b) – nối chuỗi  


--33Liệt kê trên 5 hàm làm việc với ngày tháng. Gợi ý: Day(date),…
--Result:
1. DAY(date) – ngày  
2. MONTH(date) – tháng  
3. YEAR(date) – năm  
4. GETDATE() – ngày giờ hiện tại  
5. DATEDIFF(day, d1, d2) – số ngày chênh lệch  
6. DATEPART(part, date) – lấy phần cụ thể (ngày/tháng/năm)  


--34Liệt kê trên 2 hàm chuyển kiểu dữ liệu thường dùng.
--BT07_TruyVan.docx		1
--Result:
1. CAST(expression AS datatype) – chuyển kiểu dữ liệu  
2. CONVERT(datatype, expression) – chuyển kiểu với định dạng  


