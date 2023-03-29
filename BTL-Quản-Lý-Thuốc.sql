create database QuanlyThuoc
on
(
name='QLThuoc',
filename='D:\data\QuanLyThuocBTL.mdf',
size= 5MB,
maxsize =unlimited,
filegrowth=10%
)

use QuanlyThuoc
go

--Tạo bảng Nhân Viên
create table tblNhanVien
(
MaNV nvarchar(10) primary key,
TenNV nvarchar(50),
NgaySinh date,
GioiTinh nvarchar(20) check (GioiTinh='Nam' or GioiTinh=N'Nữ'),
DiaChi nvarchar(50),
Ngayvaolam date,
LuongCB float,
PhuCap float,
DienThoai text
)

--Tạo bảng Nhà Cung Cấp
create table tblNhaCungCap
(
MaNCC nvarchar(10) primary key,
TenNCC nvarchar(50),
DiaChi nvarchar(50),
SDT text
)

--Tạo bảng Loại Thuốc
create table tblLoaiThuoc
(
MaLoaiThuoc nvarchar(10) primary key,
TenLoaiThuoc nvarchar(50)
)

--Tạo bảng Thuốc
create table tblThuoc
(
MaThuoc nvarchar(10) primary key,
MaLoaiThuoc nvarchar(10),
TenThuoc nvarchar(50),
MaNCC nvarchar(10),
NoiSX nvarchar(50),
SoLuong int,
HanSD date,
DonGia float,
DonViThuoc nvarchar(20),
constraint FK_tblThuoc_MaLoaiThuoc foreign key(MaLoaiThuoc) references tblLoaiThuoc(MaLoaiThuoc),
constraint FK_tblThuoc_MaNCC foreign key(MaNCC) references tblNhaCungCap(MaNCC)
)

--Tạo bảng Hoá đơn nhập
create table tblHoaDonNhap
(
SoHD int primary key,
MaNV nvarchar(10),
NgayLap date,
MaNCC nvarchar(10),
MaThuoc nvarchar(10),
Soluong int,
GiaMua float,
constraint FK_tblHoaDonNhap_MaNV foreign key(MaNV) references tblNhanVien(MaNV),
constraint FK_tblHoaDonNhap_MaNCC foreign key(MaNCC) references tblNhaCungCap(MaNCC),
constraint FK_tblHoaDonNhap_MaThuoc foreign key(MaThuoc) references tblThuoc(MaThuoc)
)

--Tạo bảng Hoá đơn xuất
Create table tblHoaDonXuat
(
SoHD int,
MaThuoc nvarchar(10),
MaNV nvarchar(10),
SoLuong int,
GiaBan float,
NgayBan date,
constraint FK_tblHoaDonXuat_MaThuoc foreign key(MaThuoc) references tblThuoc(MaThuoc),
constraint FK_tblHoaDonXuat_MaNV foreign key(MaNV) references tblNhanVien(MaNV)
)

--Chèn dữ liệu bảng tblNhanVien
insert into tblNhanVien(MaNV,TenNV,NgaySinh,GioiTinh,DiaChi,Ngayvaolam,LuongCB,PhuCap,DienThoai)
values
('NV01',N'Phạm Văn Hùng','1994-12-27','Nam',N'Hải Phòng','2000-02-07',4.4,0.6,'0912083435'),
('NV02',N'Nguyễn Thị Lan','1995-06-18',N'Nữ',N'Hà Nội','2000-04-07',3.0,0.1,'0901382426'),
('NV03',N'Nguyễn Hoàng Đức','1995-01-11','Nam',N'Hải Dương','2000-04-07',3.9,0.4,'0801283437'),
('NV04',N'Đặng Thị Hoa','1995-07-06',N'Nữ',N'Nam Định','2000-02-07',3.6,0.1,'0987213579'),
('NV05',N'Lê Minh Hiếu','1994-08-16','Nam',N'Thái Bình','2000-02-07',3.7,0.4,'0123784532')


--Chèn dữ liệu bảng tblNhaCungCap
insert into tblNhaCungCap(MaNCC,TenNCC,DiaChi,SDT)
values 
('001',N'Công ty dược phẩm Hà Tây ',N'Thành Phố Yên Bái,Tỉnh Yên Bái','0906784532'),
('002',N'Công ty cổ phần dược phẩm Nam Á' ,N'Tiên Lãng,Hải Phòng','0945083412'),
('003',N'Công ty dược và trang bị y tế Bình An',N'Huyện Hóc Môn,TP.HCM','0981283438'),
('004',N'Công ty cổ phần Trapaco',N'Quận 9,TP. HCM','0905082421'),
('005',N'Công ty cổ phần xuất nhập khẩu Y Tế Đại Nam',N'Huyện Dilinh,Tỉnh Lâm Đồng','0956713579')


