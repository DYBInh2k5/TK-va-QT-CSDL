--1 Vi?t ?o?n l?nh (code) có khai báo bi?n tên emp_salary v?i ki?u d? li?u numeric(10,2) (gi?ng v?i ki?u d? li?u c?a tr??ng l??ng (salary) b?ng employee) ?? cho phép xem t?ng l??ng c?a công ty ?ã ??t m?c 300000?
--N?u t?ng l??ng t? 300000 tr? lên h? th?ng c?n hi?n th? thông ?i?p 'win!', ng??c l?i ch?a ??t thì hi?n th? 'lose!'.
--L?nh
----SQL1

	
--Th?c hi?n – K?t qu? (ki?m ch?ng)
DECLARE @emp_salary NUMERIC(10,2);

SELECT @emp_salary = SUM(salary)
FROM employee;

IF @emp_salary >= 300000
    PRINT 'win!';
ELSE
    PRINT 'lose!';


--2 Vi?t ?o?n l?nh (code) th?c hi?n mô t? gi?i tính nhân viên, bi?t r?ng n?u gi?i tính là M thì 'Gender' là Man, F thì là Woman, các tr??ng h?p khác thì là 'Les or Gay'. G?i ý: S? d?ng c?u trúc r? nhánh iif ho?c case...when.
--L?nh
----SQL1
	
--Th?c hi?n – K?t qu? (ki?m ch?ng)
SELECT 
    fname,
    lname,
    sex,
    CASE 
        WHEN sex = 'M' THEN 'Man'
        WHEN sex = 'F' THEN 'Woman'
        ELSE 'Les or Gay'
    END AS Gender
FROM employee;


--3 Vi?t ?o?n l?nh (code) th?c hi?n nâng t?ng l??ng c?a công ty ?ã ??t 300000 b?ng vi?c th?c hi?n c?p nh?t l??ng nhân viên t?ng 1000 cho ??n khi t?ng l??ng công ty ?ã ??t 300000 nh?ng l??ng c?a m?t nhân viên không ???c t?ng quá 100000. G?i ý: S? d?ng l?p while.
--L?nh
----SQL1
	
--Th?c hi?n – K?t qu? (ki?m ch?ng)
DECLARE @total_salary NUMERIC(10,2);

SELECT @total_salary = SUM(salary) FROM employee;

WHILE @total_salary < 300000
BEGIN
    UPDATE employee
    SET salary = 
        CASE 
            WHEN salary + 1000 <= 100000 THEN salary + 1000
            ELSE salary 
        END;

    SELECT @total_salary = SUM(salary) FROM employee;

    -- Ki?m tra n?u không ai t?ng ???c n?a thì thoát tránh l?p vô h?n
    IF NOT EXISTS (
        SELECT * FROM employee 
        WHERE salary + 1000 <= 100000
    )
        BREAK;
END;

PRINT 'Finished updating salaries.';

--4 B?n xem code c?a Sinh viên A nh? sau:
--begin try 
--select
--    1 / 0 as error;
--end try
--begin catch
--? ?o?n l?nh (code) trên, Sinh viên A vô tình th?c hi?n phép chia m?t s? cho 0, khi th?c hi?n h? th?ng báo l?i, tuy nhiên sinh viên A không xác ??nh ???c l?i gì?
--BT09_TSqlSPFunc.docx	1
--B?n hãy giúp sinh viên A c?p phát l?i g?m: hi?n th? dòng l?i, thông ?i?p l?i ?? sinh viên A có th? hoàn thành bài t?p.
--L?nh
----SQL1
	
--Th?c hi?n – K?t qu? (ki?m ch?ng)
BEGIN TRY
    SELECT 1 / 0 AS error;
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS [S? l?i],
        ERROR_MESSAGE() AS [Thông ?i?p l?i],
        ERROR_LINE() AS [Dòng l?i],
        ERROR_STATE() AS [Tình tr?ng l?i],
        ERROR_PROCEDURE() AS [Tên th? t?c];
END CATCH;


--5 C?p phát 5 lo?i l?i c?a sinh viên A g?m: tên server, s? l?i, tình tr?ng l?i, dòng l?i, thông ?i?p l?i sau khi nh?p d? li?u vào b?ng Phòng ban ([dbo].[Department]) v?i giá tr? c?t nh?p tên phòng ban Dname là 'nonamenonamenoname' và câu l?nh insert c?a Sinh viên A nh? sau:
--INSERT INTO [dbo].[Department]([DName],[DNumber],[Mgrssn],[MgrStartdate]) values('nonamenonamenoname',5,'123456789',getdate())
--L?nh
----SQL1
	
