
-- I> Cài đặt cơ sở dữ liệu và nhập dữ liệu

-- Lệnh tạo cơ sở dữ liệu

create database Lab05_QuanLyTourDuLich
go

-- Lệnh sử dụng cơ sở dữ liệu

use Lab05_QuanLyTourDuLich
go

-- Lệnh tạo bảng

create table Tour
(
	MaTour char(4) primary key,
	TongSoNgay int
)
go

create table ThanhPho
(
	MaTP char(2) primary key,
	TenTP nvarchar(10)
)

create table Tour_TP
(
	MaTour char(4) references Tour(MaTour),
	MaTP char(2) references ThanhPho(MaTP),
	SoNgay tinyint
	primary key (MaTour,MaTP)
)
go

create table Lich_TourDL
(
	MaTour char(4) references Tour(MaTour),
	NgayKH dateTime,
	TenHDV nvarchar(10),
	SoNguoi smallint,
	TenKH nvarchar(20)
	primary key (MaTour,NgayKH)
)
go

-- Xem tất cả các bảng đã tạo

select * from Tour
select * from ThanhPho
select * from Tour_TP
select * from Lich_TourDL

-- Cập nhật dữ liệu cho bảng Tour

insert into Tour values ('T001',3)
insert into Tour values ('T002',4)
insert into Tour values ('T003',5)
insert into Tour values ('T004',7)
select * from Tour
go 

-- Cập nhật dữ liệu cho bảng ThanhPho

insert into ThanhPho values('01',N'Đà Lạt')
insert into ThanhPho values('02',N'Nha Trang')
insert into ThanhPho values('03',N'Phan Thiết')
insert into ThanhPho values('04',N'Huế')
insert into ThanhPho values('05',N'Đà Nẵng')
select * from ThanhPho
go

-- Cập nhật dữ liệu cho bảng Tour_TP

insert into Tour_TP values('T001','01',2)
insert into Tour_TP values('T001','03',1)
insert into Tour_TP values('T002','01',2)
insert into Tour_TP values('T002','02',2)
insert into Tour_TP values('T003','02',2)
insert into Tour_TP values('T003','01',1)
insert into Tour_TP values('T003','04',2)
insert into Tour_TP values('T004','02',2)
insert into Tour_TP values('T004','05',2)
insert into Tour_TP values('T004','04',3)
select * from Tour_TP
go

-- Cập nhật dữ liệu cho bảng Lich_TourDL

set dateformat dmy
insert into Lich_TourDL values('T001','14/02/2017',N'Vân',20,N'Nguyễn Hoàng')
insert into Lich_TourDL values('T002','14/02/2017',N'Nam',30,N'Lê Ngọc')
insert into Lich_TourDL values('T002','06/03/2017',N'Hùng',20,N'Lý Dũng')
insert into Lich_TourDL values('T003','18/02/2017',N'Dũng',20,N'Nguyễn Hoàng')
insert into Lich_TourDL values('T004','18/02/2017',N'Hùng',30,N'Dũng Hoàng')
insert into Lich_TourDL values('T003','10/03/2017',N'Nam',45,N'Nguyễn An')
insert into Lich_TourDL values('T002','28/04/2017',N'Vân',25,N'Ngọc Dung')
insert into Lich_TourDL values('T004','29/04/2017',N'Dũng',35,N'Lê Ngọc')
insert into Lich_TourDL values('T001','30/04/2017',N'Nam',25,N'Trần Nam')
insert into Lich_TourDL values('T003','15/06/2017',N'Vân',20,N'Trịnh Bá')
select * from Lich_TourDL
go

-- II. Thực hiện lệnh truy vấn

-- 1. Cho biết các tour du lịch có tổng số ngày của tour từ 3 đến 5 ngày
select *
from Tour
where TongSoNgay>=3 and TongSoNgay <=5
-- 2. Cho biết thông tin các tour được tổ chức trong tháng 2 năm 2017
select *
from Lich_TourDL
where MONTH(NgayKH)=2
-- 3. Cho biết các tour không đi qua thành phố Nha Trang
select a.MaTour, b.TenTP
from Tour_TP a, ThanhPho b
where a.MaTP=b.MaTP and b.TenTP not in (select c.TenTP
										from ThanhPho c
										where c.TenTP=N'Nha Trang')
-- 4. Cho biết số lượng thành phố mà mỗi tour du lịch đi qua

select MaTour, count(MaTP) as SoTPDiQua
from Tour_TP
group by MaTour

-- 5. Cho biết số lượng tour du lịch mỗi hướng dẫn viên hướng dẫn

select TenHDV, count(MaTour) as SoTourHuongDan
from Lich_TourDL
group by TenHDV --Có thể sai

-- 6. Cho biết thông thành phố có nhiều tour du lịch đi qua nhất

select b.MaTP, a.TenTP
from ThanhPho a, Tour_TP b
where a.MaTP=b.MaTP
group by b.MaTP, a.TenTP
having count(b.MaTour)  >= all (select count(c.MaTour)
								from Tour_TP c
								group by c.MaTour)

-- 7. Cho biết thông tin của tour du lịch đi qua tất cả các thành phố

--insert into Tour_TP values ('T004','01', 2)
--insert into Tour_TP values ('T004','03', 3)
go 

select *
from Tour a
where not exists(select *
				from ThanhPho b
				where not exists (select *
								from Tour_TP c
								where c.MaTP = b.MaTP and a.MaTour=c.MaTour))



-- 8. Lạp danh sách các tour đi qua thành phố Đà Lạt, thông tin cần hiển thị bao gồm: MaTour, SoNgay

select MaTour, SoNgay
from Tour_TP
where MaTP='01'

-- 9. Cho biết thông tin của tour du lịch có tổng số lượng khách tham gia nhiều nhất

select MaTour, sum(SoNguoi) as TongSoNguoi
from Lich_TourDL 
group by MaTour
having sum(SoNguoi)>=all(select sum(a.SoNguoi)
						from Lich_TourDL a
						group by a.MaTour)

-- 10. Cho biết tên thành phố mà tất cả các tour du lịch đều đi qua

select *
from ThanhPho a
where not exists (select *
				from Tour b
				where not exists (select *
								from Tour_TP c
								where a.MaTP=c.MaTP and b.MaTour=c.MaTour))