-- I. TẠO CSDL VÀ NHẬP DỮ LIỆU - RBTV

-- Tạo CSDL Lab01_QuanLyNhanVien

create database Lab01_QuanLyNhanVien
go

-- Sử dụng CSDL Lab01_QuanLyNhanVien

use Lab01_QuanLyNhanVien
go

-- Tạo các quan hệ (Bảng)

create table ChiNhanh
(
	MSCN char(2) primary key,
	TenCN nvarchar(15) unique
)
select * from ChiNhanh
go

create table KyNang
(
	MSKN char(2) primary key,
	TenKN nvarchar(15) unique
)
select * from KyNang
go

create table NhanVien
(
	MSNV char(4) primary key,
	Ho nvarchar(20),
	Ten nvarchar(15),
	NgaySinh dateTime,
	NgayVaoLam dateTime,
	MSCN char(2) foreign key references ChiNhanh(MSCN),
	constraint RB_Tuoi check (Year(NgayVaoLam) - Year(NgaySinh) >= 18)
)	
select * from NhanVien
go

create table NhanVienKyNang
(
	MSNV char (4) foreign key references NhanVien(MSNV),
	MSKN char (2) foreign key references KyNang(MSKN),
	MucDo tinyint,
	constraint RB_MucDo check(MucDo between 1 and 9),
	primary key(MSNV,MSKN)
)
select * from NhanVienKyNang
go
-- Nhập dữ liệu cho các bảng

-- Bảng ChiNhanh:

insert into ChiNhanh values('01',N'Quận 1')
insert into ChiNhanh values('02',N'Quận 5')
insert into ChiNhanh values('03',N'Bình Thạnh')
select * from ChiNhanh
go

-- Bảng KyNang

insert into KyNang values('01',N'Word')
insert into KyNang values('02',N'Excel')
insert into KyNang values('03',N'Access')
insert into KyNang values('04',N'Power Point')
insert into KyNang values('05','SPSS')
select * from KyNang 
go

-- Bảng NhanVien
set dateformat dmy --Khai báo định dạng ngày tháng 
go
insert into NhanVien values('0001',N'Lê Văn',N'Minh','10/06/1960','02/05/1986','01')
insert into NhanVien values('0002',N'Nguyễn Thị',N'Mai','20/04/1970','04/07/2001','01')
insert into NhanVien values('0003',N'Lê Anh',N'Tuấn','25/06/1975','01/09/1982','02')
insert into NhanVien values('0004',N'Vương Tuấn',N'Vũ','25/03/1975','12/01/1986','02')
insert into NhanVien values('0005',N'Lý Anh',N'Hân','01/12/1980','15/05/2004','02')
insert into NhanVien values('0006',N'Phan Lê',N'Tuấn','04/06/1976','25/10/2002','03')
insert into NhanVien values('0007',N'Lê Tuấn',N'Tú','15/08/1975','15/08/2000','03')
select * from NhanVien
go

-- Bảng NhanVienKyNang
insert into NhanVienKyNang values('0001','01',2)
insert into NhanVienKyNang values('0001','02',1)
insert into NhanVienKyNang values('0002','01',2)
insert into NhanVienKyNang values('0002','03',2)
insert into NhanVienKyNang values('0003','02',1)
insert into NhanVienKyNang values('0003','03',2)
insert into NhanVienKyNang values('0004','01',5)
insert into NhanVienKyNang values('0004','02',4)
insert into NhanVienKyNang values('0004','03',1)
insert into NhanVienKyNang values('0005','02',4)
insert into NhanVienKyNang values('0005','04',4)
insert into NhanVienKyNang values('0006','05',4)
insert into NhanVienKyNang values('0006','01',)
insert into NhanVienKyNang values('0006','02',4)
insert into NhanVienKyNang values('0006','03',2)
insert into NhanVienKyNang values('0007','03',4)
insert into NhanVienKyNang values('0007','04',3)
select * from NhanVienKyNang

--III. Tạo các truy vấn 

-- 1. Truy vấn lựa chọn nhiều bảng:
-- a) Hiển thị MSNV, HoTen, SoNamLamViec