--Th?c hi?n – K?t qu? (ki?m ch?ng)
BEGIN TRY
    INSERT INTO Department(DName, DNumber, Mgrssn, MgrStartDate)
    VALUES ('nonamenonamenoname', 5, '123456789', GETDATE());
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS [S? l?i],
        ERROR_MESSAGE() AS [Thông ?i?p l?i],
        ERROR_LINE() AS [Dòng l?i],
        ERROR_STATE() AS [Tình tr?ng l?i],
        ERROR_PROCEDURE() AS [Th? t?c l?i];
END CATCH;


--Stored Procedure
--6 T?o m?t th? t?c tên proc_project_hours cho phép li?t kê thông tin t?t c? d? án và t?ng s? gi?/tu?n mà mà t?t c? nhân viên th?c hi?n cho m?i d? án.
--L?nh
----SQL1
	
----th?c thi proc_project_hours ?? xem k?t qu?
CREATE PROCEDURE proc_project_hours
AS
BEGIN
    SELECT P.Pname, SUM(W.Hours) AS TotalHours
    FROM Project P
    JOIN Works_on W ON P.Pnumber = W.Pno
    GROUP BY P.Pname;
END;
GO

-- G?i th?:
EXEC proc_project_hours;

--Vi?t l?nh th?c hi?n g?i th?c thi th? t?c v?a t?o theo 3 cách và hi?n th? k?t qu? ra màn hình.
--L?nh
----SQL1

--7 T?o m?t th? t?c tên proc_search_pro_emps cho phép ng??i dùng nh?p tên d? án b?t k? thì h? th?ng h? th?ng tr? v? k?t qu? có/không?
--N?u có h? th?ng s? li?t kê tên c?a t?t c? các nhân viên làm vi?c cho d? án ?ó.
--N?u không h? th?ng hi?n th? thông ?i?p 'not found'.

--***Câu h?i ph?: có bao nhiêu tham s? nh?p?
--L?nh
----SQL1
CREATE PROCEDURE proc_search_emp
    @ssn CHAR(9)
AS
BEGIN
    SELECT *
    FROM Employee
    WHERE ssn = @ssn;
END;
GO
	

--Vi?t l?nh th?c hi?n g?i th?c thi th? t?c tên proc_search_pro_emps.
--L?nh
----SQL1
-- G?i th?:
EXEC proc_search_emp @ssn = '123456789';
--8 T?o m?t th? t?c tên proc_insert_date_for_Project cho phép ng??i dùng nh?p d? li?u cho b?ng d? án (Project).

--***Câu h?i ph?: có bao nhiêu tham s? nh?p?
--BT09_TSqlSPFunc.docx	1
--L?nh
----SQL1
CREATE FUNCTION func_dept_emp_total
(
    @dno INT
)
RETURNS INT
AS
BEGIN
    DECLARE @count INT;

    SELECT @count = COUNT(*)
    FROM Employee
    WHERE Dno = @dno;

    RETURN @count;
END;
GO

-- G?i th?:
SELECT dbo.func_dept_emp_total(5) AS SoLuongNhanVien;

--Vi?t l?nh th?c hi?n g?i th?c thi th? t?c tên proc_insert_date_for_project
--L?nh
----SQL1

--9 T?o m?t th? t?c tên proc_salary_review cho phép xu?t thông tin l??ng cao nh?t, l??ng th?p nh?t, l??ng trung bình nhân viên c?a công ty.

--***Câu h?i ph?: có bao nhiêu tham s? nh?p, xu?t?
--L?nh
----SQL1
CREATE FUNCTION func_list_project
(
    @dnum INT
)
RETURNS TABLE
AS
RETURN
    SELECT *
    FROM Project
    WHERE Dnum = @dnum;
GO


--Vi?t m?t th? t?c tên proc_execute_proc_salary_review ?? th?c hi?n g?i th?c thi th? t?c tên proc_salary_review.
--L?nh
----SQL1

--Vi?t l?nh th?c thi proc_execute_proc_salary_review ?? xem k?t qu?.
--L?nh
----SQL1
-- G?i th?:
SELECT * FROM dbo.func_list_project(5);

--10 T?o m?t th? t?c tên proc_Project_salary_total cho phép ng??i dùng nh?p vào tên project, h? th?ng xu?t thông tin t?ng s? l??ng nhân viên, t?ng s? gi? làm vi?c c?a d? án ?ó.

--***Câu h?i ph?: có bao nhiêu tham s? nh?p, xu?t?
--L?nh
----SQL1