--Chèn dữ liệu bảng tblLoaiThuoc
insert into tblLoaiThuoc(MaLoaiThuoc,TenLoaiThuoc)
values
('L001',N'Dinh dưỡng'),
('L002',N'Xương khớp'),
('L003',N'Giảm đau'),
('L004',N'Tim mạch'),
('L005',N'Tiêu hoá')


--Chèn dữ liệu bảng tblThuoc
insert into tblThuoc(MaThuoc,MaLoaiThuoc,TenThuoc,MaNCC,NoiSX,SoLuong,HanSD,DonGia,DonViThuoc)
values
('T001','L002','Fileos'  ,'001',N'H.Thạnh Thất,TP.Hà Nội',144 ,'2023-12-25',654000,N'Gói'),
('T002','L002','Gomini'  ,'001',N'Ngũ Hành Sơn,Đà Nẵng'  ,652 ,'2022-03-21',150000,N'Lọ'),
('T003','L004','Loii'    ,'002',N'H.Thanh Xuân,TP.Hà Nội',62 ,'2024-11-03',600000,N'Gói'),
('TT04','L004','Monica'  ,'002',N'Quận 9,TP.HCM' ,642 ,'2022-11-03',35000 ,N'Gói'),
('TT05','L001','Dieos'   ,'003',N'Quận 1,TP.HCM' ,5000,'2023-04-16',30000 ,N'Gói'),
('TT06','L005','Fugaka'  ,'004',N'Tiên Lãng,Hải Phòng' ,4000,'2023-08-21',10000 ,N'Viên'),
('TT07','L003','Kolmital','004',N'Huyện Đông Anh,Hà Nội' ,466 ,'2024-10-15',130000,N'Lọ'),
('TT08','L001','Calcium' ,'003',N'Quạn Hoàng Mai,Hà Nội',145,'2024-11-23',495000,N'Lọ'),
('TT09','L003','Paracetamol','005',N'TP Nam Định,Nam Định',231,'2025-01-11',30000,N'Vỉ'),
('TT10','L005','Bioactivemen','005',N'Huyện Yên Phong,Bắc Ninh',100,'2023-09-24',148000,N'Vỉ')

--Chèn dữ liệu bảng tblHoaDonNhap
insert into tblHoaDonNhap(SoHD,MaNV,NgayLap,MaNCC,MaThuoc,Soluong,GiaMua)
values
(1,'NV02','2020-10-24','001','T002',250,120000),
(2,'NV02','2021-09-18','001','T001',100,550000),
(3,'NV01','2020-05-22','002','TT04',320,30000),
(4,'NV03','2021-04-10','003','TT05',600,25000),
(5,'NV01','2021-10-20','002','T003',50,520000),
(6,'NV05','2021-10-05','003','TT08',120,450000),
(7,'NV04','2020-12-27','004','TT07',400,100000)

--Chèn dữ liệu bảng tblHoaDonXuat
insert into tblHoaDonXuat(SoHD,MaThuoc,MaNV,SoLuong,GiaBan,NgayBan)
values
(1,'T001','NV02',1,654000,'2020-02-12'),
(1,'T003','NV02',1,600000,'2020-02-12'),
(2,'TT05','NV03',2,30000,'2020-04-25'),
(2,'TT06','NV03',3,10000,'2020-04-25'),
(2,'TT09','NV03',1,30000,'2020-04-25'),
(3,'T002','NV01',1,150000,'2020-05-13'),
(3,'TT07','NV01',1,130000,'2020-05-13'),
(4,'TT04','NV04',2,35000,'2021-01-28'),
(4,'TT10','NV04',1,148000,'2021-01-28'),
(4,'TT08','NV04',1,495000,'2021-01-28'),
(5,'T002','NV05',1,150000,'2021-02-15'),
(5,'TT07','NV05',2,130000,'2021-02-15'),
(6,'T003','NV03',1,600000,'2021-06-14'),
(6,'TT04','NV03',1,35000,'2021-06-14'),
(7,'TT09','NV01',2,30000,'2021-06-28')

------------------------------------------------------------------------------------------------------------------

