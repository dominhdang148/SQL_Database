-----------------------------------------------------
--Học phần: Cơ sở Dữ Liệu
--Ngày
--Người thực hiện: Đỗ Minh Đăng
-----------------------------------------------------

-- I. Tạo CSDL - Nhập dữ liệu

-- Lệnh tạo CSDL
create database Lab04_QuanLyDatBao
go

-- Lệnh sử dụng CSDL

use Lab04_QuanLyDatBao
go
-- Lệnh tạo các bảng

create table Bao_TChi
(
	MaBaoTC char(4) primary key,
	Ten nvarchar(25),
	DinhKy nvarchar(20),
	SoLuong int,
	GiaBan int
)

go

create table PhatHanh
(
	MaBaoTC char (4) references Bao_TChi(MaBaoTC),
	SoBaoTC int,
	NgayPH datetime
	primary key (MaBaoTC, SoBaoTC)
)

go

create table KhachHang
(
	MaKH char(4) primary key ,
	TenKhachHang nvarchar(10),
	DiaChi nvarchar(10)
)

go

create Table DatBao
(
	MaKH char (4) references KhachHang(MaKH),
	MaBaoTC char (4) references Bao_TChi(MaBaoTC),
	SLMua int,
	NgayDM dateTime
	primary key (MaKH, MaBaoTC)
)

go

-- Xem các bảng được tạo

select * from Bao_TChi
select * from PhatHanh
select * from KhachHang
select * from DatBao

go

-- Nhập dữ liệu cho bảng Bao_TChi

insert into Bao_TChi values('TT01',N'Tuổi trẻ', N'Nhật báo', 1000,1500)
insert into Bao_TChi values('KT01',N'Kiến thức ngày nay', N'Bán nguyệt san', 3000,6000)
insert into Bao_TChi values('TN01',N'Thanh niên', N'Nhật báo', 1000,2000)
insert into Bao_TChi values('PN01',N'Phụ nữ', N'Tuần báo', 2000,4000)
insert into Bao_TChi values('PN02',N'Phụ nữ', N'Nhật báo', 1000,2000)
select * from Bao_TChi
go

-- Nhập dữ liệu cho bảng PhatHanh

set dateformat dmy
go
insert into PhatHanh values('TT01',123,'15/12/2005')
insert into PhatHanh values('KT01',70,'15/12/2005')
insert into PhatHanh values('TT01',124,'16/12/2005')
insert into PhatHanh values('TN01',256,'17/12/2005')
insert into PhatHanh values('PN01',45,'23/12/2005')
insert into PhatHanh values('PN02',111,'18/12/2005')
insert into PhatHanh values('PN02',112,'19/12/2005')
insert into PhatHanh values('TT01',125,'17/12/2005')
insert into PhatHanh values('PN01',46,'30/12/2005')
select * from PhatHanh
go

-- Nhập dữ liệu cho bảng KhachHang

insert into KhachHang values('KH01',N'Lan',N'2 NCT')
insert into KhachHang values('KH02',N'Nam',N'32 THĐ')
insert into KhachHang values('KH03',N'Ngọc',N'16 LHP')
select * from KhachHang
go

-- Nhập dữ liệu cho bảng DatBao

set dateformat dmy
go
insert into DatBao values('KH01','TT01',100,'12/01/2000')
insert into DatBao values('KH02','TN01',150,'01/05/2001')
insert into DatBao values('KH01','PN01',200,'25/06/2001')
insert into DatBao values('KH03','KT01',50,'17/03/2002')
insert into DatBao values('KH03','PN02',200,'26/08/2003')
insert into DatBao values('KH02','TT01',250,'15/01/2004')
insert into DatBao values('KH01','KT01',300,'14/10/2004')
select* from DatBao
go

-- II. Truy vấn dữ liệu
-- 1. Cho biết các tờ báo, tạp chú có định kỳ phát hành hàng tuần

select MaBaoTC, Ten, GiaBan
from Bao_TChi
where DinhKy = N'Tuần báo'

-- 2. Cho biết thông tin về các tờ báo thuộc loại báo phụ nữ (Mã báo bắt đầu bằng PN)

select *
from Bao_TChi
where MaBaoTC like '%PN%'

