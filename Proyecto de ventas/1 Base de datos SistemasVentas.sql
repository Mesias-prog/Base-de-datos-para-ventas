create database SistemasVentas
go
use SistemasVentas
go
--Tabla de los clientes
create table Clientes(
Clienteid int identity (1,1) primary key,
NombreCliente nvarchar(100) not null,
Telefono nvarchar (10)not null,
Correo nvarchar(max),
Direccion nvarchar(max));
--Tabla de los productos
create table productos(
Productoid int identity(1,1) primary key,
NombreProducto nvarchar(50)not null,
Descripcion nvarchar(max),
PrecioUnitario decimal(10,2) not null,
stock int not null);
--tabla de las ventas 
create table ventas(
Ventaid varchar(10) primary key,
Clienteid int not null,
FechaVenta date default getdate(),
total Decimal(10,2) default 0,
foreign key (Clienteid) references Clientes (Clienteid));
--detalles de la venta
create table detalleventas(
Detalleid int identity(1,1) primary key,
Ventaid varchar(10) not null,
Productoid int not null,
Cantidad int not null,
Preciounitario decimal(10,2) not null,
Subtotal as (Cantidad * Preciounitario) persisted,
foreign key (Ventaid) references ventas(Ventaid),
foreign key (Productoid) references productos(Productoid));
--tabla para agregar muchos productos a una venta
go
create type Detalleventastype as table(
Productoid int,
Cantidad int);
go