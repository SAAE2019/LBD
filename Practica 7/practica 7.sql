USE [master]
GO
/****** Object:  Database [estebandb]    Script Date: 01/06/2020 02:37:59 a. m. ******/
CREATE DATABASE [estebandb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'estebandb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\estebandb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'estebandb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\estebandb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [estebandb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [estebandb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [estebandb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [estebandb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [estebandb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [estebandb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [estebandb] SET ARITHABORT OFF 
GO
ALTER DATABASE [estebandb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [estebandb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [estebandb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [estebandb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [estebandb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [estebandb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [estebandb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [estebandb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [estebandb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [estebandb] SET  ENABLE_BROKER 
GO
ALTER DATABASE [estebandb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [estebandb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [estebandb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [estebandb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [estebandb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [estebandb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [estebandb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [estebandb] SET RECOVERY FULL 
GO
ALTER DATABASE [estebandb] SET  MULTI_USER 
GO
ALTER DATABASE [estebandb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [estebandb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [estebandb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [estebandb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [estebandb] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'estebandb', N'ON'
GO
ALTER DATABASE [estebandb] SET QUERY_STORE = OFF
GO
USE [estebandb]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 01/06/2020 02:38:00 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[Id] [uniqueidentifier] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[ApellidoPaterno] [varchar](50) NOT NULL,
	[ApellidoMaterno] [varchar](50) NOT NULL,
	[NombreCompleto]  AS (((([Nombre]+' ')+[ApellidoPaterno])+' ')+[ApellidoMaterno]),
	[FechaDeNacimiento] [datetime] NOT NULL,
	[Edad]  AS (datediff(year,[FechaDeNacimiento],getdate())),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetallesDeVenta]    Script Date: 01/06/2020 02:38:00 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetallesDeVenta](
	[Id] [uniqueidentifier] NOT NULL,
	[CantProductos] [int] NOT NULL,
	[DineroGanado] [int] NOT NULL,
	[Venta]  AS (([CantProductos]+' ')+[DineroGanado]),
	[FechaDeEntrega] [datetime] NOT NULL,
	[Fecha]  AS (datediff(year,[FechaDeEntrega],getdate())),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Domicilios]    Script Date: 01/06/2020 02:38:00 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Domicilios](
	[Id] [uniqueidentifier] NOT NULL,
	[Estado] [varchar](50) NOT NULL,
	[Municipio] [varchar](50) NOT NULL,
	[Calle] [varchar](50) NOT NULL,
	[DireccionEMC]  AS (((([Estado]+' ')+[Municipio])+' ')+[Calle]),
	[NumeroExt] [int] NOT NULL,
	[NumeroInt] [varchar](50) NOT NULL,
	[DireccionCEI]  AS (((([Calle]+' ')+[NumeroExt])+' ')+[NumeroInt]),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 01/06/2020 02:38:00 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[Id] [uniqueidentifier] NOT NULL,
	[NomProducto] [varchar](50) NOT NULL,
	[Marca] [varchar](50) NOT NULL,
	[Producto]  AS (([Marca]+' ')+[Nomproducto]),
	[FechaDeExpiracion] [datetime] NOT NULL,
	[FechaDeElaboracion]  AS (datediff(year,[FechaDeExpiracion],getdate())),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vendedores]    Script Date: 01/06/2020 02:38:00 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendedores](
	[Id] [uniqueidentifier] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[ApellidoPaterno] [varchar](50) NOT NULL,
	[ApellidoMaterno] [varchar](50) NOT NULL,
	[NombreCompleto]  AS (((([Nombre]+' ')+[ApellidoPaterno])+' ')+[ApellidoMaterno]),
	[FechaDeNacimiento] [datetime] NOT NULL,
	[Edad]  AS (datediff(year,[FechaDeNacimiento],getdate())),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Clientes] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'12345678-1234-5678-1234-123456789012', N'Esther', N'Avila', N'Llamas', CAST(N'1972-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Clientes] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'11345678-1234-5678-6234-123456789012', N'Yaziel', N'Avila', N'Gomez', CAST(N'1972-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Clientes] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'12345678-1234-5678-2234-123456789013', N'Samuel', N'Sanchez', N'Avila', CAST(N'1998-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Clientes] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'13345678-1234-5678-7234-123456789013', N'Leonardo', N'Rodriguez', N'Avila', CAST(N'1998-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Clientes] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'12345678-1234-5678-3234-123456789014', N'Esteban', N'Sanchez', N'Avila', CAST(N'2001-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Clientes] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'14345678-1234-5678-8234-123456789014', N'Orlando', N'Sanchez', N'Garcia', CAST(N'2001-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Clientes] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'12345678-1234-5678-4234-123456789015', N'Narciso', N'Sanchez', N'Mendoza', CAST(N'1970-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Clientes] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'16345678-1234-5678-9234-123456789015', N'Andres', N'Mendoza', N'Mendoza', CAST(N'1970-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Clientes] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'19345678-1234-5678-0234-123456789016', N'Andrea', N'Sanchez', N'Bravo', CAST(N'2008-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Clientes] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'12345678-1234-5678-5234-123456789016', N'Melina', N'Sanchez', N'Avila', CAST(N'2008-11-07T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[DetallesDeVenta] ([Id], [CantProductos], [DineroGanado], [FechaDeEntrega]) VALUES (N'11345678-1234-5678-1234-123456789012', 30, 300, CAST(N'2002-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[DetallesDeVenta] ([Id], [CantProductos], [DineroGanado], [FechaDeEntrega]) VALUES (N'12345678-1234-5678-1234-123456789012', 50, 300, CAST(N'2002-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[DetallesDeVenta] ([Id], [CantProductos], [DineroGanado], [FechaDeEntrega]) VALUES (N'12345678-1234-5678-1234-123456789013', 98, 150, CAST(N'2004-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[DetallesDeVenta] ([Id], [CantProductos], [DineroGanado], [FechaDeEntrega]) VALUES (N'13345678-1234-5678-1234-123456789013', 99, 150, CAST(N'2004-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[DetallesDeVenta] ([Id], [CantProductos], [DineroGanado], [FechaDeEntrega]) VALUES (N'12345678-1234-5678-1234-123456789014', 46, 200, CAST(N'2007-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[DetallesDeVenta] ([Id], [CantProductos], [DineroGanado], [FechaDeEntrega]) VALUES (N'15345678-1234-5678-1234-123456789014', 46, 200, CAST(N'2007-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[DetallesDeVenta] ([Id], [CantProductos], [DineroGanado], [FechaDeEntrega]) VALUES (N'12345678-1234-5678-1234-123456789015', 60, 400, CAST(N'2003-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[DetallesDeVenta] ([Id], [CantProductos], [DineroGanado], [FechaDeEntrega]) VALUES (N'19345678-1234-5678-1234-123456789015', 23, 400, CAST(N'2003-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[DetallesDeVenta] ([Id], [CantProductos], [DineroGanado], [FechaDeEntrega]) VALUES (N'12345678-1234-5678-1234-123456789016', 70, 500, CAST(N'2005-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[DetallesDeVenta] ([Id], [CantProductos], [DineroGanado], [FechaDeEntrega]) VALUES (N'17345678-1234-5678-1234-123456789016', 48, 500, CAST(N'2005-04-04T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Domicilios] ([Id], [Estado], [Municipio], [Calle], [NumeroExt], [NumeroInt]) VALUES (N'12345671-1234-5678-1234-123456789012', N'Nuevo Leon', N'Escobedo', N'0', 265, N'998')
INSERT [dbo].[Domicilios] ([Id], [Estado], [Municipio], [Calle], [NumeroExt], [NumeroInt]) VALUES (N'12345678-1234-5678-1234-123456789012', N'Nuevo Leon', N'Escobedo', N'8', 255, N'178')
INSERT [dbo].[Domicilios] ([Id], [Estado], [Municipio], [Calle], [NumeroExt], [NumeroInt]) VALUES (N'12345672-1234-5678-1234-123456789013', N'Oaxaca', N'Villa Hidalgo', N'1', 904, N'78')
INSERT [dbo].[Domicilios] ([Id], [Estado], [Municipio], [Calle], [NumeroExt], [NumeroInt]) VALUES (N'12345678-1234-5678-1234-123456789013', N'Oaxaca', N'Villa Hidalgo', N'7', 974, N'878')
INSERT [dbo].[Domicilios] ([Id], [Estado], [Municipio], [Calle], [NumeroExt], [NumeroInt]) VALUES (N'12345673-1234-5678-1234-123456789014', N'Guadalajara', N'Tonala', N'3', 22, N'728')
INSERT [dbo].[Domicilios] ([Id], [Estado], [Municipio], [Calle], [NumeroExt], [NumeroInt]) VALUES (N'12345678-1234-5678-1234-123456789014', N'Guadalajara', N'Tonala', N'6', 26, N'978')
INSERT [dbo].[Domicilios] ([Id], [Estado], [Municipio], [Calle], [NumeroExt], [NumeroInt]) VALUES (N'12345674-1234-5678-1234-123456789015', N'Tamaulipas', N'Jimenez', N'20', 301, N'748')
INSERT [dbo].[Domicilios] ([Id], [Estado], [Municipio], [Calle], [NumeroExt], [NumeroInt]) VALUES (N'12345678-1234-5678-1234-123456789015', N'Tamaulipas', N'Jimenez', N'5', 781, N'778')
INSERT [dbo].[Domicilios] ([Id], [Estado], [Municipio], [Calle], [NumeroExt], [NumeroInt]) VALUES (N'12345675-1234-5678-1234-123456789016', N'Jalisco', N'Salit', N'10', 975, N'498')
INSERT [dbo].[Domicilios] ([Id], [Estado], [Municipio], [Calle], [NumeroExt], [NumeroInt]) VALUES (N'12345678-1234-5678-1234-123456789016', N'Jalisco', N'Amaca', N'4', 965, N'358')
GO
INSERT [dbo].[Productos] ([Id], [NomProducto], [Marca], [FechaDeExpiracion]) VALUES (N'12345671-1234-5678-1234-123456789012', N'Donitas', N'Gamesita', CAST(N'2020-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Productos] ([Id], [NomProducto], [Marca], [FechaDeExpiracion]) VALUES (N'12345678-1234-5678-1234-123456789012', N'Donas', N'Gamesa', CAST(N'2020-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Productos] ([Id], [NomProducto], [Marca], [FechaDeExpiracion]) VALUES (N'12345672-1234-5678-1234-123456789013', N'Galletitas', N'Mariasita', CAST(N'2018-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Productos] ([Id], [NomProducto], [Marca], [FechaDeExpiracion]) VALUES (N'12345678-1234-5678-1234-123456789013', N'Galletas', N'Maria', CAST(N'2018-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Productos] ([Id], [NomProducto], [Marca], [FechaDeExpiracion]) VALUES (N'12345673-1234-5678-1234-123456789014', N'Cafesito', N'Nescafesito', CAST(N'2019-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Productos] ([Id], [NomProducto], [Marca], [FechaDeExpiracion]) VALUES (N'12345678-1234-5678-1234-123456789014', N'Cafe', N'Nescafe', CAST(N'2019-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Productos] ([Id], [NomProducto], [Marca], [FechaDeExpiracion]) VALUES (N'12345674-1234-5678-1234-123456789015', N'Paletita Payasito', N'Marinelito', CAST(N'2019-05-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Productos] ([Id], [NomProducto], [Marca], [FechaDeExpiracion]) VALUES (N'12345678-1234-5678-1234-123456789015', N'Paleta Payaso', N'Marinela', CAST(N'2019-05-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Productos] ([Id], [NomProducto], [Marca], [FechaDeExpiracion]) VALUES (N'12345675-1234-5678-1234-123456789016', N'Mayonesita', N'Nito', CAST(N'2009-07-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Productos] ([Id], [NomProducto], [Marca], [FechaDeExpiracion]) VALUES (N'12345678-1234-5678-1234-123456789016', N'Mayonesa', N'Macorni', CAST(N'2009-07-04T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Vendedores] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'11345678-1234-5678-1234-123456789012', N'Yaziel', N'Avila', N'Gomez', CAST(N'1972-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Vendedores] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'12345678-1234-5678-1234-123456789012', N'Esther', N'Avila', N'Llamas', CAST(N'1972-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Vendedores] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'12345678-1234-5678-1234-123456789013', N'Samuel', N'Sanchez', N'Avila', CAST(N'1998-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Vendedores] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'13345678-1234-5678-1234-123456789013', N'Leonardo', N'Rodriguez', N'Avila', CAST(N'1998-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Vendedores] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'12345678-1234-5678-1234-123456789014', N'Esteban', N'Sanchez', N'Avila', CAST(N'2001-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Vendedores] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'14345678-1234-5678-1234-123456789014', N'Orlando', N'Sanchez', N'Garcia', CAST(N'2001-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Vendedores] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'12345678-1234-5678-1234-123456789015', N'Narciso', N'Sanchez', N'Mendoza', CAST(N'1970-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Vendedores] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'16345678-1234-5678-1234-123456789015', N'Andres', N'Mendoza', N'Mendoza', CAST(N'1970-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Vendedores] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'12345678-1234-5678-1234-123456789016', N'Melina', N'Sanchez', N'Avila', CAST(N'2008-11-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Vendedores] ([Id], [Nombre], [ApellidoPaterno], [ApellidoMaterno], [FechaDeNacimiento]) VALUES (N'19345678-1234-5678-1234-123456789016', N'Dibanhi', N'Sanchez', N'Bravo', CAST(N'2008-11-07T00:00:00.000' AS DateTime))
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Validar_Nombre]    Script Date: 01/06/2020 02:38:00 a. m. ******/
ALTER TABLE [dbo].[Clientes] ADD  CONSTRAINT [Validar_Nombre] UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Clientes]  WITH CHECK ADD  CONSTRAINT [Chekear_Nombre] CHECK  (([Nombre]<>''))
GO
ALTER TABLE [dbo].[Clientes] CHECK CONSTRAINT [Chekear_Nombre]
GO
USE [master]
GO
ALTER DATABASE [estebandb] SET  READ_WRITE 
GO

select * from Clientes where Nombre='Esteban'
select * from DetallesDeVenta where Id='12345678-1234-5678-1234-123456789012'
select Municipio from Domicilios where Id='12345678-1234-5678-1234-123456789012'
select * from Productos where Marca='Gamesa'
select NombreCompleto from Vendedores where Edad='19'

select * from Clientes group by Id,Nombre,ApellidoPaterno,ApellidoMaterno,NombreCompleto,FechaDeNacimiento,Edad
select Nombre from Clientes Where Edad='19' group by Nombre
select NomProducto from Productos Where Marca='Gamesa' group by NomProducto
select NombreCompleto,Edad from Vendedores Where Edad='19' group by NombreCompleto,Edad
select Estado,Municipio from Domicilios group by Estado,Municipio

select COUNT(*) from Clientes Where Edad>18
select MAX(CantProductos) From DetallesDeVenta where DineroGanado>300
select MIN(DineroGanado) from DetallesDeVenta where CantProductos>50
select SUM(DineroGanado) From DetallesDeVenta where CantProductos<50
select Var(DineroGanado) From DetallesDeVenta 

select Id ,sum(DineroGanado) AS Dinero from DetallesDeVenta Group by Id Having SUM(DineroGanado)>499
select Id ,max(DineroGanado) AS Dinero from DetallesDeVenta Group by Id Having SUM(DineroGanado)<300
select Id ,min(DineroGanado) AS Dinero from DetallesDeVenta Group by Id Having SUM(DineroGanado)>150
select CantProductos from DetallesDeVenta Group by CantProductos Having SUM(DineroGanado)>0
select Id from DetallesDeVenta Group by Id Having SUM(DineroGanado)>499

select top 5 * from Clientes where ApellidoPaterno='Avila'
select top 3 * from Clientes where ApellidoMaterno='Avila'
select top 6 Marca from Productos where Marca!='Gamesa'
select top 2 Id from DetallesDeVenta where DineroGanado>450
select top 5 NombreCompleto from Vendedores  where Edad<18
