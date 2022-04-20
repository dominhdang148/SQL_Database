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

select a.MSCN, a.TenCN
from ChiNhanh a, NhanVien b
where a.MSCN = b.MSCN
group by a.MSCN,a .TenCN
having count(b.MSNV)=(select count(e.MSNV)
					from NhanVien d, NhanVienKyNang e
					where a.MSCN=d.MSCN and d.MSNV=e.MSNV and e.MSKN='01'
					group by d.MSCN)

-- Có thể sai (Chả hiểu sao chạy đc :>>)

-- 3. Truy vấn gom nhóm dữ liệu
-- a) Vỡi mỗi chi nhánh, hãy cho biết các thông tin sau TenCN, soNV (Số nhân viên của chi nhánh đó):

select b.TenCN, count(a.MSNV) as SoNV 
from NhanVien a, ChiNhanh b
where a.MSCN = b.MSCN
group by b.TenCN


 -- b) Với mỗi kỹ năng, hãy cho biết TenKN, SoNguoiDung (Số nhân viên biết sử dụng kỹ năng đó)

select a.TenKN, count(b.MSNV) as SoNguoiDung
from KyNang a, NhanVienKyNang b
where a.MSKN=b.MSKN
group by a.TenKN

-- c) Cho biết TenKN có từ 3 nhan viên trong công ty sử dụng trở lên

select a.TenKN, count(b.MSNV) as SoNguoiDung
from KyNang a, NhanVienKyNang b
where a.MSKN=b.MSKN
group by a.TenKN
having count(b.MSNV) >= 3

-- d) Cho biết TenCN có nhiều nhân viên nhất

select b.TenCN, count(a.MSNV) as SoNV 
from NhanVien a, ChiNhanh b
where a.MSCN = b.MSCN
group by b.TenCN
having count(a.MSNV) >= all (select count(c.MSNV)
							from NhanVien c
							group by c.MSCN)

-- e) Cho biết TenCN có it nhân viên nhất

select b.TenCN, count(a.MSNV) as SoNV 
from NhanVien a, ChiNhanh b
where a.MSCN = b.MSCN
group by b.TenCN
having count(a.MSNV) <= all (select count(c.MSNV)
							from NhanVien c
							group by c.MSCN)

-- f) CVới mỗi nhân vien, hãy cho biết số kỹ năng tin học mà nhân viên đó sử dụng được

select a.MSNV, a.Ho+' '+a.Ten as HoTen, count(b.MSKN) as SoKyNang
from NhanVien a, NhanVienKyNang b
where a.MSNV = b.MSNV
group by a.MSNV, a.Ho, a.Ten

-- g) Cho biết HoTen, TenCN của nhân viên biết sử dụng nhiều kỹ năng nhất

select a.Ho+' '+a.Ten as HoTen, count(b.MSKN) as SoKyNang, c.TenCN
from NhanVien a, NhanVienKyNang b, ChiNhanh c
where a.MSNV = b.MSNV and c.MSCN = a.MSCN
group by a.Ho, a.Ten, c.TenCN
having count(b.MSKN) >= all (select count(d.MSKN)
							from NhanVienKyNang d
							group by d.MSNV)

-- 4. Cập nhật dữ liệu
-- a) Thêm bộ <'06','Photoshop'> vào bảng KyNang

insert into KyNang values('06','Photoshop')
select * from KyNang
go

-- b) Thêm các bộ sau vào bảng NhanVienKyNang
-- <'0001','06',3>
-- <'0005','06',2>

insert into NhanVienKyNang values ('0001','06',3)
insert into NhanVienKyNang values ('0005','06',2)
select * from NhanVienKyNang
go

-- c) Cập nhật cho các nhân viên cóp sử dụng kỹ năng 'Word' có mức độ tăng thêm 1 bậc

update NhanVienKyNang 
set MucDo=MucDo+1
where MSKN = '01'
select * from NhanVienKyNang

-- d) Tạo bảng mới NNhanVienChiNhanh1(MaNV,HoTen,SoKyNang)

create table NhanVienChiNhanh1
(
	MSNV char(4) primary key foreign key references NhanVien(MSNV),
	HoTen nvarchar(30),
	SoKyNang tinyint
)
go
select * from NhanVienChiNhanh1

-- e) Thêm vào bảng trên các thông tinn như đã liệt kê của các nhân viên thuộc chi nhánh 1 (Dùng câu lệnh Insert Into cho nhiều bộ)

insert into NhanVienChiNhanh1(MSNV,HoTen,SoKyNang)
select a.MSNV, a.Ho+' '+a.Ten as HoTen, count(b.MSKN) as SoKyNang
from NhanVien a, NhanVienKyNang b
where a.MSNV = b.MSNV and a.MSCN = '01'
group by a.MSNV,a.Ho, a.Ten
select * from NhanVienChiNhanh1
go