select MSNV, Ho+' '+Ten as HoTen, Year(getdate())-Year(NgayVaoLam) as SoNamLamViec
from NhanVien

-- b) Liệt kê cá thông tin về nhân viên: HoTen, NgaySinh, NgayVaoLam, TenCN (Sắp xếp theo tên chi nhánh)

select a.MSNV, a.Ho+' '+a.Ten as HoTen, a.NgaySinh, a.NgayVaoLam, b.TenCN
from NhanVien a, ChiNhanh b
where a.MSCN=b.MSCN
order by b.TenCN

-- c) Liệt kê các nhân viên (Họ Tên, Tên KỹNăng, Mức Độ) của những nhân viên biết sử dụng Word.

select a.Ho +' '+ a.Ten as HoTen, c.TenKN, b.MucDo
from NhanVien a, NhanVienKyNang b, KyNang c
where a.MSNV = b.MSNV and  c.MSKN = b.MSKN and c.TenKN = 'Word'

-- d) Liệt kê các kỹ năng (TênKN, Mức độ) Mà nhân viên Lê Anh Tuấn sử dụng được 

select b.TenKN, c.MucDo
from NhanVien a, KyNang b, NhanVienKyNang c
where a.MSNV = c.MSNV and b.MSKN = c.MSKN and a.Ho+' '+a.Ten= N'Lê Anh Tuấn'

-- 2. Truy vấn lồng.
-- a) Liệt kê MSNV, Họ Tên, MSCN, TenCN của các nhân viên có mức độ thành thạo về Excel cao nhất trong công ty

select a.MSNV, a.Ho +' '+a.Ten as HoTen, a.MSCN, d.TenCN
from NhanVien a, KyNang b, NhanVienKyNang c, ChiNhanh d
where a.MSCN = d.MSCN and a.MSNV = c.MSNV and c.MSKN = b.MSKN and b.TenKN = 'Excel' 
and c.MucDo >=all(select e.MucDo
				from NhanVienKyNang e, KyNang f
				where e.MSKN = f.MSKN and f.TenKN = 'Excel')	

-- b) Liệt kê MSNV, Họ Tên, Tên CN của các nhân viên vừa biết Word vừa biết Excel (dùng truy vấn lồng)

select a.MSNV, a.Ho+' ' + a.Ten as HoTen, b.TenCN
from NhanVien a, ChiNhanh b, NhanVienKyNang c, KyNang d
where a.MSNV = c.MSNV and a.MSCN = b.MSCN and c.MSKN = d.MSKN and d.TenKN = 'Word' 
	and a.MSNV in (select e.MSNV
				from NhanVienKyNang e, KyNang f
				where e.MSKN = f.MSKN and f.TenKN='Excel')

-- c) Với từng kỹ năng, hãy liệt kê các thông tin (MANV, HoTen, TenCN, TenKN, Mức độ) của những nhân viên thành thạo kỹ năng đó nhất.
select a.MSNV, a.Ho+' ' + a.Ten as HoTen, b.TenCN, d.TenKN, c.MucDo
from NhanVien a, ChiNhanh b, NhanVienKyNang c, KyNang d
where a.MSCN = b.MSCN and a .MSNV = c.MSNV and d.MSKN = c.MSKN and c.MucDo >= all( select e.MucDo	
																				from NhanVienKynang e
																				where e.MSKN = d.MSKN)
order by d.TenKN
-- d) Liệt kê các chi nhánh (MSCN, TenCN) mà mọi nhân viên trong chi nhánh đó đều biết Word

--select a.TenCN, count(c.MSKN)
--from ChiNhanh a, NhanVien b, NhanVienKyNang c
--where a.MSCN=b.MSCN and b.MSNV=c.MSNV and c.MSKN='01'
--group by a.TenCN

--select a.MSCN, a.TenCN, count(b.MSNV)
--from ChiNhanh a, NhanVien b
--where a.MSCN = b.MSCN
--group by a.MSCN, a.TenCN
 -- Không biết làm âu :<<

-- 3. Truy vấn gom nhóm dữ liệu