--VIẾT LỆNH TRUY VẤN THỰC HIỆN LẤY DỮ LIỆU
--1.Danh sách nhân viên có lương cơ bản trên 3.5
select * from tblNhanVien where LuongCB>3.5

--2.Danh sách hóa đơn xuât của năm 2020
select distinct * from tblHoaDonXuat where year(NgayBan)=2020

--3.Cho danh sach tên thuốc có số lượng lớn hơn 500
select TenThuoc from tblThuoc where SoLuong>500

--4.Danh sach cac nha cung cap co dia chi ở TP.HCM
select * from tblNhaCungCap where DiaChi like N'%TP.HCM%'

-----------------------------------------------------------------------------------------------------------------

--Tạo View
--1. Thống kê các nhân viên có phụ cấp trên 0.2
create view vvPhucapNV
as
	select *from tblNhanVien where PhuCap>0.2

select *from vvPhucapNV
--2. Thống kê tổng hợp theo từng đơn xuất: mã đơn,ngày xuất, tổng số tiền, tổng số mặt hàng
create view vvTongHopDonXuat
as
	select distinct SoHD,count(MaThuoc) as [Tổng số thuốc],sum(GiaBan) as [Tổng tiền] from tblHoaDonXuat
	group by SoHD

select *from vvTongHopDonXuat

--3. Cho biết tên thuốc đã bán được trong năm 2021
create view vvMatHang2021
as
    select MaThuoc,TenThuoc 
	from tblThuoc
	where MaThuoc in (
	      select MaThuoc from tblHoaDonXuat
		  where year(NgayBan) = 2021 )

select * from vvMatHang2021

--4. Cho biết các hoá đơn có giá trị tổng tiền lớn hơn 500000
create view vvHD_Tong_200000
as
    select tblHoaDonNhap.SoHD, NgayLap, sum(tblHoaDonXuat.SoLuong*GiaBan) as [Tổng tiền]
	from tblHoaDonNhap,tblHoaDonXuat
	where tblHoaDonNhap.SoHD = tblHoaDonXuat.SoHD
	group by tblHoaDonNhap.SoHD, NgayLap
	having sum(tblHoaDonXuat.SoLuong*GiaBan) > 500000

select * from vvHD_Tong_200000

--5. Cho biết danh sách tên thuốc không được nhập về trong năm 2021 
create view vvThuockhongnhapve
as
select TenThuoc from tblThuoc
where MaThuoc not in (
           select MaThuoc 
           from tblHoaDonNhap 
           where year(NgayLap) = 2021)

select * from vvThuockhongnhapve

--6. Cho biết tên nhà cung cấp đã cung cấp thuốc thuộc một loại thuốc xác định nào đó 
create view vvTenNCC
as
select TenNCC,TenThuoc
from tblThuoc inner join tblNhaCungCap
on tblThuoc.MaNCC = tblNhaCungCap.MaNCC
inner join tblLoaiThuoc
on tblthuoc.MaLoaiThuoc = tblLoaiThuoc.MaLoaiThuoc
where TenLoaiThuoc = N'Dinh Dưỡng'

select *from vvTenNCC

--7. Cho biết tổng số tiền hàng đã bán được của từng nhân viên trong năm 2020
create view vvTongTienNV2020
as
select tblNhanVien.MaNV,TenNV, sum(tblHoaDonXuat.GiaBan*SoLuong) as [Tổng số tiền bán hàng năm 2020]
from tblNhanVien left join tblHoaDonXuat on tblNhanVien.MaNV = tblHoaDonXuat.MaNV
where year(NgayBan) = 2020
group by TenNV,tblNhanVien.MaNV

select *from vvTongTienNV2020

--8. Cho xem danh sách 2 loại thuốc mua nhiều nhất 
create view vvThuocmuanhieunhat
as
select top 2 TenLoaiThuoc, count(SoHD) as [Số lượng mua]
from tblLoaiThuoc, tblThuoc, tblHoaDonXuat
where tblLoaiThuoc.MaLoaiThuoc = tblThuoc.MaLoaiThuoc
and tblThuoc.MaThuoc = tblHoaDonXuat.MaThuoc
group by TenLoaiThuoc
order by count(SoHD) desc

select * from vvThuocmuanhieunhat

--9. Cho xem danh sách tên thuốc và giá bán trung bình của từng thuốc
create view vvDSTenThuoc_GTB
as
select TenThuoc , avg(GiaBan) as [ Giá trung bình ]
from tblThuoc inner join tblHoaDonXuat
on tblThuoc.MaThuoc= tblHoaDonXuat.MaThuoc
group by TenThuoc

