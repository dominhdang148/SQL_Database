---------------------------------------------------------------------
--Học phần Cơ sở dữ liệu
--Ngày 11/03/2022
--Người thực hiện: Đỗ Minh Đăng
---------------------------------------------------------------------

--I. TẠO CSDL VÀ NHẬP DỮ LIỆU

create database Lab03_QuanLyHangHoa
go

use Lab03_QuanLyHangHoa
go

create table HangHoa
(
	MaHH varchar(5) primary key,
	TenHH varchar(30),
	DVT char(10),
	SoLuongTon int
)
 go

 create table DoiTac
 (
	MaDT char(5) primary key,
	TenDT nvarchar(20),
	DiaChi nvarchar(40),
	DienThoai char(11)
 )
 go

 create table KhaNangCC
 (
	MaDT char(5) references DoiTac(MaDT),
	MaHH varchar(5) references HangHoa(MaHH),
	primary key(MaDT, MaHH)
 )
 go

 create table HoaDon
 (
	SoHD char(5) primary key,
	NgayLapHoaDon dateTime,
	MaDT char(5) references DoiTac(MaDT),
	TongTG int
 )
 go 

 create table CT_HoaDon
 (
	SoHD char(5) references HoaDon(soHD),
	MaHH varchar(5) references HangHoa(MaHH),
	DonGia int,
	SoLuong int
	primary key(SoHD,MaHH)
 )
 go

 --Xem dữ liệu từ các bảng
 select * from HangHoa
 select * from DoiTac
 select * from KhaNangCC
 select * from HoaDon
 select * from CT_HoaDon
 go

 --Nhập dữ liệu cho HangHoa

 insert into HangHoa values ('CPU01','CPU INTEL, CELERON 600 BOX',N'Cái', 5)
 insert into HangHoa values ('CPU02','CPU INTEL, PIII 700',N'Cái',10)
 insert into HangHoa values ('CPU03','CPU AMD, K7 ATHL, ON 600',N'Cái',8)
 insert into HangHoa values ('HDD01','HDD 10.2GB QUANTUM',N'Cái',10)
 insert into HangHoa values ('HDD02','HDD 13.6GB SEAGATE',N'Cái',15)
 insert into HangHoa values ('HDD03','HDD 20GB QUANTUM',N'Cái',6)
 insert into HangHoa values ('KB01','KB GENIUS',N'Cái',12)
 insert into HangHoa values ('KB02','KB MITSUMIMI',N'Cái',5)
 insert into HangHoa values ('MB01','GIGABYTE CHIPSET INTEL',N'Cái',10)
 insert into HangHoa values ('MB02','ACORP BX CHIPSET VIA',N'Cái',10)
 insert into HangHoa values ('MB03','INTEL PHI CHIPSET INTEL',N'Cái',10)
 insert into HangHoa values ('MB04','ESC CHIPSET SIS',N'Cái',10)
 insert into HangHoa values ('MB05','ESC CHIPSET VIA',N'Cái',10)
 insert into HangHoa values ('MNT01','SAMSUNG 14" SYNCMASTER',N'Cái',5)
 insert into HangHoa values ('MNT02','LG 14"',N'Cái',5)
 insert into HangHoa values ('MNT03','ACER 14"',N'Cái',8)
 insert into HangHoa values ('MNT04','PHILIPS 14"',N'Cái',6)
 insert into HangHoa values ('MNT05','VIEWSONIC 14"',N'Cái',7)
 select * from HangHoa
 go

 --Nhập liệu cho DoiTac

 insert into DoiTac values ('CC001', N'Cty TNC',N'176 BTX Q1 - TPHCM','08.8250259')
 insert into DoiTac values ('CC002', N'Cty Hoàng Long',N'15A TTT Q1 - TPHCM','08.8250898')
 insert into DoiTac values ('CC003', N'Cty Hợp Nhất',N'152 BTX Q1 - TPHCM','08.8250376')
 insert into DoiTac values ('K0001', N'Nguyễn Minh Hải',N'91 Nguyễn Văn Trỗi Tp. Đà Lạt','063.831129')
 insert into DoiTac values ('K0002', N'Như Quỳnh',N'21 Điện Biên Phủ. Nha Trang','058.590270')
 insert into DoiTac values ('K0003', N'Trần Nhật Duật',N'Lê Lợi TP.Huế','054.848376')
 insert into DoiTac values ('K0004', N'Phan Nguyễn Hùng Anh',N'11 Nam Kỳ Khởi Nghĩa Tp. Đà Lạt','063.823409')
 select * from DoiTac
 go

 -- Nhập dữ liệu cho KhaNangCC

 insert into KhaNangCC values ('CC001','CPU01')
 insert into KhaNangCC values ('CC001','HDD03')
 insert into KhaNangCC values ('CC001','KB01')
 insert into KhaNangCC values ('CC001','MB02')
 insert into KhaNangCC values ('CC001','MB04')
 insert into KhaNangCC values ('CC001','MNT01')
 insert into KhaNangCC values ('CC002','CPU01')
 insert into KhaNangCC values ('CC002','CPU02')
 insert into KhaNangCC values ('CC002','CPU03')
 insert into KhaNangCC values ('CC002','KB02')
 insert into KhaNangCC values ('CC002','MB01')
 insert into KhaNangCC values ('CC002','MB05')
 insert into KhaNangCC values ('CC002','MNT03')
 insert into KhaNangCC values ('CC003','HDD01')
 insert into KhaNangCC values ('CC003','HDD02')
 insert into KhaNangCC values ('CC003','HDD03')
 insert into KhaNangCC values ('CC003','MB03')
 select * from KhaNangCC
 go

 --Nhập dữ liệu cho HoaDon
 set dateformat dmy
 insert into HoaDon values('N0001','25/01/2006','CC001',null)
 insert into HoaDon values('N0002','01/05/2006','CC002',null)
 insert into HoaDon values('X0001','12/05/2006','K0001',null)
 insert into HoaDon values('X0002','16/06/2006','K0002',null)
 insert into HoaDon values('X0003','20/04/2006','K0001',null)
 select * from HoaDon
 go

 --Nhập dữ liệu cho CT_HoaDon

 insert into CT_HoaDon values('N0001','CPU01',63,10)
 insert into CT_HoaDon values('N0001','HDD03',97,7)
 insert into CT_HoaDon values('N0001','KB01',3,5)
 insert into CT_HoaDon values('N0001','MB02',57,5)
 insert into CT_HoaDon values('N0001','MNT01',112,3)
 insert into CT_HoaDon values('N0002','CPU02',115,3)
 insert into CT_HoaDon values('N0002','KB02',5,7)
 insert into CT_HoaDon values('N0002','MNT03',111,5)
 insert into CT_HoaDon values('X0001','CPU01',67,2)
 insert into CT_HoaDon values('X0001','HDD03',100,2)
 insert into CT_HoaDon values('X0001','KB01',5,2)
 insert into CT_HoaDon values('X0001','MB02',62,1)
 insert into CT_HoaDon values('X0002','CPU01',67,1)
 insert into CT_HoaDon values('X0002','KB02',7,3)
 insert into CT_HoaDon values('X0002','MNT01',115,2)
 insert into CT_HoaDon values('X0003','CPU01',67,1)
 insert into CT_HoaDon values('X0003','MNT03',115,2)
 select * from CT_HoaDon
 go

 --delete from CT_HoaDon
 --II. TRUY VẤN DỮ LIỆU
 -- Câu 1) Liệt kê các mặt hàng thuộc loại đĩa cứng (HDD)
 
 select * 
 from HangHoa a
 where a.MaHH like '%HDD%'

 -- Câu 2) Liệt kê các mặt hàng có số lương tồn trên 10

 select *
 from HangHoa a
 where a.SoLuongTon >=10

 -- Câu 3) Cho biết thông tin về các nhà cung cấp ở Thành phố Hồ Chí Minh

 select * 
 from DoiTac a
 where a.DiaChi like '%TPHCM%'

 -- Câu 4) Liệt kê các hóa đơn nhập hàng trong tháng 5/2006 

