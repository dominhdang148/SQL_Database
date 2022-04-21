-----------------------------------------------------------------
--Học phần Cơ Sở Dữ Liệu
--Ngày: 03/04/2022
--Người thực hiện: Đỗ Minh Đăng
-----------------------------------------------------------------
--Lệnh tạo CSDL
create database Lab02_QuanLySanXuat
go
--Lệnh sử dụng CSDL
use Lab02_QuanLySanXuat
go
--Lệnh tạo các bảng
create table ToSanXuat
(MaTSX char(4) primary key, 
TenTSX nchar(5) not null unique)
go
create table CongNhan
(MACN char(5) primary key,
Ho nvarchar(20),
Ten nvarchar(10),
Phai nchar(3), 
NgaySinh dateTime, 
MaTSX char(4) references ToSanXuat(MaTSX) 
)
go
create table SanPham
(MASP char(5) primary key, 
TenSP nchar(30) not null unique, 
DTV nvarchar(10), 
TienCong int check(TienCong>0)
)
go
create table ThanhPham
(MACN char(5) references CongNhan(MACN), 
MASP char(5) references SanPham(MASP), 
Ngay dateTime, 
SoLuong int check(SoLuong>=0),
primary key(MACN,MaSP,Ngay)
)
go
-- Xem các bảng
select * from ToSanXuat
select * from CongNhan
select * from SanPham
select * from ThanhPham
go
--Nhập dữ liệu cho các bảng
insert into ToSanXuat values('TS01',N'Tổ 1')
insert into ToSanXuat values('TS02',N'Tổ 2')
insert into ToSanXuat values('TS03',N'Tổ 3')
select * from ToSanXuat
go

insert into SanPham values('SP001',N'Nồi đất',N'cái',10000)
insert into SanPham values('SP002',N'Chén',N'cái',2000)
insert into SanPham values('SP003',N'Bình gốm nhỏ',N'cái',20000)
insert into SanPham values('SP004',N'Bình gốm lớn',N'cái',25000)
select* from SanPham
go

insert into CongNhan values('CN001',N'Nguyễn Trường',N'An',N'Nam','5/12/1981','TS01')
insert into CongNhan values('CN002',N'Lê Thị Hồng',N'Gấm',N'Nữ','6/4/1980','TS01')
insert into CongNhan values('CN003',N'Nguyễn Công',N'Thành',N'Nam','5/4/1981','TS02')
insert into CongNhan values('CN004',N'Võ Hữu',N'Hạnh',N'Nam','2/15/1980','TS02')
insert into CongNhan values('CN005',N'Lý Thanh',N'Hân',N'Nữ','12/3/1981','TS01')
select * from CongNhan
go

insert into ThanhPham values('CN001','SP001','02/01/2007',10)
insert into ThanhPham values('CN002','SP001','02/01/2007',5)
insert into ThanhPham values('CN003','SP002','01/10/2007',50)
insert into ThanhPham values('CN004','SP003','01/12/2007',10)
insert into ThanhPham values('CN005','SP002','01/12/2007',10)
insert into ThanhPham values('CN002','SP004','02/13/2007',10)
insert into ThanhPham values('CN001','SP003','02/14/2007',15)
insert into ThanhPham values('CN003','SP001','01/15/2007',20)
insert into ThanhPham values('CN003','SP004','02/14/2007',15)
insert into ThanhPham values('CN004','SP002','01/30/2007',100)
insert into ThanhPham values('CN005','SP003','02/01/2007',50)
insert into ThanhPham values('CN001','SP001','02/20/2007',50)
select * from ThanhPham
go
--Câu 1 trang 5/16
select b.TenTSX, a.Ho+' '+a.Ten as HoTen, a.NgaySinh, a.Phai
from ToSanXuat b, CongNhan a
Where a.MaTSX=b.MaTSX
Order by TenTSX,Ten
--Câu 2 trang 5/16
select a.TenSP, b.Ngay, b.SoLuong, SoLuong*TienCong as ThanhTien 
from SanPham a, ThanhPham b, CongNhan c
where b.MaSP=a.MASP and b.MACN=c.MACN and c.Ho+' '+c.Ten=N'Nguyễn Trường An'
Order by b.Ngay
--Câu 3 trang 5/16
select *
from CongNhan a
where a.MACN not in (select b.MACN
					from ThanhPham b, SanPham c
					where b.MASP=c.MASP and c.TenSP=N'Bình gốm lớn')