select * from vvDSTenThuoc_GTB

--10. Trong năm 2021, thuốc nào được mua từ 2 lần trở lên
create view vvThuocMua_2Lan
as 
select tblThuoc.MaThuoc,TenThuoc
from tblHoaDonXuat, tblThuoc where tblHoaDonXuat.MaThuoc = tblThuoc.MaThuoc
and year(NgayBan)= 2021
group by tblThuoc.MaThuoc,TenThuoc
having count(tblHoaDonXuat.MaThuoc)>= 2

select * from vvThuocMua_2Lan

---------------------------------------------------------------------------------------------------------------------------

--THỦ TỤC(PROC)
--1.Tạo thủ tục cho danh sách các mặt hàng không được bán trong năm nào đó, với năm là tham số truyền vào
create proc matHangKBD
@nam int
as
	select MaThuoc,TenThuoc from tblThuoc where MaThuoc not in
	(select tblThuoc.MaThuoc from tblHoaDonXuat inner join tblThuoc on tblHoaDonXuat.MaThuoc=tblThuoc.MaThuoc
	where year(tblHoaDonXuat.NgayBan)=@nam )

exec matHangKBD 2020
--2.Tạo thủ tục cho biết tên thuốc, tổng số lượng và tổng số tiền bán trong 1 thang- 1 nam nao đó
create proc thongKeThuoc
@thang int,
@nam int
as
	select tblThuoc.MaThuoc,tblThuoc.TenThuoc,sum(tblHoaDonXuat.SoLuong),sum(GiaBan* tblHoaDonXuat.SoLuong) 
	from tblHoaDonXuat inner join tblThuoc on tblHoaDonXuat.MaThuoc=tblThuoc.MaThuoc
	where year(tblHoaDonXuat.NgayBan)=@nam and month(tblHoaDonXuat.NgayBan)=@thang
	group by tblThuoc.MaThuoc,tblThuoc.TenThuoc

exec thongKeThuoc 2,2021
--3.Tạo thủ tục cho biết tên thuốc đã được nhập của 1 loại thuốc nào đó, trong 1 năm nào đó
create proc thuocNhap
@tenLoaiThuoc nvarchar(50),
@nam int
as
	select tblThuoc.MaThuoc,tblThuoc.TenThuoc from tblHoaDonNhap inner join tblThuoc on tblHoaDonNhap.MaThuoc =tblThuoc.MaThuoc
	inner join tblLoaiThuoc on tblLoaiThuoc.MaLoaiThuoc=tblThuoc.MaLoaiThuoc
	where tblLoaiThuoc.TenLoaiThuoc=@tenLoaiThuoc and year(tblHoaDonNhap.NgayLap)=@nam

exec thuocNhap N'Giảm đau',2020
--4.Tạo thủ tục tăng lương lên 1,5 lần cho các nhân viên đi làm được > năm với số năm được nhập
create proc tangLuong
@sonam int
as
	update tblNhanVien set LuongCB=LuongCB*1.5 from tblNhanVien 
	where datediff(year,Ngayvaolam,getdate())>=@sonam

exec tangLuong 10

--5.Tạo thủ tục cho biết số lượng nhân viên , với tham số ra là số nhân viên nam, nữ và tổng số nv
create proc demNV
@nu int output,
@nam int output
as
	set @nam=0
	set @nu=0
	select @nam =count(MaNV) from tblNhanVien where GioiTinh=N'Nam'
	select @nu =count(MaNV) from tblNhanVien where GioiTinh=N'Nữ'
	return @nam+@nu
declare @snam int,@snu int, @S int

exec @S=demNV
		@nam=@snam output,
		@nu=@snu output
select @snam as [số nhân viên nam] , @snu as [số nhân viên nữ], @S as [tổng số NV]

--6.Tạo thủ tục thêm 1 loại thuốc 
create proc themThuoc
@maLoaiThuoc nvarchar(10),
@tenloaiThuoc nvarchar(50)
as
	if exists(select* from tblThuoc where MaLoaiThuoc=@maLoaiThuoc)
		begin
			print('Loai thuoc da co trong danh sach')
			return
		end
	else
		begin
			insert into tblLoaiThuoc
			values (@maLoaiThuoc,@tenloaiThuoc)
			print('them thanh cong')
		end
exec themThuoc N'L004',N'Tiêu sưng'
exec themThuoc N'L006',N'Tiêu sưng'