select B.SoHD, A.MaDT, convert(char(10),NgayLapHoaDon,105), TenDT, DiaChi, DienThoai, count(mahh) as SoMATHANG
from DoiTac A, CT_HoaDon B, HoaDon C
where A.MaDT = C.MaDT and C.SoHD = B.SoHD and MONTH(NgayLapHoaDon) =5 and YEAR(NgayLapHoaDon) =2006 AND B.SOHD  LIKE 'N%'
group by A.MaDT, TenDT, DiaChi, DienThoai, B.SoHD, NgayLapHoaDon

 -- Câu 5) Cho biết tên các nhà cung cấp có cung cấp đĩa cứng

 select distinct a.MaDT, a.TenDT, a.DiaChi, a.DienThoai 
 from DoiTac a, CT_HoaDon b, HoaDon c
 where a.MaDT= c.MaDT and b.SoHD=c.SoHD and a.MaDT like '%CC%' and b.MaHH like '%HDD%'
 
 -- Câu 6) Cho biết tên các nhà cung cấp có thể cung cấp đĩa cứng

select distinct a.MaDT, a.TenDT, a.DiaChi, a.DienThoai
from DoiTac a, KhaNangCC b
where a.MaDT=b.MaDT and a.MaDT like '%CC%' and b.MaHH like '%HDD%'

