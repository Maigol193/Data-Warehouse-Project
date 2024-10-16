USE [master]
GO
/****** Object:  Database [El_Ajedrecista]    Script Date: 6/17/2024 11:55:57 PM ******/
CREATE DATABASE [El_Ajedrecista]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N' El_Ajedrecista', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DEVELOPER\MSSQL\DATA\ El_Ajedrecista.mdf' , SIZE = 270336KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N' El_Ajedrecista_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.DEVELOPER\MSSQL\DATA\ El_Ajedrecista_log.ldf' , SIZE = 598016KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [El_Ajedrecista] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [El_Ajedrecista].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [El_Ajedrecista] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET ARITHABORT OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [El_Ajedrecista] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [El_Ajedrecista] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET  DISABLE_BROKER 
GO
ALTER DATABASE [El_Ajedrecista] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [El_Ajedrecista] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET RECOVERY FULL 
GO
ALTER DATABASE [El_Ajedrecista] SET  MULTI_USER 
GO
ALTER DATABASE [El_Ajedrecista] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [El_Ajedrecista] SET DB_CHAINING OFF 
GO
ALTER DATABASE [El_Ajedrecista] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [El_Ajedrecista] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [El_Ajedrecista] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [El_Ajedrecista] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'El_Ajedrecista', N'ON'
GO
ALTER DATABASE [El_Ajedrecista] SET QUERY_STORE = ON
GO
ALTER DATABASE [El_Ajedrecista] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [El_Ajedrecista]
GO
/****** Object:  Table [dbo].[DimArticulo]    Script Date: 6/17/2024 11:55:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimArticulo](
	[ArticuloID] [char](20) NOT NULL,
	[Marca] [varchar](100) NULL,
	[Grupo] [varchar](100) NULL,
	[Tipo] [varchar](100) NULL,
	[Clase] [varchar](100) NULL,
 CONSTRAINT [PK_DimArticulo] PRIMARY KEY CLUSTERED 
(
	[ArticuloID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimCliente]    Script Date: 6/17/2024 11:55:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimCliente](
	[ClienteID] [char](20) NOT NULL,
	[ClienteTipo] [varchar](100) NULL,
 CONSTRAINT [PK_DimCliente] PRIMARY KEY CLUSTERED 
(
	[ClienteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimCondicionPago]    Script Date: 6/17/2024 11:55:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimCondicionPago](
	[CondicionID] [char](20) NOT NULL,
	[Descripcion] [varchar](100) NULL,
 CONSTRAINT [PK_DimCondicionPago] PRIMARY KEY CLUSTERED 
(
	[CondicionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimEmbarque]    Script Date: 6/17/2024 11:55:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimEmbarque](
	[EmbarqueID] [char](20) NOT NULL,
	[Descripción] [varchar](100) NULL,
 CONSTRAINT [PK_DimEmbarque] PRIMARY KEY CLUSTERED 
(
	[EmbarqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimMoneda]    Script Date: 6/17/2024 11:55:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimMoneda](
	[MonedaID] [char](20) NOT NULL,
	[Descripcion] [varchar](100) NULL,
	[Tipo] [varchar](100) NULL,
 CONSTRAINT [PK_DimMoneda] PRIMARY KEY CLUSTERED 
(
	[MonedaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimSubCot]    Script Date: 6/17/2024 11:55:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimSubCot](
	[CotizacionID] [char](10) NOT NULL,
 CONSTRAINT [PK_DimSubCot] PRIMARY KEY CLUSTERED 
(
	[CotizacionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimSubFact]    Script Date: 6/17/2024 11:55:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimSubFact](
	[FacturacionID] [char](10) NOT NULL,
 CONSTRAINT [PK_DimSubFact] PRIMARY KEY CLUSTERED 
(
	[FacturacionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimTime]    Script Date: 6/17/2024 11:55:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimTime](
	[TimeID] [int] NOT NULL,
	[Year] [int] NULL,
	[Semester] [int] NULL,
	[Quarter] [int] NULL,
	[Month] [int] NULL,
	[Day] [int] NULL,
	[WeekDay] [varchar](20) NULL,
 CONSTRAINT [PK_DimTime] PRIMARY KEY CLUSTERED 
(
	[TimeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DimVendedor]    Script Date: 6/17/2024 11:55:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DimVendedor](
	[VendedorID] [char](20) NOT NULL,
	[Descripcion] [varchar](100) NULL,
 CONSTRAINT [PK_DimVendedor] PRIMARY KEY CLUSTERED 
(
	[VendedorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactCotizacion]    Script Date: 6/17/2024 11:55:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactCotizacion](
	[c_Folio] [char](10) NULL,
	[c_Articulo] [char](20) NULL,
	[c_Cliente] [char](20) NULL,
	[c_Vendedor] [char](20) NULL,
	[c_Embarque] [char](20) NULL,
	[c_Condicion] [char](20) NULL,
	[c_Moneda] [char](20) NULL,
	[c_Time] [int] NULL,
	[c_Count] [float] NULL,
	[c_CantidadProducto] [float] NULL,
	[c_PctDescuento] [float] NULL,
	[c_Total] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FactFacturacion]    Script Date: 6/17/2024 11:55:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactFacturacion](
	[f_Folio] [char](10) NULL,
	[f_Articulo] [char](20) NULL,
	[f_Cliente] [char](20) NULL,
	[f_Vendedor] [char](20) NULL,
	[f_Embarque] [char](20) NULL,
	[f_Condicion] [char](20) NULL,
	[f_Moneda] [char](20) NULL,
	[f_Time] [int] NULL,
	[f_Count] [float] NULL,
	[f_CantidadProducto] [float] NULL,
	[f_PrecioProducto] [float] NULL,
	[f_SubTotal] [float] NULL,
	[f_Descuento] [float] NULL,
	[f_Impuesto] [float] NULL,
	[f_Total] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FactCotizacion]  WITH CHECK ADD  CONSTRAINT [FK_FactCotizacion_DimArticulo] FOREIGN KEY([c_Articulo])
REFERENCES [dbo].[DimArticulo] ([ArticuloID])
GO
ALTER TABLE [dbo].[FactCotizacion] CHECK CONSTRAINT [FK_FactCotizacion_DimArticulo]
GO
ALTER TABLE [dbo].[FactCotizacion]  WITH CHECK ADD  CONSTRAINT [FK_FactCotizacion_DimCliente] FOREIGN KEY([c_Cliente])
REFERENCES [dbo].[DimCliente] ([ClienteID])
GO
ALTER TABLE [dbo].[FactCotizacion] CHECK CONSTRAINT [FK_FactCotizacion_DimCliente]
GO
ALTER TABLE [dbo].[FactCotizacion]  WITH CHECK ADD  CONSTRAINT [FK_FactCotizacion_DimCondicionPago] FOREIGN KEY([c_Condicion])
REFERENCES [dbo].[DimCondicionPago] ([CondicionID])
GO
ALTER TABLE [dbo].[FactCotizacion] CHECK CONSTRAINT [FK_FactCotizacion_DimCondicionPago]
GO
ALTER TABLE [dbo].[FactCotizacion]  WITH CHECK ADD  CONSTRAINT [FK_FactCotizacion_DimEmbarque] FOREIGN KEY([c_Embarque])
REFERENCES [dbo].[DimEmbarque] ([EmbarqueID])
GO
ALTER TABLE [dbo].[FactCotizacion] CHECK CONSTRAINT [FK_FactCotizacion_DimEmbarque]
GO
ALTER TABLE [dbo].[FactCotizacion]  WITH CHECK ADD  CONSTRAINT [FK_FactCotizacion_DimMoneda] FOREIGN KEY([c_Moneda])
REFERENCES [dbo].[DimMoneda] ([MonedaID])
GO
ALTER TABLE [dbo].[FactCotizacion] CHECK CONSTRAINT [FK_FactCotizacion_DimMoneda]
GO
ALTER TABLE [dbo].[FactCotizacion]  WITH CHECK ADD  CONSTRAINT [FK_FactCotizacion_DimSubCot] FOREIGN KEY([c_Folio])
REFERENCES [dbo].[DimSubCot] ([CotizacionID])
GO
ALTER TABLE [dbo].[FactCotizacion] CHECK CONSTRAINT [FK_FactCotizacion_DimSubCot]
GO
ALTER TABLE [dbo].[FactCotizacion]  WITH CHECK ADD  CONSTRAINT [FK_FactCotizacion_DimTime] FOREIGN KEY([c_Time])
REFERENCES [dbo].[DimTime] ([TimeID])
GO
ALTER TABLE [dbo].[FactCotizacion] CHECK CONSTRAINT [FK_FactCotizacion_DimTime]
GO
ALTER TABLE [dbo].[FactCotizacion]  WITH CHECK ADD  CONSTRAINT [FK_FactCotizacion_DimVendedor] FOREIGN KEY([c_Vendedor])
REFERENCES [dbo].[DimVendedor] ([VendedorID])
GO
ALTER TABLE [dbo].[FactCotizacion] CHECK CONSTRAINT [FK_FactCotizacion_DimVendedor]
GO
ALTER TABLE [dbo].[FactFacturacion]  WITH CHECK ADD  CONSTRAINT [FK_FactFacturacion_DimArticulo] FOREIGN KEY([f_Articulo])
REFERENCES [dbo].[DimArticulo] ([ArticuloID])
GO
ALTER TABLE [dbo].[FactFacturacion] CHECK CONSTRAINT [FK_FactFacturacion_DimArticulo]
GO
ALTER TABLE [dbo].[FactFacturacion]  WITH CHECK ADD  CONSTRAINT [FK_FactFacturacion_DimCliente] FOREIGN KEY([f_Cliente])
REFERENCES [dbo].[DimCliente] ([ClienteID])
GO
ALTER TABLE [dbo].[FactFacturacion] CHECK CONSTRAINT [FK_FactFacturacion_DimCliente]
GO
ALTER TABLE [dbo].[FactFacturacion]  WITH CHECK ADD  CONSTRAINT [FK_FactFacturacion_DimCondicionPago] FOREIGN KEY([f_Condicion])
REFERENCES [dbo].[DimCondicionPago] ([CondicionID])
GO
ALTER TABLE [dbo].[FactFacturacion] CHECK CONSTRAINT [FK_FactFacturacion_DimCondicionPago]
GO
ALTER TABLE [dbo].[FactFacturacion]  WITH CHECK ADD  CONSTRAINT [FK_FactFacturacion_DimEmbarque] FOREIGN KEY([f_Embarque])
REFERENCES [dbo].[DimEmbarque] ([EmbarqueID])
GO
ALTER TABLE [dbo].[FactFacturacion] CHECK CONSTRAINT [FK_FactFacturacion_DimEmbarque]
GO
ALTER TABLE [dbo].[FactFacturacion]  WITH CHECK ADD  CONSTRAINT [FK_FactFacturacion_DimMoneda] FOREIGN KEY([f_Moneda])
REFERENCES [dbo].[DimMoneda] ([MonedaID])
GO
ALTER TABLE [dbo].[FactFacturacion] CHECK CONSTRAINT [FK_FactFacturacion_DimMoneda]
GO
ALTER TABLE [dbo].[FactFacturacion]  WITH CHECK ADD  CONSTRAINT [FK_FactFacturacion_DimSubFact] FOREIGN KEY([f_Folio])
REFERENCES [dbo].[DimSubFact] ([FacturacionID])
GO
ALTER TABLE [dbo].[FactFacturacion] CHECK CONSTRAINT [FK_FactFacturacion_DimSubFact]
GO
ALTER TABLE [dbo].[FactFacturacion]  WITH CHECK ADD  CONSTRAINT [FK_FactFacturacion_DimTime] FOREIGN KEY([f_Time])
REFERENCES [dbo].[DimTime] ([TimeID])
GO
ALTER TABLE [dbo].[FactFacturacion] CHECK CONSTRAINT [FK_FactFacturacion_DimTime]
GO
ALTER TABLE [dbo].[FactFacturacion]  WITH CHECK ADD  CONSTRAINT [FK_FactFacturacion_DimVendedor] FOREIGN KEY([f_Vendedor])
REFERENCES [dbo].[DimVendedor] ([VendedorID])
GO
ALTER TABLE [dbo].[FactFacturacion] CHECK CONSTRAINT [FK_FactFacturacion_DimVendedor]
GO
/****** Object:  StoredProcedure [dbo].[POBLADO_PROYECTO1]    Script Date: 6/17/2024 11:55:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- POBLADO DE DATOS

-- EXEC POBLADO_PROYECTO1
-- DROP PROCEDURE POBLADO_PROYECTO1

CREATE PROCEDURE [dbo].[POBLADO_PROYECTO1]
AS
BEGIN

	-- Limpiado de tablas
	DELETE El_Ajedrecista.dbo.FactCotizacion;
	DELETE El_Ajedrecista.dbo.FactFacturacion;
	DELETE El_Ajedrecista.dbo.DimSubCot;
	DELETE El_Ajedrecista.dbo.DimSubFact;
	DELETE El_Ajedrecista.dbo.DimArticulo;
	DELETE El_Ajedrecista.dbo.DimCliente;
	DELETE El_Ajedrecista.dbo.DimCondicionPago;
	DELETE El_Ajedrecista.dbo.DimEmbarque;
	DELETE El_Ajedrecista.dbo.DimMoneda;
	DELETE El_Ajedrecista.dbo.DimTime;
	DELETE El_Ajedrecista.dbo.DimVendedor;

	--Poblar DimSubCot
	INSERT INTO El_Ajedrecista.dbo.DimSubCot
	SELECT DISTINCT Folio
	FROM AutopartesP2024.dbo.CotVtaEncabezado;

	--Poblar DimSubFact
	INSERT INTO El_Ajedrecista.dbo.DimSubFact
	SELECT DISTINCT Folio
	FROM AutopartesP2024.dbo.FacturaEncabezado;

	--Poblar DimArticulo
	INSERT INTO El_Ajedrecista.dbo.DimArticulo
	SELECT 
		DISTINCT a.clave,
		a.Descripcion,
		ag.Descripcion,
		ap.Descripcion,
		ac.Descripcion
	FROM AutopartesP2024.dbo.Articulo as a
	LEFT JOIN AutopartesP2024.dbo.ArticuloClase as ac ON a.ArticuloClase = ac.Clave
	LEFT JOIN AutopartesP2024.dbo.ArticuloGrupo as ag ON a.ArticuloGrupo = ag.Clave
	LEFT JOIN AutopartesP2024.dbo.ArticuloTipo as ap ON a.ArticuloTipo = ap.Clave;

	--Poblar DimCliente
	INSERT INTO El_Ajedrecista.dbo.DimCliente
	SELECT 
		DISTINCT c.Clave,
		ct.Descripcion
	FROM AutopartesP2024.dbo.Cliente as c
	LEFT JOIN AutopartesP2024.dbo.ClienteTipo as ct ON c.ClienteTipo = ct.Clave;

	--Poblar DimCondicionPago
	INSERT INTO El_Ajedrecista.dbo.DimCondicionPago
	SELECT 
		DISTINCT Clave,
		Descripcion
	FROM AutopartesP2024.dbo.CondicionPago;

	--Poblar DimEmbarque
	INSERT INTO El_Ajedrecista.dbo.DimEmbarque
	SELECT 
		DISTINCT Clave,
		Descripcion
	FROM AutopartesP2024.dbo.MedioEmbarque;

	--Poblar DimMoneda
	INSERT INTO El_Ajedrecista.dbo.DimMoneda
	SELECT 
		DISTINCT Clave,
		Descripcion,
		Tipo
	FROM AutopartesP2024.dbo.Moneda;

	--Poblar DimVendedor
	INSERT INTO El_Ajedrecista.dbo.DimVendedor
	SELECT 
		DISTINCT Clave,
		Nombre
	FROM AutopartesP2024.dbo.Vendedor;

	--Poblar DimTime
	INSERT INTO El_Ajedrecista.dbo.DimTime
	SELECT 
		DISTINCT CAST(CONVERT(varchar(8), cv.Fecha, 112) AS INT), 
		YEAR(cv.Fecha),
		CAST((MONTH(cv.Fecha) - 1)/6 AS INT) + 1,
		CAST((MONTH(cv.Fecha) - 1)/3 AS INT) + 1,
		MONTH(cv.Fecha),
		DAY(cv.Fecha),
		CASE DATEPART(WEEKDAY, cv.Fecha)
			WHEN 1 THEN 'Domingo'
			WHEN 2 THEN 'Lunes'
			WHEN 3 THEN 'Martes'
			WHEN 4 THEN 'Miércoles'
			WHEN 5 THEN 'Jueves'
			WHEN 6 THEN 'Viernes'
			WHEN 7 THEN 'Sábado'
		END AS Weekday
		FROM AutopartesP2024.dbo.CotVtaEncabezado as cv
	UNION
	SELECT
		DISTINCT CAST(CONVERT(varchar(8), fe.Fecha, 112) AS INT),
		YEAR(fe.Fecha),
		CAST((MONTH(fe.Fecha) - 1)/6 AS INT) + 1,
		CAST((MONTH(fe.Fecha) - 1)/3 AS INT) + 1,
		MONTH(fe.Fecha),
		DAY(fe.Fecha)y,
		CASE DATEPART(WEEKDAY, fe.Fecha)
			WHEN 1 THEN 'Domingo'
			WHEN 2 THEN 'Lunes'
			WHEN 3 THEN 'Martes'
			WHEN 4 THEN 'Miércoles'
			WHEN 5 THEN 'Jueves'
			WHEN 6 THEN 'Viernes'
			WHEN 7 THEN 'Sábado'
		END AS Weekday
	FROM AutopartesP2024.dbo.FacturaEncabezado as fe;



	--Poblar FactCotizacion
	WITH CTE1 AS (
		SELECT cd.Folio, 1.0/COUNT(cd.Folio) AS Conteo
		FROM AutopartesP2024.dbo.CotVtaDetalle AS cd
		GROUP BY cd.Folio
	)

	INSERT INTO El_Ajedrecista.dbo.FactCotizacion
	SELECT 
		ce.Folio,
		cd.Articulo,
		ce.Cliente,
		ce.Vendedor,
		ce.MedioEmbarque,
		ce.CondicionPago,
		ce.Moneda,
		CAST(CONVERT(varchar(8), ce.Fecha, 112) AS INT),
		T.Conteo,
		cd.Cantidad,
		ce.pctDescuentoGlobal,
		a.Precio * cd.Cantidad
	FROM AutopartesP2024.dbo.CotVtaEncabezado as ce
	JOIN AutopartesP2024.dbo.CotVtaDetalle as cd ON ce.Folio = cd.Folio
	LEFT JOIN AutopartesP2024.dbo.Articulo as a ON a.clave = cd.Articulo
	LEFT JOIN CTE1 AS T on ce.Folio = T.Folio;
	
	


	--Poblar FactFacturacion
	WITH CTE2 AS (
		SELECT fd.Folio, 1.0/COUNT(fd.Folio) AS Conteo
		FROM AutopartesP2024.dbo.FacturaDetalle AS fd
		GROUP BY fd.Folio
	)

	INSERT INTO El_Ajedrecista.dbo.FactFacturacion
	SELECT 
		fe.Folio,
		fd.Articulo,
		fe.Cliente,
		fe.Vendedor,
		fe.MedioEmbarque,
		fe.CondicionPago,
		fe.Moneda,
		CAST(CONVERT(varchar(8), fe.Fecha, 112) AS INT),
		T.Conteo,
		fd.Cantidad,
		fd.Precio,
		fd.TotalImporte,
		fd.TotalDescuento,
		fd.TotalImpuesto,
		fd.Total
	FROM AutopartesP2024.dbo.FacturaEncabezado as fe
	JOIN AutopartesP2024.dbo.FacturaDetalle as fd ON fe.Folio = fd.Folio
	LEFT JOIN CTE2 AS T on fe.Folio = T.Folio;
END
GO
USE [master]
GO
ALTER DATABASE [El_Ajedrecista] SET  READ_WRITE 
GO
