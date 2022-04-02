
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
create table ThanhPho
(
	MaTP char(2) primary key,
	TenTP nvarchar(10)
)