-- 3. Cho biết tên khách hàng có đặt mua báo phụ nữ, không liệt kê khách hàng trùng

select distinct a.MaKH, a.TenKhachHang, a.DiaChi
from KhachHang a, DatBao b
where a.MaKH=b.MaKH and b.MaBaoTC like '%PN%'

-- 4. Cho biết tên khách hàng đặt mua tất cả báo phụ nữ (y chang câu 3 :>>)

-- 5. Cho biết khách hàng không đặt mua báo thanh niên

select distinct a.MaKH, a.TenKhachHang, a.DiaChi
from KhachHang a, DatBao b
where a.MaKH=b.MaKH and b.MaKH not in (select c.MaKH
										from DatBao c
										where c.MaBaoTC like '%TN%')

-- 6. Cho biết số tờ báo mà mỗi khách hàng đã đặt mua

select a.MaKH, a.TenKhachHang, SUM(b.SLMua) as TongSoLuongMua
from KhachHang a, DatBao b
where a.MaKH=b.MaKH 
group by a.MaKH, a.TenKhachHang

-- 7. Cho biết số khách hàng đặt mua báo trong năm 2004

select count(MaKH) as TongSLKhachHang
from DatBao
where YEAR(NgayDM) = 2004 

-- 8. Cho biết thông tin đặt mua báo của các khách hàng 

select b.TenKhachHang, a.Ten, a.DinhKy, c.SLMua, (c.SLMua*a.GiaBan) as SoTien 
from Bao_TChi a, KhachHang b, DatBao c
where a.MaBaoTC=c.MaBaoTC and b.MaKH=c.MaKH

-- 9. Cho biết các tờ báo, tạp chí và tổng số lượng đặt mua của khách hàng đối với tờ báo, tạp chí đó

select a.Ten, a.DinhKy, Sum(b.SLMua) as TongSoLuong
from Bao_TChi a, DatBao b
where a.MaBaoTC=b.MaBaoTC
group by a.Ten, a.DinhKy

-- 10. Cho biết tên các tờ báo dành cho Học sinh, sinh viên 

insert into Bao_TChi values('HS01', N'Mực tím', N'Tuần báo', 1000, 500)
insert into Bao_TChi values('HS02', N'Nhi đồng',N'Tuần báo',2000,500)
go

set dateformat dmy
insert into PhatHanh values('HS01',221,'16/12/2005')
insert into PhatHanh values('HS02',150,'12/12/2005')
go

select * from PhatHanh

select * from Bao_TChi

select Ten
from Bao_TChi
where MaBaoTC like '%HS%'

-- 11. Cho biết những tờ báo không có người đặt mua

select a.MaBaoTC, a.Ten
from Bao_TChi a
where a.MaBaoTC not in (select b.MaBaoTC
						from DatBao b)

-- 12. Cho biết tên, định kỳ của những tờ báo có nhiều người đặt mua nhất

select a.Ten, a.DinhKy, SUM(b.SLMua) as TongSoLuong
from Bao_TChi a, DatBao b
where a.MaBaoTC = b.MaBaoTC
group by a.Ten, a.DinhKy
having sum(b.SLMua) >= all(select sum(c.SLMua)
						from DatBao c
						group by c.MaBaoTC)

-- 13. Cho biết khách hàng đặt mua nhiều báo, tạp chí nhất

select a.MaKH, a.TenKhachHang, sum(b.SLMua) as TongSoLuong
from KhachHang a, DatBao b
where a.MaKH=b.MaKH
group by a.MaKH, a.TenKhachHang
having sum(b.SLMua)>=all (select sum(c.SLMua)
						from DatBao c
						group by c.MaKH)

-- 14. Cho biết tờ báo phát hành định kỳ 1 tháng 2 lần

-- Ko biết làm :">

-- 15. Cho biết các tờ báo, tạp chí có từ 3 khách hàng đặt mua trở lên

select a.MaBaoTC, a.Ten
from Bao_TChi a, DatBao b
where a.MaBaoTC=b.MaBaoTC 
group by a.MaBaoTC, a.Ten
having count(distinct b.MaKH)>=2
--Hình như ko có tờ báo nào có 3 khách hàng đặt mua cả :v