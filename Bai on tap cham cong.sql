se quanlychamcong
go

delete chamcong
where mabangchamcong in ( select mabangchamcong
							from bangchamcong
							where thang = '6/2025')
delete mabangchamcong
where thang = '6/2025'
go

DECLARE @MAXSTT INT
DECLARE @MAPHONGBAN CHAR(3)
DECLARE @MABANGCHAMCONG CHAR(3)

INSERT INTO CHAMCONG(mabangchamcong, manhanvien,SONGAYCONG)
SELECT MABANGCHAMCONG, MANHANVIEN,26
FROM NHANVIEN N JOIN BANGCHAMCONG B ON N.maphongban = B.maphongban
WHERE manhanvien NOT IN (SELECT MANHANVIEN
						FROM CHAMCONG C JOIN BANGCHAMCONG B ON C.mabangchamcong = B.mabangchamcong
						WHERE THANG ='06/2025')
	AND B.THANG = '06/2025'

DECLARE C_DSPHONGBAN CURSOR FOR (select maphongban
								from Phongban
								where maphongban not in (select maphongban from Bangchamcong where thang ='06/2025'))
SET @MAXSTT = (SELECT MAX(RIGHT(MABANGCHAMCONG,2)+1)
               FROM BANGCHAMCONG)
OPEN C_DSPHONGBAN
FETCH NEXT FROM C_DSPHONGBAN INTO @MAPHONGBAN
WHILE (@@FETCH_STATUS =0)
BEGIN 
	IF @MAXSTT	<10
		SET @MABANGCHAMCONG = 'B0'+ CONVERT(CHAR(1),@MAXSTT)
	ELSE
		SET @MABANGCHAMCONG = 'B'+ CONVERT(CHAR(2),@MAXSTT)

	INSERT INTO Bangchamcong(mabangchamcong,thang,maphongban)
	VALUES(@MABANGCHAMCONG,'06/2025',@MAPHONGBAN)

	INSERT INTO Chamcong(mabangchamcong,manhanvien,songaycong)
	SELECT @MABANGCHAMCONG, MANHANVIEN,26
	FROM NHANVIEN
	WHERE MAPHONGBAN = @MAPHONGBAN

	FETCH NEXT FROM C_DSPHONGBAN INTO @MAPHONGBAN
	SET @MAXSTT= @MAXSTT +1
END
CLOSE C_DSPHONGBAN
DEALLOCATE C_DSPHONGBAN

go
create proc proc1
@manhanvien char(4),
@thang char(7),
@songaycong tinyint out,
@luong int out
as
select @songaycong = songaycong, @luong = (luongcoban*songaycong)/26
from chamcong c join bangchamcong b on c.mabangchamcong = b.mabangchamcong join nhanvien n on c.manhanvien = n.manhanvien
where n.manhanvien = @manhanvien and thang = @thang
go

declare @songaycong tinyint, @luong int
go

exec proc1 'NV01', '01/2025', @songaycong out, @luong out
go


create proc proc6 
@tongquyluong int
as
declare @tongluong int, @tongluongnew int, @phantram decimal(5,1)
set @tongluong = (select sum(luongcoban) from nhanvien),
if @tongquyluong > @tongluong 
begin
	set @phantram = 10
	set @tongluongnew = @tongluong +(select sum(luongcoban * @phantram / 100) from nhanvien where luongcoban < 5000000)
while @TONGLUONGNEW > @TONGQUYLUONG
BEGIN
	SET @PHANTRAM = @PHANTRAM - 0.1
	SET @TONGLUONGNEW = @TONGLUONG + (SELECT SUM(LUONGCOBAN*@PHANTRAM/100)
										FROM NHANVIEN
										WHERE LUONGCOBAN <5000000)
END
	PRINT @PHANTRAM
	PRINT @TONGLUONGNEW
    SELECT *, LUONGCOBAN*(1+@PHANTRAM/100) AS LUONGNEW
	FROM NHANVIEN
	WHERE LUONGCOBAN <5000000
END