--Câu 4 trang 5/16
select a.MACN,a.Ho,a.Ten,a.Phai,a.NgaySinh,a.MaTSX
from CongNhan a,ThanhPham b, SanPham c
where a.MACN=b.MACN and b.MASP=c.MASP and TenSP=N'Nồi đất' 
	and a.MaCN in (select d.MaCN
				from ThanhPham d, SanPham e
				where d.MASP=e.MASP and e.TenSP=N'Bình gốm nhỏ')
--Câu 5 trang 5/16
select TenTSX, Count(MACN) as SoCongNhan
from ToSanXuat a, CongNhan b
where a.MaTSX=b.MaTSX
group by TenTSX
--Câu 6 trang 5/16
select A.MACN,Ho+' '+Ten as HoTen, b.TenSP, SUM(SoLuong) as TongSLThanhPham, SUM(SoLuong*TienCong) as TongThanhTien
from CongNhan A, SanPham B, ThanhPham C
where A.MACN=C.MACN and b.MASP=c.MASP
group by a.MACN, Ho, Ten, TenSP
order by a.MaCN
--Câu 7 trang 5/16
select Sum(SoLuong*TienCong) as TongSoTienCongThang01
from SanPham a, ThanhPham b
where a.MASP=b.MASP and MONTH(b.Ngay)=01 and YEAR(b.Ngay)=2007
--Câu 8 trang 5/16
select a.MASP, b.TenSP, sum(SoLuong) as TongSL
from ThanhPham a, SanPham b
where a.MASP=b.MASP and MONTH(Ngay)=2 and  YEAR(Ngay)=2007
group by A.MASP, b.TenSP
having sum(SoLuong) >= all (Select SUM(c.SoLuong)
							from ThanhPham c
							where MONTH(Ngay)=2 and Year(Ngay)=2007
							group by c.MASP)
--Câu 9 trang 5/16
select a.MACN, Ho + ' ' +Ten as HoTen, SUM(SoLuong) as TongSoLuong
from CongNhan a, SanPham b, ThanhPham c
where a.MACN=c.MACN and b.MASP=c.MASP and b.TenSP=N'Chén'
group by a.MACN, Ho, Ten
Having Sum(SoLuong) >= all (Select Sum(d.SoLuong)
							from ThanhPham d, SanPham e
							where e.MASP=d.MASP and e.TenSP =N'Chén'
							group by d.MACN)
--Câu 10 trang 5/16
select sum(SoLuong*TienCong) as LuongThang
from ThanhPham a, SanPham b
where a.MASP = b.MASP and MONTH(Ngay)=2 and Year(Ngay)=2007 and a.MACN='CN002'
--Câu 11 trang 5/16
select a.MACN, Ho+' '+ Ten as HoTen, count(b.MASP) as SoSanPham 
from CongNhan a, ThanhPham b
where a.MACN=b.MACN 
group by a.MACN, a.Ho, a.Ten
having count(distinct b.MASP)>=3
--Câu 12 trang 5/16
update SanPham
set TienCong=TienCong+1000
where TenSP like N'Bình gốm%'

select* from SanPham
--Câu 13 trang 5/16
insert into CongNhan (MACN,Ho,Ten,Phai,MaTSX) values('CN006',N'Lê Thị',N'Lan', N'Nữ','TS02')
select * from CongNhan

delete from CongNhan where MACN='CN006'

-- III. Thủ tục và hàm

-- A. Viết các hàm sau:
-- a) Tính tổng số công nhân của một tổ sản xuất cho trước:

