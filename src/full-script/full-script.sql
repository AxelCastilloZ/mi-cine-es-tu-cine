USE [master]
GO
/****** Object:  Database [mi_cine_es_tu_cine]    Script Date: 12/6/2025 19:27:14 ******/
CREATE DATABASE [mi_cine_es_tu_cine]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'mi_cine_es_tu_cine', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\mi_cine_es_tu_cine.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'mi_cine_es_tu_cine_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\mi_cine_es_tu_cine_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [mi_cine_es_tu_cine].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET ARITHABORT OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET  ENABLE_BROKER 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET  MULTI_USER 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET DB_CHAINING OFF 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET QUERY_STORE = ON
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [mi_cine_es_tu_cine]
GO
/****** Object:  User [usuario_normal]    Script Date: 12/6/2025 19:27:14 ******/
CREATE USER [usuario_normal] FOR LOGIN [usuario_normal] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [martillo]    Script Date: 12/6/2025 19:27:14 ******/
CREATE USER [martillo] FOR LOGIN [martillo] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [francisco_coulon]    Script Date: 12/6/2025 19:27:14 ******/
CREATE USER [francisco_coulon] FOR LOGIN [francisco_coulon] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [martillo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [martillo]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [martillo]
GO
ALTER ROLE [db_owner] ADD MEMBER [francisco_coulon]
GO
ALTER ROLE [db_datareader] ADD MEMBER [francisco_coulon]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [francisco_coulon]
GO
/****** Object:  Table [dbo].[pelicula]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pelicula](
	[pelicula_id] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [varchar](50) NOT NULL,
	[sinopsis] [varchar](250) NOT NULL,
	[duracion] [int] NOT NULL,
	[pais_origen] [varchar](50) NOT NULL,
	[imagen_url] [varchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pelicula_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cartelera]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cartelera](
	[cartelera_id] [int] IDENTITY(1,1) NOT NULL,
	[fecha_inicio] [date] NOT NULL,
	[fecha_fin] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cartelera_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sala]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sala](
	[sala_id] [int] IDENTITY(1,1) NOT NULL,
	[ubicacion] [varchar](100) NOT NULL,
	[nombre_sala] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[sala_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[funcion]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[funcion](
	[funcion_id] [int] IDENTITY(1,1) NOT NULL,
	[cartelera_id] [int] NOT NULL,
	[sala_id] [int] NOT NULL,
	[hora] [varchar](50) NOT NULL,
	[fecha] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[funcion_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pelicula_funcion]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pelicula_funcion](
	[pelicula_id] [int] NOT NULL,
	[funcion_id] [int] NOT NULL,
 CONSTRAINT [pk_pelicula_funcion] PRIMARY KEY CLUSTERED 
(
	[pelicula_id] ASC,
	[funcion_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_peliculas_cartelera]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_peliculas_cartelera] AS
SELECT
    p.pelicula_id,
    p.titulo,
    p.sinopsis,
    p.duracion,
    p.pais_origen,
    p.imagen_url,
    f.fecha,
    f.hora,
    s.nombre_sala,
    s.ubicacion
FROM pelicula p
INNER JOIN pelicula_funcion pf ON p.pelicula_id = pf.pelicula_id
INNER JOIN funcion f ON pf.funcion_id = f.funcion_id
INNER JOIN sala s ON f.sala_id = s.sala_id
INNER JOIN cartelera c ON f.cartelera_id = c.cartelera_id
WHERE GETDATE() BETWEEN c.fecha_inicio AND c.fecha_fin;
GO
/****** Object:  Table [dbo].[actor]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[actor](
	[actor_id] [int] IDENTITY(1,1) NOT NULL,
	[nombre_actor] [varchar](100) NOT NULL,
	[nacionalidad] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[actor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pelicula_actor]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pelicula_actor](
	[pelicula_id] [int] NOT NULL,
	[actor_id] [int] NOT NULL,
 CONSTRAINT [pk_pelicula_actor] PRIMARY KEY CLUSTERED 
(
	[pelicula_id] ASC,
	[actor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_pelicula_actor]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_pelicula_actor] AS
SELECT 
	p.pelicula_id,
    p.titulo,
    p.sinopsis,
    p.duracion,
    p.pais_origen,
    p.imagen_url,
	a.nombre_actor,
	a.nacionalidad

	FROM pelicula p

	INNER JOIN pelicula_actor pa ON p.pelicula_id = pa.pelicula_id
	INNER JOIN actor a ON pa.actor_id = a.actor_id
GO
/****** Object:  Table [dbo].[asiento]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[asiento](
	[asiento_id] [int] IDENTITY(1,1) NOT NULL,
	[sala_id] [int] NOT NULL,
	[fila] [varchar](25) NOT NULL,
	[secuencia] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[asiento_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_sala_asientos]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vw_sala_asientos] AS
SELECT 
	s.sala_id,
	s.ubicacion,
	s.nombre_sala,
	a.asiento_id,
	a.fila,
	a.secuencia
	FROM sala s
	LEFT JOIN asiento a ON s.sala_id = a.sala_id
GO
/****** Object:  Table [dbo].[asiento_funcion]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[asiento_funcion](
	[asiento_funcion_id] [int] IDENTITY(1,1) NOT NULL,
	[funcion_id] [int] NOT NULL,
	[asiento_id] [int] NOT NULL,
	[estado] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[asiento_funcion_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_asiento_disponibles]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_asiento_disponibles] AS
SELECT
    af.asiento_funcion_id,
    a.fila,
    a.secuencia,
    s.nombre_sala,
    f.fecha,
    f.hora
FROM asiento_funcion af
INNER JOIN asiento a ON af.asiento_id = a.asiento_id
INNER JOIN funcion f ON af.funcion_id = f.funcion_id
INNER JOIN sala s ON f.sala_id = s.sala_id
WHERE af.estado = 'Libre';
GO
/****** Object:  Table [dbo].[tiquete]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tiquete](
	[tiquete_id] [int] IDENTITY(1,1) NOT NULL,
	[funcion_id] [int] NOT NULL,
	[asiento_funcion_id] [int] NOT NULL,
	[compra_id] [int] NOT NULL,
	[precio] [int] NOT NULL,
	[tipo_pago_o_puntos] [varchar](75) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[tiquete_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_peliculas_mas_vendidas]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_peliculas_mas_vendidas] AS
SELECT 
	p.titulo,
	COUNT(t.tiquete_id) AS cantidad_ventas

FROM pelicula p
INNER JOIN pelicula_funcion pf ON p.pelicula_id = pf.pelicula_id
INNER JOIN tiquete t ON pf.funcion_id = t.funcion_id
GROUP BY p.titulo
GO
/****** Object:  Table [dbo].[puntos]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[puntos](
	[puntos_id] [int] IDENTITY(1,1) NOT NULL,
	[cliente_id] [int] NOT NULL,
	[acumulado] [int] NOT NULL,
	[canjeado] [int] NULL,
	[saldo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[puntos_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cliente]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cliente](
	[cliente_id] [int] IDENTITY(1,1) NOT NULL,
	[fecha_nacimiento] [date] NULL,
	[pais_origen] [varchar](50) NULL,
	[nombre_cliente] [varchar](50) NOT NULL,
	[apellido] [varchar](50) NULL,
	[segundo_apellido] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_cliente_puntos]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_cliente_puntos] AS
SELECT 
	c.cliente_id,
	CONCAT(c.nombre_cliente, ' ', ISNULL(c.apellido,''), ' ', ISNULL(c.segundo_apellido, '')) AS nombre_completo,
	p.acumulado,
	p.canjeado,
	p.saldo
FROM cliente c
INNER JOIN puntos p ON c.cliente_id = p.cliente_id;
GO
/****** Object:  Table [dbo].[pelicula_idioma]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pelicula_idioma](
	[pelicula_id] [int] NOT NULL,
	[idioma] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pelicula_subtitulo]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pelicula_subtitulo](
	[pelicula_id] [int] NOT NULL,
	[subtitulo] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_pelicula_sub_idioma]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_pelicula_sub_idioma] AS
SELECT 
	p.pelicula_id,
	p.titulo,
	pl.idioma,
	ps.subtitulo

FROM pelicula p
LEFT JOIN pelicula_idioma pl ON p.pelicula_id = pl.pelicula_id
LEFT JOIN pelicula_subtitulo ps ON p.pelicula_id = ps.pelicula_id
GO
/****** Object:  Table [dbo].[metodo_de_pago]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[metodo_de_pago](
	[metodo_pago_id] [int] IDENTITY(1,1) NOT NULL,
	[cliente_id] [int] NOT NULL,
	[tipo] [varchar](50) NOT NULL,
	[detalles] [varchar](75) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[metodo_pago_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[compra]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[compra](
	[compra_id] [int] IDENTITY(1,1) NOT NULL,
	[cliente_id] [int] NULL,
	[dependiente_id] [int] NOT NULL,
	[metodo_pago_id] [int] NOT NULL,
	[canal] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[compra_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_metodo_pago_compra]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_metodo_pago_compra] AS
SELECT 
	c.compra_id,
	CONCAT_WS(' ', cl.nombre_cliente, cl.apellido, cl.segundo_apellido) AS nombre_cliente,
	mp.tipo AS tipo_pago,
	mp.detalles AS detalles_pago,
	c.canal
FROM compra c
LEFT JOIN cliente cl ON c.cliente_id = cl.cliente_id
INNER JOIN metodo_de_pago mp ON c.metodo_pago_id = mp.metodo_pago_id
GO
/****** Object:  Table [dbo].[dependiente]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dependiente](
	[dependiente_id] [int] IDENTITY(1,1) NOT NULL,
	[nombre_dependiente] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[dependiente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_compra_tiquete_dependiente]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_compra_tiquete_dependiente] AS
SELECT 
	c.compra_id,
	CONCAT_WS(' ', cl.nombre_cliente, cl.apellido, cl.segundo_apellido) AS nombre_cliente,
	d.nombre_dependiente,
	c.canal,
	mp.tipo AS tipo_pago,
	mp.detalles AS detalles_pago,
	t.precio,
	t.tipo_pago_o_puntos

FROM compra c

LEFT JOIN cliente cl ON c.cliente_id = cl.cliente_id
INNER JOIN metodo_de_pago mp ON c.metodo_pago_id = mp.metodo_pago_id
INNER JOIN dependiente d ON c.dependiente_id = d.dependiente_id
INNER JOIN tiquete t ON c.compra_id = t.compra_id
GO
/****** Object:  Table [dbo].[auditoria]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auditoria](
	[auditoria_id] [int] IDENTITY(1,1) NOT NULL,
	[usuario] [varchar](50) NOT NULL,
	[accion] [varchar](20) NOT NULL,
	[tabla] [varchar](50) NOT NULL,
	[fecha_hora] [datetime] NOT NULL,
	[descripcion] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[auditoria_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_auditoria]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_auditoria] AS
SELECT 
	a.auditoria_id,
	a.usuario,
	a.accion,
	a.tabla AS tabla_afectada,
	a.fecha_hora,
	a.descripcion

FROM auditoria a

GO
/****** Object:  View [dbo].[vw_auditoria_reciente]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_auditoria_reciente] AS
SELECT 
    a.auditoria_id,
    a.usuario,
    a.accion,
    a.tabla AS tabla_afectada,
    a.fecha_hora,
    a.descripcion
FROM auditoria a
WHERE fecha_hora >= DATEADD(MONTH, -1, GETDATE());
GO
/****** Object:  Table [dbo].[categoria]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categoria](
	[categoria_id] [int] IDENTITY(1,1) NOT NULL,
	[nombre_categoria] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[categoria_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pelicula_categoria]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pelicula_categoria](
	[categoria_id] [int] NOT NULL,
	[pelicula_id] [int] NOT NULL,
 CONSTRAINT [pk_pelicula_categoria] PRIMARY KEY CLUSTERED 
(
	[pelicula_id] ASC,
	[categoria_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_compra_todo]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_compra_todo] AS
SELECT
	c.compra_id,
	CONCAT_WS(' ', cl.nombre_cliente, cl.apellido, cl.segundo_apellido) AS nombre_cliente,
	d.nombre_dependiente,
	c.canal,
	mp.tipo AS tipo_pago,
	mp.detalles AS detalles_pago,
	t.precio,
	t.tipo_pago_o_puntos,
	df.hora,
	df.fecha,
	s.nombre_sala,
	s.ubicacion,
	ass.fila,
	ass.secuencia,
	p.titulo,
	p.sinopsis,
	p.duracion,
	p.pais_origen,
	p.imagen_url,
	pl.idioma,
	ps.subtitulo,
	a.nombre_actor,
	a.nacionalidad,
	pcs.nombre_categoria

FROM compra c

LEFT JOIN cliente cl ON c.cliente_id = cl.cliente_id
INNER JOIN metodo_de_pago mp ON c.metodo_pago_id = mp.metodo_pago_id
INNER JOIN dependiente d ON c.dependiente_id = d.dependiente_id
INNER JOIN tiquete t ON c.compra_id = t.compra_id
INNER JOIN funcion df ON t.funcion_id = df.funcion_id
INNER JOIN sala s ON df.sala_id = s.sala_id
INNER JOIN asiento ass ON s.sala_id = ass.sala_id
INNER JOIN pelicula_funcion pf ON df.funcion_id = pf.funcion_id
INNER JOIN pelicula p ON pf.pelicula_id = p.pelicula_id
INNER JOIN pelicula_idioma pl ON p.pelicula_id = pl.pelicula_id
INNER JOIN pelicula_subtitulo ps ON p.pelicula_id = ps.pelicula_id
INNER JOIN pelicula_actor pa ON p.pelicula_id = pa.pelicula_id
INNER JOIN actor a ON pa.actor_id = a.actor_id
INNER JOIN pelicula_categoria pc ON p.pelicula_id = pc.pelicula_id
INNER JOIN categoria pcs ON pc.pelicula_id = pcs.categoria_id

GO
/****** Object:  View [dbo].[vw_pelicula_cartelera_isa]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_pelicula_cartelera_isa] AS
SELECT
    p.pelicula_id,
    p.titulo,
    p.sinopsis,
    p.duracion,
    p.pais_origen,
    p.imagen_url,
	pl.idioma,
	ps.subtitulo,
	a.nombre_actor,
	a.nacionalidad,
	cs.nombre_categoria,
    f.fecha,
    f.hora,
    s.nombre_sala,
    s.ubicacion
FROM pelicula p
INNER JOIN pelicula_funcion pf ON p.pelicula_id = pf.pelicula_id
INNER JOIN funcion f ON pf.funcion_id = f.funcion_id
INNER JOIN pelicula_idioma pl ON p.pelicula_id = pl.pelicula_id
INNER JOIN pelicula_subtitulo ps ON p.pelicula_id = ps.pelicula_id
INNER JOIN pelicula_actor pa ON p.pelicula_id = pa.pelicula_id
INNER JOIN actor a ON pa.actor_id = a.actor_id
INNER JOIN pelicula_categoria pc ON p.pelicula_id = pc.pelicula_id
INNER JOIN categoria cs ON pc.categoria_id = cs.categoria_id
INNER JOIN sala s ON f.sala_id = s.sala_id
INNER JOIN cartelera c ON f.cartelera_id = c.cartelera_id
WHERE GETDATE() BETWEEN c.fecha_inicio AND c.fecha_fin;
GO
/****** Object:  View [dbo].[vw_pelicula_sala_asiento_funcion]    Script Date: 12/6/2025 19:27:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_pelicula_sala_asiento_funcion] AS

SELECT
    p.pelicula_id,
    p.titulo,
    p.sinopsis,
    p.duracion,
    p.pais_origen,
    p.imagen_url,
    f.fecha,
    f.hora,
    s.nombre_sala,
    s.ubicacion,
	a.fila,
	a.secuencia,
	af.estado

FROM pelicula p
INNER JOIN pelicula_funcion pf ON p.pelicula_id = pf.pelicula_id
INNER JOIN funcion f ON pf.funcion_id = f.funcion_id
INNER JOIN sala s ON f.sala_id = s.sala_id
INNER JOIN asiento a ON s.sala_id = a.sala_id 
INNER JOIN asiento_funcion af ON f.funcion_id = af.funcion_id
GO
SET IDENTITY_INSERT [dbo].[auditoria] ON 

INSERT [dbo].[auditoria] ([auditoria_id], [usuario], [accion], [tabla], [fecha_hora], [descripcion]) VALUES (1, N'Jhonpy\jhonn', N'INSERT', N'pelicula', CAST(N'2025-06-12T15:46:48.727' AS DateTime), N'Inserción en película')
INSERT [dbo].[auditoria] ([auditoria_id], [usuario], [accion], [tabla], [fecha_hora], [descripcion]) VALUES (2, N'Jhonpy\jhonn', N'INSERT', N'pelicula', CAST(N'2025-06-12T15:49:15.193' AS DateTime), N'Inserción en película')
INSERT [dbo].[auditoria] ([auditoria_id], [usuario], [accion], [tabla], [fecha_hora], [descripcion]) VALUES (3, N'Jhonpy\jhonn', N'INSERT', N'pelicula', CAST(N'2025-06-12T15:54:02.350' AS DateTime), N'Inserción en película')
SET IDENTITY_INSERT [dbo].[auditoria] OFF
GO
SET IDENTITY_INSERT [dbo].[cliente] ON 

INSERT [dbo].[cliente] ([cliente_id], [fecha_nacimiento], [pais_origen], [nombre_cliente], [apellido], [segundo_apellido]) VALUES (1, CAST(N'1995-04-12' AS Date), N'Costa Rica', N'Carlos', N'Ramírez', N'Morales')
INSERT [dbo].[cliente] ([cliente_id], [fecha_nacimiento], [pais_origen], [nombre_cliente], [apellido], [segundo_apellido]) VALUES (2, NULL, NULL, N'boletería', NULL, NULL)
SET IDENTITY_INSERT [dbo].[cliente] OFF
GO
SET IDENTITY_INSERT [dbo].[compra] ON 

INSERT [dbo].[compra] ([compra_id], [cliente_id], [dependiente_id], [metodo_pago_id], [canal]) VALUES (1, 2, 1, 2, N'boleteria')
SET IDENTITY_INSERT [dbo].[compra] OFF
GO
SET IDENTITY_INSERT [dbo].[dependiente] ON 

INSERT [dbo].[dependiente] ([dependiente_id], [nombre_dependiente]) VALUES (1, N'Juan Pérez')
INSERT [dbo].[dependiente] ([dependiente_id], [nombre_dependiente]) VALUES (2, N'web')
SET IDENTITY_INSERT [dbo].[dependiente] OFF
GO
SET IDENTITY_INSERT [dbo].[metodo_de_pago] ON 

INSERT [dbo].[metodo_de_pago] ([metodo_pago_id], [cliente_id], [tipo], [detalles]) VALUES (2, 1, N'Tarjeta', N'Visa 1234')
SET IDENTITY_INSERT [dbo].[metodo_de_pago] OFF
GO
SET IDENTITY_INSERT [dbo].[pelicula] ON 

INSERT [dbo].[pelicula] ([pelicula_id], [titulo], [sinopsis], [duracion], [pais_origen], [imagen_url]) VALUES (1, N'Freddy Vrs Jason', N'Dos icónicos asesinos de películas de terror se enfrentan en una batalla sangrienta por sus víctimas.', 97, N'Estados Unidos', N'https://i.ibb.co/Df3YJSWn/FREDDY-Y-JASON.jpg')
INSERT [dbo].[pelicula] ([pelicula_id], [titulo], [sinopsis], [duracion], [pais_origen], [imagen_url]) VALUES (2, N'Iron Man', N'Tony Stark, un multimillonario genio inventor, construye un traje blindado de alta tecnología para convertirse en el superhéroe Iron Man.', 126, N'Estados Unidos', N'https://i.ibb.co/B53HXx3f/IRON-MAN.jpg')
INSERT [dbo].[pelicula] ([pelicula_id], [titulo], [sinopsis], [duracion], [pais_origen], [imagen_url]) VALUES (3, N'Piratas del Caribe: Navegando Aguas Misteriosas', N'El Capitán Jack Sparrow se embarca en la búsqueda de la Fuente de la Juventud mientras se enfrenta a viejos enemigos y nuevos peligros, incluida la legendaria pirata Angélica y el temible Barbanegra.', 137, N'Estados Unidos', N'https://i.ibb.co/prh164wP/Piratas-de-Caribe4.webp')
SET IDENTITY_INSERT [dbo].[pelicula] OFF
GO
SET IDENTITY_INSERT [dbo].[sala] ON 

INSERT [dbo].[sala] ([sala_id], [ubicacion], [nombre_sala]) VALUES (1, N'Multiplaza Escazú', N'Sala 1')
SET IDENTITY_INSERT [dbo].[sala] OFF
GO
ALTER TABLE [dbo].[auditoria] ADD  DEFAULT (getdate()) FOR [fecha_hora]
GO
ALTER TABLE [dbo].[asiento]  WITH CHECK ADD  CONSTRAINT [fk_sala_a] FOREIGN KEY([sala_id])
REFERENCES [dbo].[sala] ([sala_id])
GO
ALTER TABLE [dbo].[asiento] CHECK CONSTRAINT [fk_sala_a]
GO
ALTER TABLE [dbo].[asiento_funcion]  WITH CHECK ADD  CONSTRAINT [fk_asiento_af] FOREIGN KEY([asiento_id])
REFERENCES [dbo].[asiento] ([asiento_id])
GO
ALTER TABLE [dbo].[asiento_funcion] CHECK CONSTRAINT [fk_asiento_af]
GO
ALTER TABLE [dbo].[asiento_funcion]  WITH CHECK ADD  CONSTRAINT [fk_funcion_af] FOREIGN KEY([funcion_id])
REFERENCES [dbo].[funcion] ([funcion_id])
GO
ALTER TABLE [dbo].[asiento_funcion] CHECK CONSTRAINT [fk_funcion_af]
GO
ALTER TABLE [dbo].[compra]  WITH CHECK ADD  CONSTRAINT [fk_cliente_c] FOREIGN KEY([cliente_id])
REFERENCES [dbo].[cliente] ([cliente_id])
GO
ALTER TABLE [dbo].[compra] CHECK CONSTRAINT [fk_cliente_c]
GO
ALTER TABLE [dbo].[compra]  WITH CHECK ADD  CONSTRAINT [fk_dependiente_c] FOREIGN KEY([dependiente_id])
REFERENCES [dbo].[dependiente] ([dependiente_id])
GO
ALTER TABLE [dbo].[compra] CHECK CONSTRAINT [fk_dependiente_c]
GO
ALTER TABLE [dbo].[compra]  WITH CHECK ADD  CONSTRAINT [fk_metodo_pago] FOREIGN KEY([metodo_pago_id])
REFERENCES [dbo].[metodo_de_pago] ([metodo_pago_id])
GO
ALTER TABLE [dbo].[compra] CHECK CONSTRAINT [fk_metodo_pago]
GO
ALTER TABLE [dbo].[funcion]  WITH CHECK ADD  CONSTRAINT [fk_cartelera_f] FOREIGN KEY([cartelera_id])
REFERENCES [dbo].[cartelera] ([cartelera_id])
GO
ALTER TABLE [dbo].[funcion] CHECK CONSTRAINT [fk_cartelera_f]
GO
ALTER TABLE [dbo].[funcion]  WITH CHECK ADD  CONSTRAINT [fk_sala_f] FOREIGN KEY([sala_id])
REFERENCES [dbo].[sala] ([sala_id])
GO
ALTER TABLE [dbo].[funcion] CHECK CONSTRAINT [fk_sala_f]
GO
ALTER TABLE [dbo].[metodo_de_pago]  WITH CHECK ADD  CONSTRAINT [fk_cliente_mp] FOREIGN KEY([cliente_id])
REFERENCES [dbo].[cliente] ([cliente_id])
GO
ALTER TABLE [dbo].[metodo_de_pago] CHECK CONSTRAINT [fk_cliente_mp]
GO
ALTER TABLE [dbo].[pelicula_actor]  WITH CHECK ADD  CONSTRAINT [fk_actor_a] FOREIGN KEY([actor_id])
REFERENCES [dbo].[actor] ([actor_id])
GO
ALTER TABLE [dbo].[pelicula_actor] CHECK CONSTRAINT [fk_actor_a]
GO
ALTER TABLE [dbo].[pelicula_actor]  WITH CHECK ADD  CONSTRAINT [fk_pelicula_p] FOREIGN KEY([pelicula_id])
REFERENCES [dbo].[pelicula] ([pelicula_id])
GO
ALTER TABLE [dbo].[pelicula_actor] CHECK CONSTRAINT [fk_pelicula_p]
GO
ALTER TABLE [dbo].[pelicula_categoria]  WITH CHECK ADD  CONSTRAINT [fk_categoria_a] FOREIGN KEY([categoria_id])
REFERENCES [dbo].[categoria] ([categoria_id])
GO
ALTER TABLE [dbo].[pelicula_categoria] CHECK CONSTRAINT [fk_categoria_a]
GO
ALTER TABLE [dbo].[pelicula_categoria]  WITH CHECK ADD  CONSTRAINT [fk_pelicula_pe] FOREIGN KEY([pelicula_id])
REFERENCES [dbo].[pelicula] ([pelicula_id])
GO
ALTER TABLE [dbo].[pelicula_categoria] CHECK CONSTRAINT [fk_pelicula_pe]
GO
ALTER TABLE [dbo].[pelicula_funcion]  WITH CHECK ADD  CONSTRAINT [fk_funcion_f] FOREIGN KEY([funcion_id])
REFERENCES [dbo].[funcion] ([funcion_id])
GO
ALTER TABLE [dbo].[pelicula_funcion] CHECK CONSTRAINT [fk_funcion_f]
GO
ALTER TABLE [dbo].[pelicula_funcion]  WITH CHECK ADD  CONSTRAINT [fk_pelicula_f] FOREIGN KEY([pelicula_id])
REFERENCES [dbo].[pelicula] ([pelicula_id])
GO
ALTER TABLE [dbo].[pelicula_funcion] CHECK CONSTRAINT [fk_pelicula_f]
GO
ALTER TABLE [dbo].[pelicula_idioma]  WITH CHECK ADD  CONSTRAINT [fk_pelicula_pi] FOREIGN KEY([pelicula_id])
REFERENCES [dbo].[pelicula] ([pelicula_id])
GO
ALTER TABLE [dbo].[pelicula_idioma] CHECK CONSTRAINT [fk_pelicula_pi]
GO
ALTER TABLE [dbo].[pelicula_subtitulo]  WITH CHECK ADD  CONSTRAINT [fk_pelicula_ps] FOREIGN KEY([pelicula_id])
REFERENCES [dbo].[pelicula] ([pelicula_id])
GO
ALTER TABLE [dbo].[pelicula_subtitulo] CHECK CONSTRAINT [fk_pelicula_ps]
GO
ALTER TABLE [dbo].[puntos]  WITH CHECK ADD  CONSTRAINT [fk_cliente_p] FOREIGN KEY([cliente_id])
REFERENCES [dbo].[cliente] ([cliente_id])
GO
ALTER TABLE [dbo].[puntos] CHECK CONSTRAINT [fk_cliente_p]
GO
ALTER TABLE [dbo].[tiquete]  WITH CHECK ADD  CONSTRAINT [fk_asiento_funcion_t] FOREIGN KEY([asiento_funcion_id])
REFERENCES [dbo].[asiento_funcion] ([asiento_funcion_id])
GO
ALTER TABLE [dbo].[tiquete] CHECK CONSTRAINT [fk_asiento_funcion_t]
GO
ALTER TABLE [dbo].[tiquete]  WITH CHECK ADD  CONSTRAINT [fk_compra_t] FOREIGN KEY([compra_id])
REFERENCES [dbo].[compra] ([compra_id])
GO
ALTER TABLE [dbo].[tiquete] CHECK CONSTRAINT [fk_compra_t]
GO
ALTER TABLE [dbo].[tiquete]  WITH CHECK ADD  CONSTRAINT [fk_funcion_t] FOREIGN KEY([funcion_id])
REFERENCES [dbo].[funcion] ([funcion_id])
GO
ALTER TABLE [dbo].[tiquete] CHECK CONSTRAINT [fk_funcion_t]
GO
ALTER TABLE [dbo].[asiento_funcion]  WITH CHECK ADD  CONSTRAINT [chk_estado_asiento] CHECK  (([estado]='Reservado' OR [estado]='Libre'))
GO
ALTER TABLE [dbo].[asiento_funcion] CHECK CONSTRAINT [chk_estado_asiento]
GO
ALTER TABLE [dbo].[compra]  WITH CHECK ADD  CONSTRAINT [chk_canal_compra] CHECK  (([canal]='web' OR [canal]='boleteria'))
GO
ALTER TABLE [dbo].[compra] CHECK CONSTRAINT [chk_canal_compra]
GO
/****** Object:  StoredProcedure [dbo].[sp_asientos_disponibles]    Script Date: 12/6/2025 19:27:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_asientos_disponibles] @funcion_id INT
AS
BEGIN
    BEGIN TRY
        SELECT a.asiento_id, a.fila, a.secuencia
        FROM asiento a
        JOIN sala s ON a.sala_id = s.sala_id
        JOIN funcion f ON f.sala_id = s.sala_id
        WHERE f.funcion_id = @funcion_id
        AND a.asiento_id NOT IN (
            SELECT asiento_id FROM asiento_funcion WHERE funcion_id = @funcion_id AND estado = 'Reservado'
        );
    END TRY
    BEGIN CATCH
        RAISERROR('Error al obtener los asientos disponibles.', 16, 1);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_bloquear_asiento_temporal]    Script Date: 12/6/2025 19:27:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_bloquear_asiento_temporal] @funcion_id INT, @asiento_id INT
AS
BEGIN
    INSERT INTO asiento_funcion (funcion_id, asiento_id, estado)
    VALUES (@funcion_id, @asiento_id, 'Bloqueado');
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_crear_editar_pelicula]    Script Date: 12/6/2025 19:27:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_crear_editar_pelicula]
    @pelicula_id INT = NULL,
    @titulo VARCHAR(50),
    @sinopsis VARCHAR(250),
    @duracion INT,
    @pais_origen VARCHAR(50),
    @imagen_url VARCHAR(250)
AS
BEGIN
    BEGIN TRY
        IF @pelicula_id IS NULL
        BEGIN
            INSERT INTO pelicula (titulo, sinopsis, duracion, pais_origen, imagen_url)
            VALUES (@titulo, @sinopsis, @duracion, @pais_origen, @imagen_url);
        END
        ELSE
        BEGIN
            UPDATE pelicula
            SET titulo = @titulo,
                sinopsis = @sinopsis,
                duracion = @duracion,
                pais_origen = @pais_origen,
                imagen_url = @imagen_url
            WHERE pelicula_id = @pelicula_id;
        END
    END TRY
    BEGIN CATCH
        RAISERROR('Error al crear o editar la película.', 16, 1);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_peliculas_en_cartelera]    Script Date: 12/6/2025 19:27:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_peliculas_en_cartelera]
AS
BEGIN
    BEGIN TRY
        SELECT DISTINCT p.titulo, c.fecha_inicio, c.fecha_fin
        FROM pelicula p
        JOIN pelicula_funcion pf ON p.pelicula_id = pf.pelicula_id
        JOIN funcion f ON pf.funcion_id = f.funcion_id
        JOIN cartelera c ON f.cartelera_id = c.cartelera_id
        WHERE GETDATE() BETWEEN c.fecha_inicio AND c.fecha_fin;
    END TRY
    BEGIN CATCH
        RAISERROR('Error al obtener las películas en cartelera.', 16, 1);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_peliculas_mas_vendidas]    Script Date: 12/6/2025 19:27:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_peliculas_mas_vendidas]
AS
BEGIN
    SELECT p.titulo, COUNT(t.tiquete_id) AS cantidad_ventas
    FROM tiquete t
    JOIN funcion f ON t.funcion_id = f.funcion_id
    JOIN pelicula_funcion pf ON f.funcion_id = pf.funcion_id
    JOIN pelicula p ON pf.pelicula_id = p.pelicula_id
    GROUP BY p.titulo
    ORDER BY cantidad_ventas DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_registrar_compra_asiento]    Script Date: 12/6/2025 19:27:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_registrar_compra_asiento]
    @cliente_id INT,
    @dependiente_id INT,
    @metodo_pago_id INT,
    @funcion_id INT,
    @asiento_id INT,
    @precio INT,
    @tipo_pago_o_puntos VARCHAR(75)
AS
BEGIN
    BEGIN TRY
        DECLARE @asiento_funcion_id INT;

        INSERT INTO asiento_funcion (funcion_id, asiento_id, estado)
        VALUES (@funcion_id, @asiento_id, 'Reservado');

        SET @asiento_funcion_id = SCOPE_IDENTITY();

        INSERT INTO compra (cliente_id, dependiente_id, metodo_pago_id, canal)
        VALUES (@cliente_id, @dependiente_id, @metodo_pago_id, 'web');

        DECLARE @compra_id INT = SCOPE_IDENTITY();

        INSERT INTO tiquete (funcion_id, asiento_funcion_id, compra_id, precio, tipo_pago_o_puntos)
        VALUES (@funcion_id, @asiento_funcion_id, @compra_id, @precio, @tipo_pago_o_puntos);
    END TRY
    BEGIN CATCH
        RAISERROR('Error al registrar la compra del asiento.', 16, 1);
    END CATCH
END;
GO
USE [master]
GO
ALTER DATABASE [mi_cine_es_tu_cine] SET  READ_WRITE 
GO