-- Câu 7) Cho biết tên nhà cung cấp không cung cấp ổ đĩa cứng

select distinct a.MaDT, a.TenDT, a.DiaChi, a.DienThoai 
from DoiTac a, KhaNangCC b
where a.MaDT=b.MaDT and a.MaDT like '%CC%' and a.MaDT not in (select c.MaDT
															from DoiTac c, KhaNangCC d
															where c.MaDT=d.MaDT and c.MaDT like '%CC%' and d.MaHH like '%HDD%')

-- Câu 8) Cho biết thông tin của mặt hàng chưa bán được

select *
from HangHoa a 
where a.MaHH not in (select b.MaHH
					from CT_HoaDon b
					where b.SoHD like '%X%')

-- Câu 9) Cho biết tên và tổng số lượng ban của mặt hàng bán chạy nhất

select b.MaHH, a.TenHH, SUM(b.SoLuong) as TongSoLuong
from HangHoa a, CT_HoaDon b
where a.MaHH=b.MaHH and b.soHD like '%X%'
group by b.MaHH, a.TenHH
having SUM(b.SoLuong) >=all (select sum(d.SoLuong)
							from CT_HoaDon d
							where d.SoHD like '%X%'
							group by d.MaHH)

-- Câu 10) Cho biết tên và tổng số lượng của mặt hàng nhập về ít nhất

select b.MaHH ,a.TenHH, sum(b.SoLuong) as TongSoLuong
from HangHoa a, CT_HoaDon b
where a.MaHH = b.MaHH and b.SoHD like '%N%'
group by b.MaHH, a.TenHH
having sum(b.SoLuong) <= all (select sum(d.SoLuong)
							from CT_HoaDon d
							where d.SoHD like '%N%'
							group by d.MaHH)

-- Câu 11) Cho biết hóa đơn nhập nhiều mặt hàng nhất

select a.SoHD, NgayLapHoaDon, MaDT, sum(b.SoLuong) as TongSoMatHang
from HoaDon a, CT_HoaDon b
where a.SoHD=b.SoHD and a.SoHD like '%N%'
group by a.SoHD, a.NgayLapHoaDon, a.MaDT
having sum(b.SoLuong) >= all(select sum(c.SoLuong)
							from CT_HoaDon c
							where c.SoHD like '%N%'
							group by c.SoHD)

-- Câu 12) Cho biết các mặt hàng không được nhập hàng trong tháng 1/2006

select *
from HangHoa a
where a.MaHH not in (select b.MaHH
					from CT_HoaDon b, HoaDon c
					where b.SoHD = c.SoHD and b.SoHD like '%N%' and MONTH(c.NgayLapHoaDon) = 1 and YEAR(c.NgayLapHoaDon) =2006)

-- Câu 13) Cho biết các mặt hàng không bán được trong tháng 6/2006

select *
from HangHoa a
where a.MaHH not in (select b.MaHH
					from CT_HoaDon b, HoaDon c
					where b.SoHD = c.SoHD and b.SoHD like '%X%' and MONTH(c.NgayLapHoaDon) = 6 and YEAR(c.NgayLapHoaDon) =2006)

-- Câu 14) Cho biết cửa hàng bán bao nhiêu mặt hàng

select count(MaHH)
from HangHoa

-- Câu 15) Cho biết số mặt hàng mà từng nhà cung cấp có khả năng cung cấp

select a.MaDT,a.TenDT, count(b.MaHH) as SoMatHang
from DoiTac a, KhaNangCC b
where a.MaDT = b.MaDT
group by a.MaDT, a.TenDT

-- Câu 16) Cho biết thông tin của khách hàng có giao dịch với cửa hàng nhiều nhất



-- Câu 17) Tính tổng doanh thu 2006



-- Câu 18) Cho biết mặt hàng bán chạy nhất



-- Câu 19) Liệt kê thông tin bán hàng của tháng 5 /2006 bao gồm mhh, tenhh, dvt, tổng số lượng, tổng thành tiền



-- Câu 20) Liệt kê thông tin của mặt hàng có nhiều người mua nhất



-- Câu 21) Tính và cập nhật Tổng giá trị của các hóa đơn



-- III. THỦ TỤC VÀ HÀM