create function TinhTongSoCongNhanCuaToSX(@MaTSX char(4))
returns int
as
	begin
		declare @soCN int
		select @soCN = count(MACN)
		from CongNhan
		where MaTSX = @MaTSX
		return @soCN
	end
go

select dbo.TinhTongSoCongNhanCuaToSX('TS01') as N'Số Công nhân'

-- b) Tình tổng sản lượng sản xuất trong một tháng của một công nhán cho trước

create function TinhTongSanLuongTrongMotThangCuaCongNhan(@MaCN char(5), @Thang int)
returns int
as
	begin
		declare @TongSL int 
		select @TongSL = sum(SoLuong)
		from ThanhPham
		where MACN=@MaCN and Month(Ngay)=@Thang
		return @TongSL
	end
go

select dbo.TinhTongSanLuongTrongMotThangCuaCongNhan('CN001', 2) as TongSL

-- c) Tính tổng tiền công tháng của một công nhân cho trước

create function TinhTongTienCongThangCuaCongNhan(@MaCN char(5), @Thang int)
returns int
as
	begin 
		declare @ThanhTien int
		select @ThanhTien = sum(a.SoLuong*b.TienCong)
		from ThanhPham a, SanPham b
		where a.MASP=b.MASP and a.MACN = @MaCN and MONTH(a.Ngay)=@Thang
		return @ThanhTien
	end
go

select dbo.TinhTongTienCongThangCuaCongNhan('CN001',2) as TongThanhTien

-- d) Tính tổng thu nhập trong năm của một tổ sản xuất cho trước

create function TinhTongThuNhapNamCuaToSX(@MaTSX char(4), @Nam int)
returns int
as
	begin
		declare @TongTN int
		select @TongTN = Sum(c.TienCong*a.SoLuong)
		from ThanhPham a, CongNhan b, SanPham c
		where a.MACN=b.MACN and a.MASP = c.MASP and b.MaTSX = @MaTSX and Year(a.Ngay) = @Nam
		return @TongTN
	end
go

select dbo.TinhTongThuNhapNamCuaToSX('TS01',2007) as N'Tổng Thu nhập'
select * 
from ThanhPham a, CongNhan b, SanPham c
where a.MACN=b.MACN and a.MASP=c.MASP and b.MaTSX = 'TS01'

-- e) Tính tổng sản lượng sản xuất của một loại sản phẩm trong một khoảng thời gian cho trước

create function TinhTongSLSXCuaMotSanPhamTrongThang(@MaSP char(5), @Thang int)
returns int
as
	begin
		declare @TongSP int
		select @TongSP = Sum(SoLuong)
		from ThanhPham
		where MASP = @MaSP and MONTH(Ngay) = @Thang
		return @TongSP
	end
go

select dbo.TinhTongSLSXCuaMotSanPhamTrongThang('SP001',2) as TongSLSX
select * from ThanhPham

-- B. Viết các thủ tục sau:
-- a) In danh sách các công nhân của một tổ sản xuất cho trước

create proc InDSTo @MaTSX char(4)
as
	select *
	from CongNhan
	where MaTSX=@MaTSX
go

exec dbo.InDSTo 'TS02'

-- b) In bảng chấm công sản xuất trong tháng của một công nhân cho trước (Bao gồm Ten sản phẩm, đơn vị tính, sổ lượng sản xuất trong tháng, đơn giá, thành tiền)

create proc InBangChamCong @MaCN char(5), @Thang int
as
	select a.TenSP, a.DTV, Sum(SoLuong) as SoLuongSX, a.TienCong as DonGia, Sum(a.TienCong * b.SoLuong) as ThanhTien
	from SanPham a, ThanhPham b
	where a.MASP=b.MASP and b.MACN = @MaCN and Month(b.Ngay)=@Thang
	group by a.TenSP, a.DTV, a.TienCong
go

exec dbo.InBangChamCong 'CN001',2
select * from ThanhPham