--Vi?t m?t th? t?c tên proc_exec_Project_salary_total ?? th?c hi?n g?i th?c thi th? t?c tên proc_Project_salary_total.
--L?nh
----SQL1
CREATE FUNCTION func_list_emp_by_salary()
RETURNS @result TABLE (
    ssn CHAR(9),
    fname NVARCHAR(50),
    lname NVARCHAR(50),
    salary NUMERIC(10,2)
)
AS
BEGIN
    INSERT INTO @result
    SELECT ssn, fname, lname, salary
    FROM Employee
    WHERE salary > 30000;

    RETURN;
END;
GO

-- G?i th?:
SELECT * FROM dbo.func_list_emp_by_salary();


--11 Vi?t câu l?nh xóa các th? t?c procedure v?a t?o
--L?nh
----SQL1
-- 1. Xem thông tin b?ng Employee
EXEC sp_help 'Employee';

-- 2. Xem mã ngu?n th? t?c
EXEC sp_helptext 'proc_search_emp';

-- 3. Xem constraint c?a b?ng Department
EXEC sp_helpconstraint 'Department';

-- 4. ??i tên c?t (ví d? test – ??ng ch?y n?u không c?n)
-- EXEC sp_rename 'Employee.salary', 'LuongMoi', 'COLUMN';

-- 5. ??t DB m?c ??nh cho user (ch? test ???c khi có user t?o s?n)
-- EXEC sp_defaultdb 'ten_user', 'Company';

--12 Li?t kê và mô t? công d?ng 5 th? t?c có s?n trong h? th?ng mà b?n bi?t.
--ví d?: ??i tên table, database, xem thông tin thi?t k? b?ng, gán rule, gán default ho?c g? b?,…
--Th?c hi?n – K?t qu? (ki?m ch?ng)
CREATE FUNCTION salary_increase
(
    @salary NUMERIC(10, 2)
)
RETURNS NUMERIC(10, 2)
AS
BEGIN
    RETURN @salary * 1.1;
END;
GO

--Function
--13 T?o hàm tên salary_increase, cho phép ng??i dùng nh?p l??ng b?t k?, h? th?ng tr? v? k?t qu? t?ng l??ng v?a nh?p lên 10%.
--G?i ý: s? d?ng hàm Scalar functions
--BT09_TSqlSPFunc.docx	1
--L?nh
----SQL1
SELECT dbo.salary_increase(10000) AS Tang10PhanTram;

--Vi?t mã l?nh (code) th?c hi?n g?i hàm v?a t?o và hi?n th? k?t qu? ra màn hình.
--L?nh
----SQL1

--14T?o hàm tên fx_review_salary, cho phép ng??i dùng xem nh?ng nhân viên có l??ng cao h?n l??ng bình quân công ty.
--G?i ý: s? d?ng Inline Table-Valued Function
--L?nh
----SQL1
CREATE FUNCTION fx_review_salary()
RETURNS TABLE
AS
RETURN
    SELECT *
    FROM Employee
    WHERE salary > (SELECT AVG(salary) FROM Employee);
GO


--Vi?t mã l?nh (code) th?c hi?n g?i hàm v?a t?o và hi?n th? k?t qu? ra màn hình.
--L?nh
----SQL1

--15T?o hàm tên fx_emp_project, cho phép ng??i dùng nh?p tên nhân viên b?t k?, h? th?ng tr? v? thông tin các project mà nhân viên ?ó tham gia.
--G?i ý: s? d?ng Inline Table-Valued Function
--L?nh
----SQL1

--Vi?t mã l?nh (code) th?c hi?n g?i hàm v?a t?o và hi?n th? k?t qu? ra màn hình.
--L?nh
----SQL1
SELECT * FROM dbo.fx_review_salary();


--16T?o hàm tên fx_emp_project_2, cho phép ng??i dùng nh?p tên nhân viên b?t k?, h? th?ng tr? v? thông tin các project mà nhân viên ?ó tham gia th?c hi?n. K?t qu? nh?ng dòng tr? v? ???c l?u vào m?t b?ng t?m ( trong m?t bi?n t?m (a temporary table)).
--G?i ý: s? d?ng Multistatement Table-Valued Function
--L?nh
----SQL1
CREATE FUNCTION fx_emp_project_2 (@fname NVARCHAR(50))
RETURNS @result TABLE (
    FName NVARCHAR(50),
    PName NVARCHAR(100),
    Hours DECIMAL(5,2)
)
AS
BEGIN
    INSERT INTO @result
    SELECT e.fname, p.pname, w.hours
    FROM Employee e
    JOIN Works_on w ON e.ssn = w.essn
    JOIN Project p ON w.pno = p.pnumber
    WHERE e.fname = @fname;

    RETURN;
END;
GO


--Vi?t mã l?nh (code) th?c hi?n g?i hàm v?a t?o và hi?n th? k?t qu? ra màn hình.
--L?nh
----SQL1
SELECT * FROM dbo.fx_emp_project_2(N'John');