--7.Tạo thủ tục cho biết nhà cung cấp có địa chỉ- là tham số truyền vào
create  proc NCCDiachi
@diachi nvarchar(50)
as
	select tblNhaCungCap.TenNCC,tblNhaCungCap.DiaChi
	from tblNhaCungCap where tblNhaCungCap.DiaChi like %@diachi%

exec NCCDiachi N'hà nội'
--8.Thêm dữ liệu vào bảng tblHoaDonXuat,kèm đk 
create proc prthemdl
@maHD int,
@maT nvarchar(10),
@maNV varchar(10),
@Sol int,
@giaB float,
@ngayB date
as
  begin
	if @maT not in (select tblThuoc.MaThuoc from tblThuoc)
	   begin 
		  print N'Mã Thuốc ko tồn tại '
		end
	else
	  if @maNV not in (select tblNhanVien.MaNV from tblNhanVien )
		begin 
		     print N'Mã nhân viên ko tồn tại '
		end
	else 
		 begin
		     INSERT INTO tblHoaDonXuat
		     VALUES (@maHD, @maT , @maNV ,@Sol , @giaB, @ngayB ) 
		        print N'Chèn thành công'
		 end
	end           
exec prthemdl  @maHD=1,@maT='T020',@maNV=N'NV03',@Sol=6,@giaB=389016,@ngayB='2020-02-12'--ko tồn tại maT
exec prthemdl  @maHD=4,@maT='T003',@maNV=N'NV54',@Sol=8,@giaB=899018,@ngayB='2021-03-12'--ko ton tai manv
exec prthemdl  @maHD=5,@maT='T002',@maNV=N'NV05',@Sol=2,@giaB=130000,@ngayB='2021-02-15'--chen thanh cong
--9.Danh sách tên các loại thuốc đã nhập trong hóa đơn 
create  proc prDSnhap
@SHD int 
as
   Select MaThuoc,TenThuoc
   From tblThuoc
   Where MaThuoc  IN (
	             Select tblThuoc.MaThuoc
				 from tblHoaDonNhap inner join tblThuoc 
				 on tblHoaDonNhap.MaThuoc=tblThuoc.MaThuoc
				 where tblHoaDonNhap.SoHD = @SHD)
  
  exec prDSnhap @SHD = 4 

--10.Ds tên các loại thuoc nhập về với tổng số lượng =200
alter  proc prDStongluongnhap
@Soln int
as
   Select MaThuoc,TenThuoc
   From  tblThuoc
   Where MaThuoc in (
		     Select MaThuoc
			 From tblHoaDonNhap  
	         group by MaThuoc
		     having sum(Soluong) > @Soln)
	   
exec prDStongluongnhap @Soln = 200

---------------------------------------------------------------------------------------------
  ----------TRIGGER-
--1.Trigger nhập số lượng thuốc thêm 100 
create trigger trthemthuoc
on tblHoaDonNhap
 for insert
 as
 begin
    Declare @Sol int
	Select Soluong=@Sol from inserted
	update tblHoaDonNhap set Soluong = Soluong + 100 
    Where @Sol=Soluong
  end 

insert into tblHoaDonNhap(SoHD,MaNV,NgayLap,MaNCC,MaThuoc,Soluong,GiaMua)
values (14,'NV04','2020-12-27','003','T002',200,120000)

Select *From tblHoaDonNhap

--2.Tạo một cột TongTienBan trong tblThuoc
alter table tblThuoc
add TongSL  float

update tblThuoc set TongSL =0

  --Trigger khi thêm vào bảng tblHoaDonXuat thì tổng số lượng thuốc đã bán được tăng tương ứng 
 alter  trigger trTang
 on tblHoaDonXuat
 for insert 
 as 
   begin
    Declare @sl int,@maT nvarchar(10)
    select @sl=Soluong,@maT=MaThuoc From inserted
    update tblThuoc
    set TongSL =TongSL  +@sl
    Where @maT=MaThuoc
   end
   
   select *from tblHoaDonXuat
   select *from tblThuoc 
insert into tblHoaDonXuat(SoHD,MaThuoc,MaNV,SoLuong,GiaBan,NgayBan)
values(1,'T003','NV02',1,600000,'2020-02-12')
-
--3.Xóa một dòng trong tblHoaDonXuat thì tổng tiền bán giảm đi 
  alter  trigger trGiam
  on tblHoaDonXuat
  for Delete 
  as
   begin
     Declare @sl int,@maT nvarchar(10)
     select @sl=Soluong,@maT=MaThuoc From deleted
     update tblThuoc
     set TongSL= TongSL -@sl
     Where @maT=MaThuoc
    end

   select *from tblThuoc 
   select *from tblHoaDonXuat
insert into tblHoaDonXuat(SoHD,MaThuoc,MaNV,SoLuong,GiaBan,NgayBan)
values(1,'T003','NV02',1,600000,'2020-02-12')

--4.Viết Trigger tuổi của các nhân viên ko được quá 30 
create trigger trTuoi
on tblNhanVien
for insert,update
  as
  begin
    Declare @tuoi int
	set @tuoi =(Select datediff(day,Ngaysinh ,getdate())/365 from inserted )
	if(@tuoi >30)
	  begin
	      print N'nhân viên ko quá 30 tuổi'
	      rollback tran
      end 
  end
select *from tblNhanVien 
insert into tblNhanVien(MaNV,TenNV,NgaySinh,GioiTinh,DiaChi,Ngayvaolam,LuongCB,PhuCap,DienThoai)
values('NV112',N'Văn Hùng','1880-12-27','Nam',N'Hải Phòng','2000-02-07',4.4,0.6,'0912083435')
--5.Viết trigger để đảm bảo giá nhập vào < giá bán ra 
CREATE TRIGGER trDambao 
ON tblHoaDonNhap
for insert
AS
   begin 
	declare @giamua float,
			@giaban float,
			@maHD int
	SELECT @giamua=GiaMua , @maHD=SoHD  from inserted
	SELECT @giaban=GiaBan from tblHoaDonXuat  where @maHD=SoHD 
	IF(@giaban<@giamua)
	begin
	PRINT N'Không tồn tại '
	rollback tran
	end
END
insert into tblHoaDonNhap(SoHD,MaNV,NgayLap,MaNCC,MaThuoc,Soluong,GiaMua)
values(1,'NV02','2020-10-24','001','T002',250,12000000)
Select *From tblHoaDonNhap
Select *From tblHoaDonXuat 
---6.Trigger tăng lương lên 1.2 cho nhân viên 
create trigger trTangluong
on tblNhanVien
for insert 
  as
  begin
    Declare @lcb float
	select @lcb =LuongCB from  inserted 
	update tblNhanVien set LuongCB=LuongCB + 1.2
	Where @lcb =LuongCB 
  end

insert into tblNhanVien(MaNV,TenNV,NgaySinh,GioiTinh,DiaChi,Ngayvaolam,LuongCB,PhuCap,DienThoai)
values('NV00',N'Hùng','1994-12-27','Nam',N'Hải Phòng','2000-02-07',4.4,0.6,'0912083435')
select *from tblNhanVien 
--7.Viết trigger delete xóa tên thuốc 
create trigger trXoaten
on tblThuoc
for delete 
 as
   begin 
      Declare @tenT nvarchar(50)
	  select @tenT =TenThuoc from deleted 
	  rollback tran
	  update tlbThuoc set  @tenT =TenThuoc
   end 

--8 Viết trigger gt của nhân viên là nam hoặc nữ 
create trigger trGT
on tblNhanVien
for insert  
 as
   begin 
      Declare @gt  nvarchar(20)
	  select @gt =GioiTinh from inserted 

	  if (@gt not in (N'nam', N'nữ'))
	  begin
	     print 'ban nhap sai'
	  rollback tran
	  end 
   end 
select *from tblNhanVien 
insert into tblNhanVien(MaNV,TenNV,NgaySinh,GioiTinh,DiaChi,Ngayvaolam,LuongCB,PhuCap,DienThoai)
values('NV0',N'k','1994-12-27','Nam',N'Hải Phòng','2000-02-07',4.4,0.6,'0912083435')
--9 Viết trigger Ngayvaolam phải nhỏ hơn ngày sinh 
create trigger trNgay
on tblNhanVien
for insert ,update
  as
   if update (Ngayvaolam)
  begin
    Declare @ngS  date,@ngVL date 	   
	select @ngS =NgaySinh from  inserted 
	select @ngVL =Ngayvaolam from  inserted 
	if(@ngS>@ngVL)
	begin
	 print N'ko hop le'
	 rollback tran
	 end	
  end
select *from tblNhanVien
insert into tblNhanVien(MaNV,TenNV,NgaySinh,GioiTinh,DiaChi,Ngayvaolam,LuongCB,PhuCap,DienThoai)
values('NV04',N'Hùng','2021-12-27','Nam',N'Hải Phòng','2000-02-07',4.4,0.6,'0912083435')

