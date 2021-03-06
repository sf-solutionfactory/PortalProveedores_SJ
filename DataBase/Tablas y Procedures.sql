create database [proveedores]
COLLATE Modern_Spanish_CI_AS
GO
USE [proveedores]
GO
/****** Object:  User [NimMonitor]    Script Date: 06/15/2016 14:45:13 ******/
CREATE USER [NimMonitor] FOR LOGIN [NimMonitor] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [PortalProveedores]    Script Date: 06/15/2016 14:45:13 ******/
CREATE USER [PortalProveedores] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Prov2]    Script Date: 06/15/2016 14:45:13 ******/
CREATE USER [Prov2] FOR LOGIN [Prov2] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[credencialesInaceptables]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[credencialesInaceptables](
	[idCredencialInaceptable] [int] IDENTITY(1,1) NOT NULL,
	[credencial] [char](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[idCredencialInaceptable] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [IX_credInacep] UNIQUE NONCLUSTERED 
(
	[credencial] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[grupoNoticia]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[grupoNoticia](
	[idGrupoNoticia] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [char](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[idGrupoNoticia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Grupo_Validacion_Factura]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Grupo_Validacion_Factura](
	[idGrupoValidacion] [int] NOT NULL,
	[idValidacionFactura] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[ejecQueryTryTran]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[ejecQueryTryTran]
    @sqlString text
AS 
declare @cantidad int;
	
    SET NOCOUNT ON;
	BEGIN TRY
       BEGIN TRAN
		EXEC(@sqlString);
		set @cantidad = @@ROWCOUNT
		COMMIT TRAN
	END TRY
	BEGIN CATCH
	set @cantidad = 'error'
		ROLLBACK TRAN
    END CATCH
	select @cantidad as cantidad
GO
/****** Object:  StoredProcedure [dbo].[ejecQuery]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[ejecQuery]
    @sqlString text
AS 
    SET NOCOUNT ON;
	BEGIN TRY
		EXEC(@sqlString);
	END TRY
	BEGIN CATCH 
		
    END CATCH
GO
/****** Object:  Table [dbo].[configuracion]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[configuracion](
	[idConfig] [char](10) NOT NULL,
	[esActivPortal] [bit] NULL,
	[correoAsunto] [char](100) NULL,
	[correoCuerpo] [text] NULL,
	[email] [char](100) NULL,
	[emailPass] [char](200) NULL,
	[esCreacionUsuarios] [bit] NULL,
	[maxUsuarios] [int] NULL,
	[esBloqSociedad] [bit] NULL,
	[numPassRecordar] [int] NULL,
	[intervalTiempo] [int] NULL,
	[maxIntentosFail] [int] NULL,
	[configPor] [int] NULL,
	[fechaConfiguracion] [datetime] NULL,
	[caducidadPass] [int] NULL,
	[emailDatos] [char](20) NULL,
	[tiempoBloqAdmin] [int] NULL,
	[maxXML] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[idConfig] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Proveedor_GrupoValidacion]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proveedor_GrupoValidacion](
	[idProveedor] [int] NOT NULL,
	[idGrupoValidacion] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[proveedor]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[proveedor](
	[idProveedor] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [char](100) NULL,
	[esBloq] [bit] NULL,
	[esCabeceraGrupo] [bit] NULL,
	[nombreGrupo] [char](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[idProveedor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pantalla]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pantalla](
	[idPantalla] [int] NOT NULL,
	[nombre] [char](50) NULL,
	[descripcion] [char](100) NULL,
	[esBloq] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[idPantalla] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[noticia]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[noticia](
	[idNoticia] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [char](100) NULL,
	[cuerpo] [varchar](max) NULL,
	[fechaInicio] [datetime] NULL,
	[fechaFin] [datetime] NULL,
	[urlImagen] [text] NULL,
	[esBloq] [bit] NULL,
	[tipoNoticia] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[idNoticia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[instancia]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[instancia](
	[idInstancia] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [char](150) NULL,
	[usuario] [char](50) NULL,
	[pass] [char](200) NULL,
	[endpointAdd] [text] NULL,
	[esBloq] [bit] NULL,
	[RFC] [char](20) NULL,
	[sociedad] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[idInstancia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GrupoValidacion]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GrupoValidacion](
	[idGrupoValidacion] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [nchar](50) NOT NULL,
	[fecha_creacion] [datetime] NOT NULL,
	[esBloq] [nchar](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idGrupoValidacion] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[email]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[email](
	[sufijo] [char](30) NOT NULL,
	[SMTPAdd] [char](50) NOT NULL,
	[puerto] [int] NOT NULL,
	[SSLOpt] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[sufijo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sociedad]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sociedad](
	[detProveedor_RFC] [char](20) NULL,
	[detProveedor_lifnr] [int] NULL,
	[bukrs] [int] NULL,
	[esBloq] [bit] NULL,
	[idInstancia] [int] NULL,
 CONSTRAINT [IX_soc_unic] UNIQUE NONCLUSTERED 
(
	[detProveedor_RFC] ASC,
	[detProveedor_lifnr] ASC,
	[bukrs] ASC,
	[idInstancia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[rol]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[rol](
	[idRol] [int] NOT NULL,
	[nombre] [char](30) NULL,
	[esActivo] [bit] NULL,
	[esCreacion] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[idRol] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ValidacionFactura]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValidacionFactura](
	[idValidacionFactura] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [nchar](45) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idValidacionFactura] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioSociedad]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UsuarioSociedad](
	[usuario_idUsuario] [char](50) NULL,
	[sociedad_bukrs] [int] NULL,
	[RFC] [char](20) NULL,
	[lifnr] [int] NULL,
	[instancia] [int] NULL,
 CONSTRAINT [IX_UsuarioSociedad] UNIQUE NONCLUSTERED 
(
	[usuario_idUsuario] ASC,
	[sociedad_bukrs] ASC,
	[RFC] ASC,
	[lifnr] ASC,
	[instancia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[insertEndpoints]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[insertEndpoints]
    @idPantalla nvarchar(50), 
    @Instancia nvarchar(50),
	@endpoint nvarchar(500)
AS 
    SET NOCOUNT ON;
	declare @informe char(30);
	BEGIN TRY
			insert into webservice values(@idPantalla,@Instancia,@endpoint,1);
			set @informe = 'insertado';
	END TRY
	BEGIN CATCH
		if exists(select pantalla_idPantalla,instancia_idInstancia from webService where pantalla_idPantalla = @idPantalla and instancia_idInstancia = @Instancia)
		BEGIN
			set @informe = 'existente'
		END
		ELSE
		set @informe = 'error';
	END CATCH
	select @informe as detalle;
GO
/****** Object:  StoredProcedure [dbo].[psdProConsultarPantalla]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdProConsultarPantalla]
AS 
    SET NOCOUNT ON;
	declare @result char(20);

		select idPantalla,nombre, descripcion from Pantalla;
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[usuario](
	[proveedor_idProveedor] [int] NULL,
	[nombre] [char](100) NULL,
	[apellidos] [char](100) NULL,
	[rol_idRol] [int] NULL,
	[usuarioLog] [char](50) NOT NULL,
	[usuarioPass] [char](200) NULL,
	[email] [char](100) NULL,
	[fechaCreacion] [datetime] NULL,
	[fechaIni] [datetime] NULL,
	[fechaIFn] [datetime] NULL,
	[_creadoPor] [int] NULL,
	[_autorizadoPor] [int] NULL,
	[esBloq] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[usuarioLog] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[insertNoticia]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[insertNoticia]
	@titulo char(30),     
	@body text,
	@fechaInicio datetime, 
    @fechaFin datetime,
	@URLImagen text,
	@tipoNoticia int -- 1 = general
AS 
    SET NOCOUNT ON;
	declare @result char(50); 
	BEGIN TRY
		if exists(select titulo from noticia where titulo = @titulo)
		BEGIN
			set @result = 'ese titulo de noticia ya existe'
		END
		ELSE
		BEGIN TRY
			insert into noticia(titulo, cuerpo, fechaInicio, fechaFin,urlImagen, esBloq, tipoNoticia) values(@titulo,@body,@fechaInicio,@fechaFin,@URLImagen, 1, @tipoNoticia); 
					set @result = 'correcto'
		END TRY
		BEGIN CATCH
			set @result = 'error al insertar en BD1'
		END CATCH
		
	END TRY
	BEGIN CATCH
		set @result = 'error al insertar en BD2'
	END CATCH
	select @result as detalle
GO
/****** Object:  StoredProcedure [dbo].[insertInstancia]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[insertInstancia]
    @descripcion nvarchar(50), 
    @nombre nvarchar(50),
	@password nvarchar(200),
	@endpoint text
AS 
    SET NOCOUNT ON;
	declare @informe char(30);

	if exists(select descripcion from instancia where descripcion = @descripcion)
	BEGIN
		set @informe = 'existente'
	END
	ELSE
	IF exists(select endpointAdd from instancia where endpointAdd like @endpoint)
		BEGIN
			set @informe = 'existente'
		END
		ELSE
		BEGIN
			BEGIN TRY
			insert into instancia(descripcion, usuario, pass,endpointAdd, esBloq ) values(@descripcion,@nombre,@password,@endpoint, 1);
			set @informe = 'insertado';
			END TRY
			BEGIN CATCH
				set @informe = 'error';
			END CATCH
		END
	select @informe as detalle;
GO
/****** Object:  StoredProcedure [dbo].[insertCredInacep]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[insertCredInacep]
    @passw char(200)
AS 
    SET NOCOUNT ON;
	declare @informe char(30);
	BEGIN TRY
			insert into credencialesInaceptables(credencial) values(@passw); 
			set @informe = 'insertado';
	END TRY
	BEGIN CATCH
		if exists(select credencial from credencialesInaceptables where credencial = @passw)
		BEGIN
			set @informe = 'existente'
		END
		ELSE
		set @informe = 'error';
	END CATCH
	select @informe as detalle;
GO
/****** Object:  StoredProcedure [dbo].[eliminarGrupoValidacion]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[eliminarGrupoValidacion]
    @idGrupoValidacion int
AS 
    SET NOCOUNT ON;
	delete from [Grupo_Validacion_Factura] where idGrupoValidacion = @idGrupoValidacion 
	delete from [Proveedor_GrupoValidacion] where idGrupoValidacion = @idGrupoValidacion 
	delete from [GrupoValidacion] where idGrupoValidacion = @idGrupoValidacion
GO
/****** Object:  Table [dbo].[GrupoNoticia_proveedor]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GrupoNoticia_proveedor](
	[grupoNoticia_idGruponoticia] [int] NULL,
	[proveedor_idProveedor] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GrupoNoticia_Noticia]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GrupoNoticia_Noticia](
	[grupoNoticia_IdGruponoticia] [int] NULL,
	[noticia_idNoticia] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[psdProConsultarNoticia]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdProConsultarNoticia]
AS 
    SET NOCOUNT ON;
	declare @result char(20);
	select idNoticia as Nº_noticia, titulo, cuerpo as Contenido,fechaInicio as Fecha_inicio, fechaFin as fecha_fin,urlImagen as URL_imagen ,tipoNoticia, esBloq as Estatus 
	from noticia 
	order by idNoticia desc
GO
/****** Object:  StoredProcedure [dbo].[psdProConsultarIsntancia]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdProConsultarIsntancia]
AS 
    SET NOCOUNT ON;
	declare @result char(20);
		select idInstancia, descripcion from instancia;
GO
/****** Object:  StoredProcedure [dbo].[psdProConsultarConfiguracion]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdProConsultarConfiguracion]
    @estatus nvarchar(20)
AS 
    SET NOCOUNT ON;
	select esActivPortal,correoAsunto, correoCuerpo,email, esCreacionUsuarios, maxUsuarios, esBloqSociedad, 
	numPassRecordar,intervalTiempo, maxIntentosFail, configPor, caducidadPass, emailDatos, tiempoBloqAdmin, maxXML
	 from configuracion 
	 where idConfig = @estatus;
GO
/****** Object:  StoredProcedure [dbo].[psdPConValidsFactByProv]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdPConValidsFactByProv]
    @idProveedor nvarchar(20)
AS 
	declare @idGrupo int;

    SET NOCOUNT ON;
	
	select @idGrupo = idGrupoValidacion from [Proveedor_GrupoValidacion] where idProveedor = @idProveedor 
	select descripcion from [ValidacionFactura] as vf, [Grupo_Validacion_Factura] as gvf  
	where gvf.idGrupoValidacion  = @idGrupo and gvf.idValidacionFactura = vf.idValidacionFactura
GO
/****** Object:  StoredProcedure [dbo].[psdPConUsuarioSoc]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdPConUsuarioSoc]
    @usuario char(20)
AS 
    SET NOCOUNT ON; 
	select * from UsuarioSociedad where usuario_idUsuario = @usuario
GO
/****** Object:  StoredProcedure [dbo].[psdPConsultarTodosEndpoints]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdPConsultarTodosEndpoints]
    
AS 
    SET NOCOUNT ON;
	SELECT  endpointAdd, idInstancia, descripcion
	from instancia where esBloq = 1
GO
/****** Object:  StoredProcedure [dbo].[psdPConsultarGrupoProv]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdPConsultarGrupoProv]
AS 
    SET NOCOUNT ON;
	select idProveedor as proveedor_idproveedor, nombreGrupo as Nombre from proveedor where esCabeceraGrupo = 1
GO
/****** Object:  StoredProcedure [dbo].[psdPConsultarCredInacep]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[psdPConsultarCredInacep]
AS 
    SET NOCOUNT ON;
	select idCredencialInaceptable, credencial as Credencial from credencialesInaceptables
GO
/****** Object:  StoredProcedure [dbo].[insertSociedad]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[insertSociedad]
    @detProveedor_RFC nvarchar(20), 
    @detProveedor_lifnr int,
	@bukrs int,
	@idInstancia int
AS 
    SET NOCOUNT ON;
	declare @result char(30);
	BEGIN TRY
			insert into sociedad(detProveedor_RFC,detProveedor_lifnr,bukrs,esBloq,idInstancia) values(@detProveedor_RFC,@detProveedor_lifnr,@bukrs,1, @idInstancia);
			select @result = 'insertado sociedad'
	END TRY
	BEGIN CATCH
		select @result = 'sociedad fallida'
	END CATCH
	select @result as detalle
GO
/****** Object:  StoredProcedure [dbo].[configuracionGeneral]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---

CREATE PROCEDURE [dbo].[configuracionGeneral]
     @esActivPortal bit,
     @correoAsunto nvarchar(100),
	 @correoCuerpo nvarchar(1000),
	 @email nvarchar(100),
	 @emailPass char(200),
	 @esCreacionUsuarios bit,
	 @maxUsuarios int,
	 @esBloqSociedad bit,
	 @numPassRecordar int,
	 @intervalTiempo int,
	 @maxIntentosFail int,
	 @configPor int,
	 @caducidadPass int,
	 @identificadorMail char(20),
	 @stringSQLComplement char(300),
	 @tiempoBloqAdmin int,
	 @maxXML int
AS 
    SET NOCOUNT ON;

	declare @esActivPortal2 bit;
    declare @correoAsunto2 nvarchar(100);
	declare @correoCuerpo2 nvarchar(1000);
	declare @email2 nvarchar(100);
	declare @emailPass2 char(200);
	declare @esCreacionUsuarios2 bit;
	declare @maxUsuarios2 int;
	declare @esBloqSociedad2 bit;
	declare @numPassRecordar2 int;
	declare @intervalTiempo2 int;
	declare @maxIntentosFail2 int;
	declare @configPor2 int;
	declare @fechaConfiguracion2 datetime; -- se recupera, al insertar se genera con SQL
	declare @caducidadPass2 int;
	declare @identificadorMail2 char(20);
	declare @tiempoBloqAdmin2 int;
	declare @maxXML2 int
	

	select @esActivPortal2 = esActivPortal, @correoAsunto2 = correoAsunto,@correoCuerpo2 = correoCuerpo,@email2 =email,@emailPass2 = emailPass,
	@esCreacionUsuarios2 = esCreacionUsuarios,@maxUsuarios2 = maxUsuarios,@esBloqSociedad2 = esBloqSociedad,@numPassRecordar2 = numPassRecordar,
	@intervalTiempo2 = intervalTiempo,@maxIntentosFail2 = maxIntentosFail,@configPor2 = configPor, @fechaConfiguracion2 = fechaConfiguracion, @caducidadPass2 = caducidadPass,
	@identificadorMail2 = emailDatos, @tiempoBloqAdmin2 = tiempoBloqAdmin, @maxXML2 = maxXML
	from configuracion 
	where idConfig = 'activo';

	IF(@identificadorMail2 = 'configurado')
	BEGIN
		declare @SMTPAdd2 char(50);
		declare @puerto2 int;
		declare @SSLOpt2 bit;

		select @SMTPAdd2 = SMTPAdd, @puerto2 = puerto , @SSLOpt2 = SSLOpt 
		 from email 
		where sufijo = 'configurado';

		update email 
		set SMTPAdd = @SMTPAdd2 , puerto = @puerto2, SSLOpt = @SSLOpt2 
		where sufijo = 'configuradoAnterior';

		set @identificadorMail2 = 'configuradoAnterior'

	END

	update configuracion 
	set esActivPortal = @esActivPortal2, 
	correoAsunto = @correoAsunto2,
	correoCuerpo = @correoCuerpo2,
	email = @email2,
	emailPass = @emailPass2,
	esCreacionUsuarios = @esCreacionUsuarios2,
	maxUsuarios =  @maxUsuarios2,
	esBloqSociedad = @esBloqSociedad2,
	numPassRecordar = @numPassRecordar2,
	intervalTiempo = @intervalTiempo2,
	maxIntentosFail =  @maxIntentosFail2, 
	configPor = @configPor2, 
	fechaConfiguracion = @fechaConfiguracion2,
	caducidadPass = @caducidadPass2,
	emailDatos = @identificadorMail2,
	tiempoBloqAdmin = @tiempoBloqAdmin2,
	maxXML = @maxXML2
	where idConfig = 'anterior'; 

	IF(@emailPass = 'kr3v/CL1NG27rxMKTK7OZA==' AND @email = @email2) BEGIN set @emailPass = @emailPass2 END

    update configuracion 
	set esActivPortal = @esActivPortal, 
	correoAsunto = @correoAsunto,
	correoCuerpo = @correoCuerpo,
	email = @email,
	emailPass = @emailPass,
	esCreacionUsuarios = @esCreacionUsuarios,
	maxUsuarios =  @maxUsuarios,
	esBloqSociedad = @esBloqSociedad,
	numPassRecordar = @numPassRecordar,
	intervalTiempo = @intervalTiempo,
	maxIntentosFail =  @maxIntentosFail, 
	configPor = @configPor, 
	fechaConfiguracion = GETDATE(),
	caducidadPass = @caducidadPass,
	emailDatos = @identificadorMail,
	tiempoBloqAdmin = @tiempoBloqAdmin,
	maxXML = @maxXML
	where idConfig = 'activo'; 

	IF(@identificadorMail = 'configurado') BEGIN execute(@stringSQLComplement) END
GO
/****** Object:  StoredProcedure [dbo].[backConfiguracionGeneral]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---

CREATE PROCEDURE [dbo].[backConfiguracionGeneral]
AS 
    SET NOCOUNT ON;
	declare @esActivPortal bit;
    declare @correoAsunto nvarchar(100);
	declare @correoCuerpo char(500);
	declare @email nvarchar(100);
	declare @emailPass nvarchar(200);
	declare @esCreacionUsuarios bit;
	declare @maxUsuarios int;
	declare @esBloqSociedad bit;
	declare @numPassRecordar int;
	declare @intervalTiempo int;
	declare @maxIntentosFail int; 
	declare @configPor int;
	declare @fechaConfiguracion datetime;
	declare @caducidadPass int;
	declare @emailDatos char(20);
	declare @tiempoBloqAdmin int;
	declare @maxXML int;

	declare @esActivPortal2 bit;
    declare @correoAsunto2 nvarchar(100);
	declare @correoCuerpo2 char(500);
	declare @email2 nvarchar(100);
	declare @emailPass2 nvarchar(200);
	declare @esCreacionUsuarios2 bit;
	declare @maxUsuarios2 int;
	declare @esBloqSociedad2 bit;
	declare @numPassRecordar2 int;
	declare @intervalTiempo2 int;
	declare @maxIntentosFail2 int;
	declare @configPor2 int;
	declare @caducidadPass2 int;
	declare @emailDatos2 char(20);
	declare @tiempoBloqAdmin2 int;
	declare @maxXML2 int;

	declare @informe char(30);
	
	BEGIN TRY
	select @esActivPortal = esActivPortal, @correoAsunto = correoAsunto,@correoCuerpo = correoCuerpo,@email =email,@emailPass = emailPass,
	@esCreacionUsuarios = esCreacionUsuarios,@maxUsuarios = maxUsuarios,@esBloqSociedad = esBloqSociedad,@numPassRecordar = numPassRecordar,
	@intervalTiempo = intervalTiempo,@maxIntentosFail = maxIntentosFail,@configPor = configPor, @fechaConfiguracion = fechaConfiguracion,
	@caducidadPass = caducidadPass, @emailDatos = emailDatos,  @tiempoBloqAdmin = tiempoBloqAdmin, @maxXML = maxXML
	 from configuracion where idConfig = 'activo';

	select @esActivPortal2 = esActivPortal, @correoAsunto2 = correoAsunto,@correoCuerpo2 = correoCuerpo,@email2 =email,@emailPass2 = emailPass,
	@esCreacionUsuarios2 = esCreacionUsuarios,@maxUsuarios2 = maxUsuarios,@esBloqSociedad2 = esBloqSociedad,@numPassRecordar2 = numPassRecordar,
	@intervalTiempo2 = intervalTiempo,@maxIntentosFail2 = maxIntentosFail,@configPor2 = configPor,
	@caducidadPass2 = caducidadPass, @emailDatos2 = emailDatos, @tiempoBloqAdmin2 = tiempoBloqAdmin, @maxXML2 = maxXML
	 from configuracion where idConfig = 'anterior';

	 IF(@emailDatos2 = 'configuradoAnterior')
	BEGIN
		declare @SMTPAdd2 char(50);
		declare @puerto2 int;
		declare @SSLOpt2 bit;

		declare @SMTPAdd3 char(50);
		declare @puerto3 int;
		declare @SSLOpt3 bit;

		select @SMTPAdd2 = SMTPAdd, @puerto2 = puerto , @SSLOpt2 = SSLOpt 
		 from email 
		where sufijo = 'configuradoAnterior';

		select @SMTPAdd3 = SMTPAdd, @puerto3 = puerto , @SSLOpt3 = SSLOpt 
		 from email 
		where sufijo = 'configurado';

		update email 
		set SMTPAdd = @SMTPAdd2 , puerto = @puerto2, SSLOpt = @SSLOpt2 
		where sufijo = 'configurado';

		update email 
		set SMTPAdd = @SMTPAdd3 , puerto = @puerto3, SSLOpt = @SSLOpt3 
		where sufijo = 'configuradoAnterior';

		SET @emailDatos2 = 'configurado'
		
	END

	IF(@emailDatos = 'configurado') BEGIN SET @emailDatos = 'configuradoAnterior' END

	update configuracion 
	set esActivPortal = @esActivPortal, 
	correoAsunto = @correoAsunto,
	correoCuerpo = @correoCuerpo,
	email = @email,
	emailPass = @emailPass,
	esCreacionUsuarios = @esCreacionUsuarios,
	maxUsuarios =  @maxUsuarios,
	esBloqSociedad = @esBloqSociedad,
	numPassRecordar = @numPassRecordar,
	intervalTiempo = @intervalTiempo,
	maxIntentosFail =  @maxIntentosFail, 
	configPor = @configPor, 
	fechaConfiguracion = @fechaConfiguracion,
	caducidadPass = @caducidadPass,
	emailDatos = @emailDatos,
	tiempoBloqAdmin = @tiempoBloqAdmin,
	maxXML = @maxXML

	where idConfig = 'anterior'; 

    update configuracion 
	set esActivPortal = @esActivPortal2, 
	correoAsunto = @correoAsunto2,
	correoCuerpo = @correoCuerpo2,
	email = @email2,
	emailPass = @emailPass2,
	esCreacionUsuarios = @esCreacionUsuarios2,
	maxUsuarios =  @maxUsuarios2,
	esBloqSociedad = @esBloqSociedad2,
	numPassRecordar = @numPassRecordar2,
	intervalTiempo = @intervalTiempo2,
	maxIntentosFail =  @maxIntentosFail2, 
	configPor = @configPor2, 
	caducidadPass = @caducidadPass2,
	emailDatos = @emailDatos2,
	fechaConfiguracion = GETDATE() ,
	tiempoBloqAdmin = @tiempoBloqAdmin2,
	maxXML = @maxXML2
	where idConfig = 'activo'; 

	set  @informe ='ok';
	END TRY
	BEGIN CATCH
		set  @informe ='error';	
	END CATCH
	select @informe
GO
/****** Object:  StoredProcedure [dbo].[consultarDatosEmail]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[consultarDatosEmail]
AS 
    SET NOCOUNT ON;
	--SELECT correoAsunto, correoCuerpo, email, emailPass from configuracion where idConfig = 'Activo';
	SELECT c.correoAsunto, c.correoCuerpo, c.email, c.emailPass, e.SMTPAdd, e.puerto, e.SSLOpt from configuracion as c inner join email as e on c.emailDatos = e.sufijo where idConfig = 'activo';
GO
/****** Object:  StoredProcedure [dbo].[ActualizaNoticia]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[ActualizaNoticia]
	@id int, 
	@titulo char(30),     
	@body varchar(max),
	@fechaInicio datetime, 
    @fechaFin datetime,
	@URLImagen text,
	@tipoNoticia bit
AS 
    SET NOCOUNT ON;
	declare @informe char(50); 
	BEGIN TRY
		update noticia set titulo = @titulo, cuerpo = @body, fechaInicio = @fechaInicio, fechaFin = @fechaFin, urlImagen = @URLImagen, tipoNoticia = @tipoNoticia where idNoticia  = @id
		set @informe = 'correcto'
	END TRY
	BEGIN CATCH
		set @informe = 'error'
	END CATCH
	select @informe as detalle
GO
/****** Object:  StoredProcedure [dbo].[actualizaInstancia]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[actualizaInstancia]
    @id int,
	@descripcion nvarchar(50), 
    @nombre nvarchar(50),
	@password nvarchar(200),
	@endpoint text
AS 
    SET NOCOUNT ON;
	declare @informe char(30);

	if exists(select descripcion from instancia where descripcion = @descripcion and idInstancia NOT IN (@id))
	BEGIN
		set @informe = 'existente'
	END
	ELSE
		IF exists(select endpointAdd from instancia where endpointAdd like @endpoint and idInstancia NOT IN (@id))
		BEGIN
			set @informe = 'existente'
		END
		ELSE
			BEGIN

				BEGIN TRY
				update instancia set descripcion = @descripcion, usuario = @nombre, pass = @password, endpointAdd = @endpoint where idInstancia = @id
						set @informe = 'actualizado';
				END TRY
				BEGIN CATCH
					set @informe = 'error';
				END CATCH
			END
	select @informe as detalle;
GO
/****** Object:  StoredProcedure [dbo].[consultarGrNoticiaPorId]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
  CREATE PROCEDURE [dbo].[consultarGrNoticiaPorId]
    @idGrupo int
AS 
    select g.idGrupoNoticia, g.nombre from grupoNoticia as g  where idGrupoNoticia = @idGrupo
GO
/****** Object:  StoredProcedure [dbo].[consultarProveedores]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[consultarProveedores]
AS 
    SET NOCOUNT ON;
	SELECT idProveedor as ID,nombre as Nombre FROM proveedor order by idProveedor desc ;
GO
/****** Object:  StoredProcedure [dbo].[consultarInstancia]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[consultarInstancia]
AS 
    SET NOCOUNT ON;
	SELECT idInstancia as ID,usuario as Usuario , descripcion as Descripción,endpointAdd as EndpointAddress, esBloq as Estatus FROM instancia order by idInstancia desc;
GO
/****** Object:  StoredProcedure [dbo].[consultarGrupoValidacionesXML]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[consultarGrupoValidacionesXML]
    --@idInstancia nvarchar(20)
AS 
    SET NOCOUNT ON;
	SELECT 
	idGrupoValidacion as ID,
	descripcion as Descripción,
	(SELECT Validaciones = STUFF(CAST((
		SELECT [text()] = ', ' + RTRIM([descripcion])
	FROM ValidacionFactura as vf
		INNER JOIN Grupo_Validacion_Factura as gvf on vf.idValidacionFactura = gvf.idValidacionFactura
	WHERE idGrupoValidacion=gv.idGrupoValidacion
		FOR XML PATH(''), TYPE) AS
		VARCHAR(MAX)), 1, 2, '')) AS 'Validaciones'
	FROM GrupoValidacion as gv;
GO
/****** Object:  StoredProcedure [dbo].[consultarProvSelToGrpValByIdGrpVal]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[consultarProvSelToGrpValByIdGrpVal] 
	-- Add the parameters for the stored procedure here
	@idGrupoValidacion int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		proveedor.idProveedor,
		proveedor.nombre
	FROM
		proveedor
		INNER JOIN Proveedor_GrupoValidacion AS pgv ON pgv.idProveedor=proveedor.idProveedor
	WHERE 
		pgv.idGrupoValidacion = @idGrupoValidacion
END
GO
/****** Object:  StoredProcedure [dbo].[consultarSociedadesByUsuario]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[consultarSociedadesByUsuario]
    @idUsuario nvarchar(20)
AS 
    SET NOCOUNT ON;
	
	SELECT u.sociedad_bukrs as bukrs, u.RFC, u.lifnr, u.instancia, i.endpointAdd, u.lifnr, i.usuario, i.pass, i.RFC, i.descripcion
	FROM UsuarioSociedad as u, instancia as i, sociedad as s 
	WHERE usuario_idUsuario = @idUsuario
	and u.instancia = i.idInstancia
	and u.RFC = s.detProveedor_RFC -- new
	and u.lifnr = s.detProveedor_lifnr -- new
	and u.sociedad_bukrs = s.bukrs -- new
	and u.instancia = s.idInstancia-- new
	and s.esBloq = 1 -- new 
	and i.esBloq = 1 -- New 
	and (select esBloqSociedad from configuracion where idConfig = 'activo') = 0  --new
	 order by u.instancia
GO
/****** Object:  StoredProcedure [dbo].[consultarValFactByIdGrpVal]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[consultarValFactByIdGrpVal] 
	@idGrupoValidacion int 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		vf.idValidacionFactura,
		descripcion 
	FROM 
		ValidacionFactura as vf
		INNER JOIN Grupo_Validacion_Factura as gvf on gvf.idValidacionFactura = vf.idValidacionFactura
	WHERE 
		idGrupoValidacion = @idGrupoValidacion
END
GO
/****** Object:  StoredProcedure [dbo].[consultarValidacionFactura]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[consultarValidacionFactura]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT idValidacionFactura,descripcion FROM ValidacionFactura
END
GO
/****** Object:  Table [dbo].[DetRol]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetRol](
	[idDetRol] [int] IDENTITY(1,1) NOT NULL,
	[rol_id_rol] [int] NULL,
	[pantalla_idPantalla] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[idDetRol] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[detProveedor]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[detProveedor](
	[RFC] [char](20) NOT NULL,
	[proveedor_idProveedor] [int] NULL,
	[instancia_idInstancia] [int] NOT NULL,
	[lifnr] [int] NOT NULL,
	[nombre] [char](50) NULL,
	[idOriginal] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RFC] ASC,
	[instancia_idInstancia] ASC,
	[lifnr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[getMaxXML]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getMaxXML]
AS 
    SET NOCOUNT ON;
	select maxXML from configuracion where idConfig = 'activo';
GO
/****** Object:  Table [dbo].[controlSeguridad]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[controlSeguridad](
	[idControlSeguridad] [int] IDENTITY(1,1) NOT NULL,
	[usuario_idUsuario] [char](50) NULL,
	[esCambiarPassNext] [bit] NULL,
	[fechaUltimoCambio] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[idControlSeguridad] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[credencialFallida]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[credencialFallida](
	[idCredencialFallida] [int] IDENTITY(1,1) NOT NULL,
	[usuario_idUsuario] [char](50) NULL,
	[fecha] [datetime] NULL,
	[credencial] [char](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[idCredencialFallida] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[credencialesUsadas]    Script Date: 06/15/2016 14:45:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[credencialesUsadas](
	[idCredencialUsada] [int] IDENTITY(1,1) NOT NULL,
	[usuario_idUsuario] [char](50) NULL,
	[fecha] [datetime] NULL,
	[credencial] [char](200) NULL,
	[tipo] [char](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[idCredencialUsada] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[consultarValidacionesByIdUsuario]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[consultarValidacionesByIdUsuario]
	@idUsuario varchar(30)
AS
BEGIN

	SELECT *-- idValidacionFactura 
	FROM 
		usuario AS u 
		inner join Proveedor_GrupoValidacion AS pgv on  u.proveedor_idProveedor = pgv.idProveedor
		INNER JOIN GrupoValidacion AS gv ON gv.idGrupoValidacion = pgv.idGrupoValidacion
		INNER JOIN Grupo_Validacion_Factura AS gvf ON gv.idGrupoValidacion = gvf.idGrupoValidacion

	WHERE usuarioLog = @idUsuario	
END
GO
/****** Object:  StoredProcedure [dbo].[consultarUsuarioLogeado]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---

CREATE PROCEDURE [dbo].[consultarUsuarioLogeado]
    @idUsuario nvarchar(50)
AS 
    SET NOCOUNT ON;
	SELECT usuarioLog as idUsuario, proveedor_idProveedor,rol_idRol,email FROM usuario WHERE usuarioLog=@idUsuario
GO
/****** Object:  StoredProcedure [dbo].[consultarRolPorId]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[consultarRolPorId]
    @id int
AS 
    SET NOCOUNT ON;
SELECT 
 idRol,
 nombre,
 (SELECT Pantallas = STUFF(CAST((
  SELECT [text()] = ', ' + RTRIM([descripcion])
 FROM Pantalla 
  INNER JOIN DetRol ON DetRol.pantalla_idPantalla=Pantalla.idPantalla 
 WHERE rol_id_rol=rol.idRol
  FOR XML PATH(''), TYPE) AS
  VARCHAR(MAX)), 1, 2, '')   ) AS pantallas, esActivo as Estatus, esCreacion as Defau
FROM rol where idRol = @id;
GO
/****** Object:  StoredProcedure [dbo].[consultarRolesPorProveedor]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[consultarRolesPorProveedor]
    @proveedor nvarchar(50)
AS 
    SET NOCOUNT ON;
	declare @idRolUsuario int;
	select @idRolUsuario = rol_idRol from usuario where usuarioLog = @proveedor
SELECT 
 u.usuarioLog,
 rol.nombre,
 (SELECT Pantallas = STUFF(CAST((
  SELECT [text()] = ', ' + RTRIM([descripcion])
 FROM Pantalla 
  INNER JOIN DetRol ON DetRol.pantalla_idPantalla=Pantalla.idPantalla 
 WHERE rol_id_rol=rol.idRol
  FOR XML PATH(''), TYPE) AS
  VARCHAR(MAX)), 1, 2, '')) AS pantallas
FROM rol, usuario as u  where u.rol_idRol = rol.idRol and u.proveedor_idProveedor=@proveedor
GO
/****** Object:  StoredProcedure [dbo].[consultarRoles]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[consultarRoles]
AS 
    SET NOCOUNT ON;
SELECT 
 idRol,
 nombre as Nombre,
 (SELECT Pantallas = STUFF(CAST((
  SELECT [text()] = ', ' + RTRIM([descripcion])
 FROM Pantalla 
  INNER JOIN DetRol ON DetRol.pantalla_idPantalla=Pantalla.idPantalla 
 WHERE rol_id_rol=rol.idRol
  FOR XML PATH(''), TYPE) AS
  VARCHAR(MAX)), 1, 2, '')   ) AS Pantallas, esCreacion as Por_defecto, esActivo as Estatus 
FROM rol where idRol != 0;
GO
/****** Object:  StoredProcedure [dbo].[consultarProvNoSelToGrpVal]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---

CREATE PROCEDURE [dbo].[consultarProvNoSelToGrpVal]	
AS
BEGIN
	SET NOCOUNT ON;

	SELECT distinct d.proveedor_idProveedor as idProveedor,
		d.nombre as nombre
		FROM detProveedor as d inner join proveedor as p on 
		d.proveedor_idProveedor = p.idProveedor and d.nombre = p.nombre 
		WHERE d.proveedor_idProveedor NOT IN (SELECT 
										detProveedor.proveedor_idProveedor
									FROM
										detProveedor
										INNER JOIN Proveedor_GrupoValidacion AS pgv ON pgv.idProveedor=detProveedor.proveedor_idProveedor)
										and p.esBloq = 1 and d.RFC <> '' order by nombre 
	END
GO
/****** Object:  StoredProcedure [dbo].[consultarProveedoresSinNoticia]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[consultarProveedoresSinNoticia]
AS 
	SELECT distinct d.proveedor_idProveedor, d.RFC, d.nombre, d.lifnr, p.nombreGrupo
	FROM detProveedor as d left join proveedor as p on p.idProveedor = d.proveedor_idProveedor order by	d.nombre asc
	--WHERE proveedor_idProveedor
	-- NOT IN 
	--(SELECT distinct idProveedor
	--FROM proveedor as p , GrupoNoticia_proveedor as gnp 
	--where p.idProveedor =  gnp.proveedor_idProveedor)
GO
/****** Object:  StoredProcedure [dbo].[consultarProveedoresConNoticia]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[consultarProveedoresConNoticia]
AS 
    SELECT idProveedor,nombre as Nombre
	FROM proveedor
	WHERE idProveedor IN 
	(SELECT distinct idProveedor
	FROM proveedor as p , GrupoNoticia_proveedor as gnp 
	where p.idProveedor =  gnp.proveedor_idProveedor)
GO
/****** Object:  StoredProcedure [dbo].[consultarGruposDeNoticia]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[consultarGruposDeNoticia]
AS 
select g.idGrupoNoticia, g.nombre as Nombre,
 (SELECT titulos = STUFF(CAST((
  SELECT [text()] = ', ' + RTRIM(titulo)
 FROM noticia as n
  INNER JOIN GrupoNoticia_Noticia as gnn ON gnn.noticia_idNoticia = n.idNoticia
  inner join grupoNoticia as gn on gn.idGrupoNoticia = gnn.grupoNoticia_IdGruponoticia and gn.idGrupoNoticia = g.idGrupoNoticia
  FOR XML PATH(''), TYPE) AS
  VARCHAR(MAX)), 1, 2, '')   ) AS Titulos
 from grupoNoticia as g
GO
/****** Object:  StoredProcedure [dbo].[consultarEndpoints]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[consultarEndpoints]
    @lifnr char(20),
	@idProveedor int
AS 
    SET NOCOUNT ON;
	select endpointAdd, descripcion, usuario, pass  from instancia as i, detProveedor as d
	where d.lifnr = @lifnr 
	and d.proveedor_idProveedor = @idProveedor 
	and d.instancia_idInstancia = i.idInstancia
GO
/****** Object:  StoredProcedure [dbo].[consultardetProveedor]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[consultarDetProveedor]
AS 
    SET NOCOUNT ON;
	SELECT d.RFC as RFC, d.nombre as Nombre, lifnr as Numero_SAP  
	FROM detProveedor as d inner join proveedor as p on d.proveedor_idProveedor = p.idProveedor 
	  order by Nombre asc;

--and d.nombre = p.nombre where lifnr = 1000005
GO
/****** Object:  StoredProcedure [dbo].[conSocPorProv]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[conSocPorProv]
    @id int
AS 
    SET NOCOUNT ON;
	select distinct i.idInstancia as I,s.bukrs as BUKRS,d.RFC as RFC ,d.lifnr AS LIFNR, i.descripcion as Descripción ,p.nombre as Titular, d.nombre RealSociedad, s.esBloq as Estatus   
		 from sociedad as s
		 inner join detProveedor as d
		 on s.detProveedor_RFC = d.RFC 
		 inner join proveedor as p 
		 on p.idProveedor = d.proveedor_idProveedor 
		 inner join instancia as i 
		 on d.instancia_idInstancia = i.idInstancia   
		 and p.idProveedor = @id 
		 and s.detProveedor_lifnr = d.lifnr --- new
		 order by i.descripcion, d.nombre
GO
/****** Object:  StoredProcedure [dbo].[conProvPorGrProv]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[conProvPorGrProv]
    @idGrupo nvarchar(20)
AS 
    select distinct RFC, nombre as Nombre from detProveedor where proveedor_idProveedor = @idGrupo
GO
/****** Object:  StoredProcedure [dbo].[conProvPorGrNoticia]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[conProvPorGrNoticia]
    @idGrupo nvarchar(20)
AS 
    SELECT idProveedor,nombre
	FROM proveedor
	WHERE idProveedor IN 
	(SELECT distinct idProveedor
	FROM proveedor as p , GrupoNoticia_proveedor as gnp 
	where p.idProveedor =  gnp.proveedor_idProveedor and grupoNoticia_idGruponoticia = @idGrupo)
GO
/****** Object:  StoredProcedure [dbo].[AsignarRol]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[AsignarRol]
    @usuario nvarchar(50), 
    @rol nvarchar(50),
	@mode char(10) -- si es 1 es el primer intento, si es dos es cuando se acepto actualizar despues de saber que ya esta asignado
AS 
    SET NOCOUNT ON;
	declare @informe char(50);
	declare @idRol int;
	
	if(@mode = '1')
	BEGIN
			IF exists(select usuarioLog from usuario where usuarioLog = @usuario)  -- se hace para evitar errores introducidos por el javascript que se usa
			BEGIN
				IF exists(select usuarioLog from usuario where rol_idRol  is Null and usuarioLog = @usuario)
				BEGIN
						select @idRol = idRol from rol where nombre = @rol
						update usuario set rol_idRol = @idRol where usuarioLog = @usuario;
						select @informe = @@ROWCOUNT
				END
				ELSE
					BEGIN TRY
						set @informe = 'el usuario ya esta asignado'; 
					END TRY
					BEGIN CATCH
					set @informe = 'catch1'; 
					END CATCH				
			END
			ELSE
			BEGIN TRY
					SET @informe = 'el usuario no existe'; 
					END TRY
					BEGIN CATCH
					set @informe = 'catch1'; 
					END CATCH	
	END
	ELSE
	if(@mode = '2')
	BEGIN
		select @idRol = idRol from rol where nombre = @rol
		update usuario set rol_idRol = @idRol where usuarioLog = @usuario;
		select @informe = @@ROWCOUNT
	END
		ELSE
		BEGIN TRY	
			set @informe = 'envio un modo desconocido'; 
		END TRY
		BEGIN CATCH
			set @informe = 'catch2'; 
		END CATCH
	select @informe as informe
GO
/****** Object:  StoredProcedure [dbo].[actualizaRol]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery46.sql|7|0|C:\Users\TracuAdm\AppData\Local\Temp\4\~vs794F.sql
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[actualizaRol] 
	@nombreRol char(30),     
	@esActive int,
	@facturas int, 
    @partidas int,
	@pagos int,
	@datosMaestros int,
	@usuarios int,
	@idAnterior int,
	@esCreacion int
AS 
    SET NOCOUNT ON;
	declare @id int; 
	declare @result char(20); 
	set @id = 0;

	declare @informe char(30);	
	BEGIN
		--set @result = 'nombre existente'
		BEGIN TRY
			BEGIN TRAN
				IF(@facturas = 1)
				BEGIN
					set @id = @id + 1;  	
				END
				IF(@partidas = 1)
				BEGIN
					set @id = @id + 2; 	
				END
				IF(@pagos = 1)
				BEGIN
					set @id = @id + 4; 	
				END
				IF(@datosMaestros = 1)
				BEGIN
					set @id = @id + 8; 	
				END
				IF(@usuarios = 1)
				BEGIN
					set @id = @id + 16; 	
				END
				IF not exists(select idRol from rol where idRol = @id)
				begin
					delete from DetRol where rol_id_rol = @idAnterior;
					if (@esCreacion = 1)
					begin
						update rol set esCreacion = 0;
						insert into rol(idRol, nombre, esActivo, esCreacion) values(@id,@nombreRol,@esActive, 1);
					end
					else
					begin
						insert into rol(idRol, nombre, esActivo, esCreacion) values(@id,@nombreRol,@esActive, 0);
					end
				--update rol set idRol = @id, nombre = @nombreRol, esActivo = @esActive where idRol = @idAnterior
				--declare @idActual int;
				--select @idActual =  @@IDENTITY;  
					IF(@facturas = 1)
					BEGIN
						if exists(select rol_id_rol from DetRol where rol_id_rol = @idAnterior and pantalla_idPantalla = 1)
							BEGIN
								update DetRol set rol_id_rol = @id, pantalla_idPantalla = 1 where rol_id_rol = @idAnterior and pantalla_idPantalla = 1;
							--insert into DetRol(rol_id_rol,pantalla_idPantalla) values(@id,1);  	
							END
							ELSE
								insert into DetRol(rol_id_rol,pantalla_idPantalla) values(@id,1);
					END
					IF(@partidas = 1)
					BEGIN
						if exists(select rol_id_rol from DetRol where rol_id_rol = @idAnterior and pantalla_idPantalla = 2)
							BEGIN
								update DetRol set rol_id_rol = @id, pantalla_idPantalla = 2 where rol_id_rol = @idAnterior and pantalla_idPantalla = 2;
							--insert into DetRol(rol_id_rol,pantalla_idPantalla) values(@id,1);  	
							END
							ELSE
								insert into DetRol(rol_id_rol,pantalla_idPantalla) values(@id,2); 	
					END
					IF(@pagos = 1)
					BEGIN
						if exists(select rol_id_rol from DetRol where rol_id_rol = @idAnterior and pantalla_idPantalla = 4)
							BEGIN
								update DetRol set rol_id_rol = @id, pantalla_idPantalla = 4 where rol_id_rol = @idAnterior and pantalla_idPantalla = 4;
							--insert into DetRol(rol_id_rol,pantalla_idPantalla) values(@id,1);  	
							END
							ELSE
								insert into DetRol(rol_id_rol,pantalla_idPantalla) values(@id,4); 		
					END
					IF(@datosMaestros = 1)
					BEGIN
						if exists(select rol_id_rol from DetRol where rol_id_rol = @idAnterior and pantalla_idPantalla = 8 and pantalla_idPantalla = 8)
							BEGIN
								update DetRol set rol_id_rol = @id, pantalla_idPantalla = 8 where rol_id_rol = @idAnterior;
							--insert into DetRol(rol_id_rol,pantalla_idPantalla) values(@id,1);  	
							END
							ELSE
								insert into DetRol(rol_id_rol,pantalla_idPantalla) values(@id,8); 	  	
					END
					IF(@usuarios = 1)
					BEGIN
						if exists(select rol_id_rol from DetRol where rol_id_rol = @idAnterior and pantalla_idPantalla = 16 and pantalla_idPantalla = 16)
							BEGIN
								update DetRol set rol_id_rol = @id, pantalla_idPantalla = 16 where rol_id_rol = @idAnterior;
							--insert into DetRol(rol_id_rol,pantalla_idPantalla) values(@id,1);  	
							END
							ELSE
								insert into DetRol(rol_id_rol,pantalla_idPantalla) values(@id,16); 	  	
					END
					update usuario set rol_idRol = @id where rol_idRol = @idAnterior;
					delete from rol where idRol = @idAnterior;
					COMMIT TRANSACTION
					set @result = 'correcto'
				END
				ELSE
				BEGIN
					if exists(select * from rol where esCreacion = 1) and @esCreacion = 1
					BEGIN
						update rol set esCreacion = 0;
						update rol set nombre = @nombreRol, esCreacion = @esCreacion, esActivo = @esActive where idRol = @idAnterior;
					END
					else
					BEGIN
						update rol set nombre = @nombreRol, esCreacion = @esCreacion, esActivo = @esActive where idRol = @idAnterior;
					END
					
					COMMIT TRANSACTION
					set @result = 'correcto'
				END
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
			set @result = 'incorrecto'
		END CATCH
	END
	select @result as detalle
GO
/****** Object:  StoredProcedure [dbo].[insertUnionProveedores]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---

CREATE PROCEDURE [dbo].[insertUnionProveedores]
	@RFC1 char(20),
	@RFC2 char(20)
    
AS 
    SET NOCOUNT ON;
	DECLARE @idNuevo int;
	DECLARE @informe char(50);
			BEGIN TRY
				BEGIN TRAN
					select @idNuevo = proveedor_idProveedor from detProveedor where RFC = @RFC1;
					update detProveedor set proveedor_idProveedor = @idNuevo where RFC = @RFC2;
					set @informe = 'Actualizado correctamente'
				COMMIT TRAN
			END TRY
			BEGIN CATCH
				set @informe = 'ocurrio un error inesperado'
			END CATCH
	select @informe as informe
GO
/****** Object:  StoredProcedure [dbo].[insertRol]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[insertRol] 
	@nombreRol char(30),     
	@esActive int,
	@facturas int, 
    @partidas int,
	@pagos int,
	@datosMaestros int,
	@usuarios int,
	@esCreacion int
AS 
    SET NOCOUNT ON;
	declare @id int; 
	declare @result char(20); 
	set @id = 0;

	declare @informe char(30);
	if exists(select nombre from rol where nombre = @nombreRol)
	BEGIN
		set @result = 'nombre existente'
	END
	ELSE
	BEGIN TRY
		BEGIN TRAN
			IF(@facturas = 1)
			BEGIN
				set @id = @id + 1;  	
			END
			IF(@partidas = 1)
			BEGIN
				set @id = @id + 2; 	
			END
			IF(@pagos = 1)
			BEGIN
				set @id = @id + 4; 	
			END
			IF(@datosMaestros = 1)
			BEGIN
				set @id = @id + 8; 	
			END
			IF(@usuarios = 1)
			BEGIN
				set @id = @id + 16; 	
			END
			if(@esCreacion = 1)
			begin
				update rol set esCreacion = 0 where esCreacion = 1;
				insert into rol(idRol, nombre, esActivo, esCreacion) values(@id,@nombreRol,@esActive, @esCreacion);
			end
			else
			begin
				insert into rol(idRol, nombre, esActivo, esCreacion) values(@id,@nombreRol,@esActive, 0);
			end
			
			declare @idActual int;
			select @idActual =  @@IDENTITY;  
			IF(@facturas = 1)
			BEGIN
				insert into DetRol(rol_id_rol,pantalla_idPantalla) values(@id,1);  	
			END
			IF(@partidas = 1)
			BEGIN
				insert into DetRol(rol_id_rol,pantalla_idPantalla) values(@id,2);  	
			END
			IF(@pagos = 1)
			BEGIN
				insert into DetRol(rol_id_rol,pantalla_idPantalla) values(@id,4);  	
			END
			IF(@datosMaestros = 1)
			BEGIN
				insert into DetRol(rol_id_rol,pantalla_idPantalla) values(@id,8);  	
			END
			IF(@usuarios = 1)
			BEGIN
				insert into DetRol(rol_id_rol,pantalla_idPantalla) values(@id,16);  	
			END
			
		COMMIT TRAN
			set @result = 'correcto'
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		set @result = 'incorrecto'
	END CATCH
	select @result as detalle
GO
/****** Object:  StoredProcedure [dbo].[insertProveedorDetProveedor]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[insertProveedorDetProveedor]
	@RFC char(20),
    @nombre varchar(50),
	@lifnr char(10),
	@idInstancia int
AS 
    SET NOCOUNT ON;
	DECLARE @informe char(30);
	DECLARE @result2 char(30);

	DECLARE @idExistente int;
	DECLARE @idNuevo int;

	--if not exists(select RFC from detProveedor where RFC = @RFC and RFC <> '')  -- verificar si existe el RFC
	--BEGIN
		BEGIN TRY
			BEGIN TRAN  
			insert into proveedor(nombre, esBloq) values(@nombre,1);
			select @idNuevo =  @@IDENTITY;
			insert into detProveedor(RFC,instancia_idInstancia,lifnr,nombre,proveedor_idProveedor, idOriginal) -- 
				values(@RFC,@idInstancia,@lifnr,@nombre,@idNuevo, @idNuevo);
			set @informe = 'insertado detProveedor1'
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			set @informe = 'error1'
		END CATCH
	--END	
	--ELSE
	--	BEGIN TRY
	--			select @idExistente = proveedor_idProveedor from detProveedor where RFC = @RFC
	--			insert into detProveedor(RFC,instancia_idInstancia,lifnr,nombre,proveedor_idProveedor, idOriginal) -- 
	--			values(@RFC,@idInstancia,@lifnr,@nombre,@idExistente, @idExistente);
	--			set @informe = 'insertado detProveedor2'
	--	END TRY
	--	BEGIN CATCH
	--	set @informe = 'error2'
	--	END CATCH
	select @informe as informe
GO
/****** Object:  StoredProcedure [dbo].[psdPConProvConNotPorId]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdPConProvConNotPorId]
    @idGrupoNoticia nvarchar(20)
AS 
    SELECT distinct idProveedor,RFC, proveedor.nombre, lifnr, nombreGrupo -- se agrego  RFC, proveedor.
	FROM proveedor,detProveedor, GrupoNoticia_proveedor -- se agrego detProveedor,
	WHERE idProveedor IN 
	(SELECT distinct idProveedor
	FROM proveedor as p , GrupoNoticia_proveedor as gnp 
	where p.idProveedor =  gnp.proveedor_idProveedor and gnp.grupoNoticia_idGruponoticia = 1) 
	and proveedor.idProveedor = detProveedor.proveedor_idProveedor order by nombre asc -- se agrego completa
GO
/****** Object:  StoredProcedure [dbo].[psdPConsultarProvsEnGrupo]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdPConsultarProvsEnGrupo]
AS 
    SET NOCOUNT ON;
select distinct RFC as RFC,lifnr as LIFNR, nombre as Nombre  
from detProveedor 
where proveedor_idProveedor in(select idProveedor from proveedor where esCabeceraGrupo = 1)
GO
/****** Object:  StoredProcedure [dbo].[psdProConNotNoSelect]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
---::::::::::::::::::::::::::::::::::::::::::::::---
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdProConNotNoSelect]
    @idGrupo nvarchar(20)
AS 
    SET NOCOUNT ON;
	select idNoticia as Nº_noticia, 
	'<strong>Titulo: </strong>' + titulo as Titulo,'<strong>Contenido: </strong>' + (select SUBSTRING((select cuerpo),0,100)) as Contenido, 
	'<strong>Fecha de inicio: </strong>' + cast(fechaInicio as CHAR(12)) as Fecha_Inicio,'<strong>Fecha de fin: </strong>' + cast(fechaFin as CHAR(12)) as Fecha_fin,
	'<strong>URL de la imagen: </strong>' + (select SUBSTRING((select urlImagen),0,100)) as URL_de_imagen
	from noticia 
	 where idNoticia not in(select noticia_idNoticia from GrupoNoticia_Noticia where grupoNoticia_IdGruponoticia = @idGrupo) 
	 order by idNoticia desc
GO
/****** Object:  StoredProcedure [dbo].[psdProConNotiEnGrupo]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
---::::::::::::::::::::::::::::::::::::::::::::::---
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdProConNotiEnGrupo]
    @idGrupo nvarchar(20)
AS 
	select idNoticia as Nº_noticia, 
	'<strong>Titulo: </strong>' + titulo as Titulo,'<strong>Contenido: </strong>' + (select SUBSTRING((select cuerpo),0,100)) as Contenido, 
	'<strong>Fecha de inicio: </strong>' + cast(fechaInicio as CHAR(12)) as Fecha_Inicio,'<strong>Fecha de fin: </strong>' + cast(fechaFin as CHAR(12)) as Fecha_fin,
	'<strong>URL de la imagen: </strong>' + (select SUBSTRING((select urlImagen),0,100)) as URL_de_imagen
	from noticia 
	 where idNoticia in(select noticia_idNoticia from GrupoNoticia_Noticia where grupoNoticia_IdGruponoticia = @idGrupo) 

	 order by idNoticia desc
GO
/****** Object:  StoredProcedure [dbo].[psdProConUsersPorFiltro]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdProConUsersPorFiltro]
    @id int
AS 
    SET NOCOUNT ON;
	declare @informe char(20);
		SELECT usuarioLog as Usuario, u.nombre as Nombre, apellidos as Apellidos, r.nombre as Rol,  esBloq as Estatus  
		from usuario as u, rol as r
		where proveedor_idProveedor in 
		(
			select idProveedor from proveedor WHERE idProveedor in
			(  
			select proveedor_idProveedor from detProveedor where proveedor_idProveedor = @id -- la subseleccion se hace para poder dar la posibilidad de desvincular los proveedores en un futuro, esto para no perder el link, la base de volver a unirlos es el nombre   
			)
		) and u.rol_idRol = r.idRol;
GO
/****** Object:  StoredProcedure [dbo].[psdProConsultarProveedores]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdProConsultarProveedores]
AS 
    SET NOCOUNT ON;
	declare @result char(20);
		select distinct idOriginal as Numero, d.nombre as Nombre, d.RFC as RFC, 
		u.usuarioLog as Usuario, t.Grupo as Grupo, t.Estatus as Estatus from 
(SELECT distinct p.idProveedor as Numero, 
p.esBloq as Estatus, p.nombreGrupo as Grupo 
FROM detProveedor as d inner join proveedor as p on d.proveedor_idProveedor = p.idProveedor 
and d.nombre = p.nombre ) as t inner join detProveedor as d on t.Numero = proveedor_idProveedor 
left join usuario as u on u.proveedor_idProveedor = d.idOriginal order by Nombre asc
GO
/****** Object:  StoredProcedure [dbo].[psdProConsultarNoticiaPoridProveedor]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery41.sql|7|0|C:\Users\TracuAdm\AppData\Local\Temp\4\~vs841C.sql
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdProConsultarNoticiaPoridProveedor]
    @idProveedor int
AS 
    SET NOCOUNT ON;
	declare @informe char(30);
	declare @idGrupoNoticia int;
	declare @cantidad int;

	BEGIN TRY
				BEGIN TRAN
				IF((select count(tipoNoticia) from noticia as n, GrupoNoticia_proveedor as gn,GrupoNoticia_Noticia as grn
				where gn.proveedor_idProveedor = @idProveedor and gn.grupoNoticia_idGruponoticia = grn.grupoNoticia_IdGruponoticia
				 and grn.noticia_idNoticia = n.idNoticia and tipoNoticia = 0 and esBloq = 1) > 0) -- sea asignable, este desblqueado y esta en un grupo el proveedor
					BEGIN
						select @idGrupoNoticia =  grupoNoticia_idGruponoticia from GrupoNoticia_proveedor where proveedor_idProveedor = @idProveedor
						SELECT TOP 1 titulo,cuerpo,urlImagen
						 FROM noticia as n, GrupoNoticia_Noticia as gnn  
						 where n.esBloq = 1 
						 and tipoNoticia = 0 -- asignable
						 and getdate() between fechaInicio and fechaFin
						 and n.idNoticia = gnn.noticia_idNoticia 
						 and gnn.grupoNoticia_IdGruponoticia  = @idGrupoNoticia 
						ORDER BY NEWID ()
					END
				ELSE
					BEGIN 
						SELECT TOP 1 titulo,cuerpo,urlImagen
						 FROM noticia as n
						 where n.esBloq = 1 
						 and tipoNoticia = 1 -- general
						 and getdate() between fechaInicio and fechaFin
						 ORDER BY NEWID ()
					END	
				COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		set @informe = 'error' 
	END CATCH
GO
/****** Object:  StoredProcedure [dbo].[psdConsultarPantallaPoridRol]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdConsultarPantallaPoridRol]
    @idRol int
AS 
    SET NOCOUNT ON;

	SELECT	
		idPantalla,
		nombre
	FROM
		Pantalla
		INNER JOIN DetRol ON DetRol.pantalla_idPantalla = Pantalla.idPantalla
	WHERE 
		DetRol.rol_id_rol = @idRol or DetRol.rol_id_rol = 0
GO
/****** Object:  StoredProcedure [dbo].[psdActualizarBloqueoProveedores]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[psdActualizarBloqueoProveedores] 
    @Lifnr int, 
    @Estado int 
AS 

    SET NOCOUNT ON;
    declare @informe char(30);
    begin try
	update proveedor set esBloq = @Estado 
	where idProveedor = (select proveedor_idProveedor from detProveedor where lifnr = @Lifnr)
	set @informe = 'Actualizado'
    end try
    begin catch
    set @informe = 'No existe'
    end catch
GO
/****** Object:  StoredProcedure [dbo].[verifUser]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[verifUser]
    @usuario nvarchar(50), 
    @pass char(200)
AS 
    SET NOCOUNT ON;
	declare @result char(30);
	declare @resid char(30);
	declare @idRol int;
	declare @nombre char(100);
	declare @cambiar bit;
	declare @lifnr char(20);
	declare @diasCaducidad int;
	declare @fechaUltimoCambio datetime;
	declare @esActivoPortal int;
	declare @esActivoProveedor int;
	declare @esActivoRol int;
	declare @esEnFecha int;
	declare @rfc char(20);

	BEGIN TRY
	--select @pass = RTRIM(@pass)
	  IF exists (Select usuarioLog from usuario  where usuarioPass = @pass and usuarioLog = @usuario and esBloq = 1 )	
				BEGIN
					select @esActivoPortal = esActivPortal from configuracion where idConfig = 'activo';
					select @result = usuarioLog from usuario where usuarioPass = @pass and usuarioLog = @usuario and esBloq = 1
					Select @esActivoProveedor = p.esBloq from usuario as u inner join proveedor as p on u.proveedor_idProveedor = p.idProveedor  where usuarioPass = @pass and usuarioLog = @usuario
					select @nombre = p.nombre from proveedor as p, usuario as u where u.proveedor_idProveedor = p.idProveedor and p.esBloq = 1 and u.esBloq = 1  
					select @resid = proveedor_idProveedor from usuario where usuarioLog = @usuario
					select @rfc = RFC from detProveedor where idOriginal = @resid
					select @idRol = rol_idRol from usuario where usuarioPass = @pass and usuarioLog = @usuario
					select @esActivoRol = esActivo from rol as r inner join usuario as u on r.idRol = u.rol_idRol where usuarioLog = @usuario
					select @diasCaducidad = caducidadPass from configuracion where idConfig = 'activo';
					select @fechaUltimoCambio = fechaUltimoCambio from controlSeguridad where usuario_idUsuario = @usuario 
					if exists(select usuarioLog from usuario where usuarioLog = @usuario and getdate() between fechaIni and fechaIFn)
					BEGIN
						set @esEnFecha = 1
					END
					ELSE
					BEGIN
						set @esEnFecha = 0
					END

					if(@diasCaducidad <> 0)
					BEGIN
						if(getdate() > (SELECT DATEADD([day],+(@diasCaducidad) , @fechaUltimoCambio)))
						BEGIN
							update controlSeguridad set esCambiarPassNext = 1 where usuario_idUsuario = @usuario;	

						END	
					END
					-- FIN cambiar pass por dias de caducidad
					select @cambiar = esCambiarPassNext from controlSeguridad where usuario_idUsuario = @usuario
					select @lifnr = lifnr from detProveedor where nombre = @nombre
				END
				ELSE
				BEGIN
					IF exists (Select usuarioLog from usuario  where usuarioPass = @pass and usuarioLog = @usuario and esBloq = 0)
					BEGIN
						--select @result = 'Exist'	
						IF(@usuario = (select top 1 usuarioLog from usuario where rol_idRol = 0))
						BEGIN
							select @result = 'Tiempo'	
							IF(getdate() > (SELECT DATEADD([minute],+((select tiempoBloqAdmin from configuracion where idConfig = 'activo')) , (select top 1 fecha from credencialFallida where usuario_idUsuario = @usuario order by fecha desc))) ) -- si la fecha actual  es mayor a la fecha de que se registro el error mas el tiempo de bloqueo 
								BEGIN
									update usuario set esBloq = 1 where usuarioLog = @usuario
									select @result = 'Admin desBloqueado'								
								END
								
						END
					END
					ELSE
					BEGIN
						select @result = 'log incorrecto'	
					END
				END
				
	END TRY
	BEGIN CATCH
		select @result = 'log fallido'
	END CATCH

	select @result as detalle , @resid as RFCProv, @idRol as idRol,@cambiar as esCambiar, @lifnr as lifnr, @esActivoPortal as esActivoPortal, @esActivoProveedor esActivoProveedor,@esActivoRol as esActivoRol , @esEnFecha as esEnFecha, @rfc as RFC
	--resultado, idProveedor_rfc, idRol, cambiar_contraseña, lifnr, portal_activo, proveedor_activo, rol_acivo, fecha_vigencia
GO
/****** Object:  StoredProcedure [dbo].[psdPGuardaCredFall]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdPGuardaCredFall]
    @usuario nvarchar(50), 
    @passw nvarchar(200)
	
AS 
    SET NOCOUNT ON;
	declare @maxintentos int;
	declare @intentosExistentes int;
	declare @intervalo int;
	declare @intentosEnTiempo int;
	declare @informe char(30);

	BEGIN TRY
			select @maxintentos = maxIntentosFail from configuracion where idConfig = 'activo'   
			select @intentosExistentes = COUNT( usuario_idUsuario) from credencialFallida where usuario_idUsuario = @usuario
			select @intervalo = intervalTiempo from configuracion where idConfig = 'activo' 

			IF(@intentosExistentes >= @maxintentos)
			BEGIN
				select @intentosEnTiempo = count(usuario_idUsuario) from credencialFallida 
				where fecha between (SELECT DATEADD([minute],-(@intervalo) , getdate())) and getdate() 
				and usuario_idUsuario = @usuario

				IF(@intentosEnTiempo >= @maxintentos)
				BEGIN
					--IF(@usuario <> 'Admin')
					--IF(@usuario <> (select top 1 usuarioLog from usuario where rol_idRol = 0))
					BEGIN
						update usuario set esBloq = 0 where usuarioLog = @usuario
						--set @informe = 'bloqueado';		
					END

					set @informe = 'bloqueado';	
					--ELSE
					--BEGIN
						
					--END
				END
				ELSE
				BEGIN
					update credencialFallida set fecha = getdate(), credencial = @passw where usuario_idUsuario = @usuario 
					and fecha = (select top 1  fecha from credencialFallida where usuario_idUsuario = @usuario order by fecha asc)
					set @informe = 'actualizado';
				END	
			END
			ELSE
				BEGIN
				insert into credencialFallida(usuario_idUsuario, fecha, credencial) values(@usuario, getdate(), @passw);
				set @informe = 'insertado';
				END
END TRY
	BEGIN CATCH
		set @informe = 'error';
	END CATCH
	select @informe as detalle, @maxintentos as maxintentos;
GO
/****** Object:  StoredProcedure [dbo].[psdPActualizaUsuario]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdPActualizaUsuario]
    @usuario nvarchar(50), 
    @nombre nvarchar(50),
	@apellidos nvarchar(50),
	@password nvarchar(200),
	@inicioVigencia datetime, 
	@finVigencia datetime,
	@esCambiarNext bit,
	@creadoPor int,
	@email char(100),
	@usuarioACambiar nvarchar(50),
	@rol nvarchar(50),
	@sqlUpdateSoc text

AS 
    SET NOCOUNT ON;
	declare @informe char(30);
	declare @idRol int;

	BEGIN TRY
		BEGIN TRAN  
			--update usuario set nombre = @nombre, apellidos = @apellidos, usuarioLog = @usuario, usuarioPass = @password,
			--email = @email, fechaIni = @inicioVigencia, fechaIFn = @finVigencia  where usuarioLog = @usuarioACambiar; 

			  update usuario set nombre = @nombre,  apellidos = @apellidos, usuarioPass = @password
			  where usuarioLog = @usuarioACambiar; 
			  update usuario set  usuarioLog = @usuario, email = @email, fechaIni = @inicioVigencia, fechaIFn = @finVigencia
			  where usuarioLog = @usuarioACambiar; 
			--where usuarioLog = @usuarioACambiar; 
			
			--update usuario set nombre = @nombre, apellidos = @apellidos , usuarioPass = @password,
			--email = @email, fechaIni = @inicioVigencia, fechaIFn = @finVigencia  where usuarioLog = @usuarioACambiar; 

			select @idRol = idRol from rol where nombre = @rol
			update usuario set rol_idRol = @idRol where usuarioLog = @usuario;

			update controlSeguridad set esCambiarPassNext = @esCambiarNext where usuario_idUsuario = @usuario

			exec(@sqlUpdateSoc)
			--IF @@ROWCOUNT = 1
			--set @informe = @@ROWCOUNT  
			set @informe = 'ok'
				
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		set @informe = 'error' 
	END CATCH
  select @informe as detalle
GO
/****** Object:  StoredProcedure [dbo].[psdPActualizaContrasena]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[psdPActualizaContrasena]
    @passw nvarchar(200), 
    @user nvarchar(50)
	
AS 
    SET NOCOUNT ON;
	declare @informe char(100);
	declare @maxintentos int;
	declare @intentosExistentes int;
	declare @numPassRecordad int;

	BEGIN TRY
			select @numPassRecordad =  numPassRecordar from configuracion where idConfig = 'activo' 
				IF(@passw in (select top(@numPassRecordad) credencial from credencialesUsadas where usuario_idUsuario = @user))
				BEGIN
					set @informe = 'Utilizada recientemente, <br/> debe utilizar otra contraseña';	
				END
				ELSE
					IF(@passw in (select top(@numPassRecordad) credencial from credencialesInaceptables ) )
					BEGIN
						set @informe = 'Esta utilizando una <br/> contraseña inaceptable';	
					END
					ELSE
					BEGIN
						update usuario set usuarioPass = @passw where usuarioLog = @user  
						update controlSeguridad set esCambiarPassNext  = 0, fechaUltimoCambio = GETDATE()  where usuario_idUsuario = @user      
						set @informe = @@ROWCOUNT
						IF((select count (fecha) from credencialesUsadas where usuario_idUsuario = @user) >= @numPassRecordad)
						BEGIN
							update credencialesUsadas set fecha = getdate(), credencial = @passw where usuario_idUsuario = @user 
							and fecha = (select top 1 fecha from credencialesUsadas where usuario_idUsuario = @user order by fecha asc)
							set @informe = 'actualizado';		
						END
						ELSE
						BEGIN
							insert into credencialesUsadas(usuario_idUsuario,fecha,credencial) values(@user,getdate(),@passw);	
							set @informe = 'actualizado';
						END
						
					END
	END TRY
	BEGIN CATCH
		set @informe = 'error';
	END CATCH
	select @informe as detalle;
GO
/****** Object:  StoredProcedure [dbo].[insertUsuario]    Script Date: 06/15/2016 14:45:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---::::::::::::::::::::::::::::::::::::::::::::::---
CREATE PROCEDURE [dbo].[insertUsuario]
    @usuario nvarchar(50), 
    @nombre nvarchar(50),
	@apellidos nvarchar(50),
	@password nvarchar(200),
	@inicioVigencia datetime, 
	@finVigencia datetime,
	@esCambiarNext bit,
	@proveedor char(20),
	@creadoPor int,
	@email char(100),
	@rol varchar(50),
	@sqlStringSoc text


AS 
    SET NOCOUNT ON;
	declare @informe char(30);
	declare @idRol int;
	declare @maxUsuarios int;
	declare @cantidadExixtenteProveedor int;
	
	BEGIN TRY
			select @maxUsuarios = maxUsuarios from configuracion where idConfig = 'activo';
			select @cantidadExixtenteProveedor = count(proveedor_idProveedor) from usuario where proveedor_idProveedor = @proveedor; 
			IF(@cantidadExixtenteProveedor < @maxUsuarios)
			BEGIN
				BEGIN TRAN
				insert into usuario(proveedor_idProveedor,nombre,apellidos,usuarioLog,usuarioPass,email,fechaCreacion,
				fechaIni,fechaIFn,_creadoPor, esBloq)
				values(@proveedor,@nombre, @apellidos, @usuario,@password,@email,GETDATE(),
				@inicioVigencia,@finVigencia,@creadoPor,1);
			
				insert into controlSeguridad(usuario_idUsuario,esCambiarPassNext,fechaUltimoCambio) 
				values(@usuario,@esCambiarNext, getdate());

				insert into credencialesUsadas(usuario_idUsuario, fecha, credencial, tipo) values(@usuario,getdate(),@password,'');
				
						select @idRol = idRol from rol where nombre = @rol
						update usuario set rol_idRol = @idRol where usuarioLog = @usuario;
						select @informe = @@ROWCOUNT
						exec(@sqlStringSoc)
				COMMIT TRAN
				set @informe = 'insertado' 
			END
			ELSE
			BEGIN
				set @informe = 'limite' 
			END
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		set @informe = 'error' 
		if exists(select usuarioLog from usuario where usuarioLog = @usuario)
			BEGIN
				set @informe = 'nombre existente'
			END
	END CATCH
  select @informe as detalle
GO
/****** Object:  ForeignKey [FK__controlSe__usuar__367C1819]    Script Date: 06/15/2016 14:45:11 ******/
ALTER TABLE [dbo].[controlSeguridad]  WITH CHECK ADD FOREIGN KEY([usuario_idUsuario])
REFERENCES [dbo].[usuario] ([usuarioLog])
GO
/****** Object:  ForeignKey [FK__credencia__usuar__37703C52]    Script Date: 06/15/2016 14:45:11 ******/
ALTER TABLE [dbo].[credencialesUsadas]  WITH CHECK ADD FOREIGN KEY([usuario_idUsuario])
REFERENCES [dbo].[usuario] ([usuarioLog])
GO
/****** Object:  ForeignKey [FK__credencia__usuar__3864608B]    Script Date: 06/15/2016 14:45:11 ******/
ALTER TABLE [dbo].[credencialFallida]  WITH CHECK ADD FOREIGN KEY([usuario_idUsuario])
REFERENCES [dbo].[usuario] ([usuarioLog])
GO
/****** Object:  ForeignKey [FK__detProvee__insta__164452B1]    Script Date: 06/15/2016 14:45:11 ******/
ALTER TABLE [dbo].[detProveedor]  WITH CHECK ADD FOREIGN KEY([instancia_idInstancia])
REFERENCES [dbo].[instancia] ([idInstancia])
GO
/****** Object:  ForeignKey [FK__detProvee__insta__395884C4]    Script Date: 06/15/2016 14:45:11 ******/
ALTER TABLE [dbo].[detProveedor]  WITH CHECK ADD FOREIGN KEY([instancia_idInstancia])
REFERENCES [dbo].[instancia] ([idInstancia])
GO
/****** Object:  ForeignKey [FK__detProvee__prove__15502E78]    Script Date: 06/15/2016 14:45:11 ******/
ALTER TABLE [dbo].[detProveedor]  WITH CHECK ADD FOREIGN KEY([proveedor_idProveedor])
REFERENCES [dbo].[proveedor] ([idProveedor])
GO
/****** Object:  ForeignKey [FK__detProvee__prove__3A4CA8FD]    Script Date: 06/15/2016 14:45:11 ******/
ALTER TABLE [dbo].[detProveedor]  WITH CHECK ADD FOREIGN KEY([proveedor_idProveedor])
REFERENCES [dbo].[proveedor] ([idProveedor])
GO
/****** Object:  ForeignKey [FK__DetRol__pantalla__34C8D9D1]    Script Date: 06/15/2016 14:45:11 ******/
ALTER TABLE [dbo].[DetRol]  WITH CHECK ADD FOREIGN KEY([pantalla_idPantalla])
REFERENCES [dbo].[Pantalla] ([idPantalla])
GO
/****** Object:  ForeignKey [FK__DetRol__pantalla__3B40CD36]    Script Date: 06/15/2016 14:45:11 ******/
ALTER TABLE [dbo].[DetRol]  WITH CHECK ADD FOREIGN KEY([pantalla_idPantalla])
REFERENCES [dbo].[Pantalla] ([idPantalla])
GO
/****** Object:  ForeignKey [FK__DetRol__rol_id_r__33D4B598]    Script Date: 06/15/2016 14:45:11 ******/
ALTER TABLE [dbo].[DetRol]  WITH CHECK ADD FOREIGN KEY([rol_id_rol])
REFERENCES [dbo].[rol] ([idRol])
GO
/****** Object:  ForeignKey [FK__DetRol__rol_id_r__3C34F16F]    Script Date: 06/15/2016 14:45:11 ******/
ALTER TABLE [dbo].[DetRol]  WITH CHECK ADD FOREIGN KEY([rol_id_rol])
REFERENCES [dbo].[rol] ([idRol])
GO
/****** Object:  ForeignKey [FK__GrupoNoti__grupo__5224328E]    Script Date: 06/15/2016 14:45:11 ******/
ALTER TABLE [dbo].[GrupoNoticia_Noticia]  WITH CHECK ADD FOREIGN KEY([grupoNoticia_IdGruponoticia])
REFERENCES [dbo].[grupoNoticia] ([idGrupoNoticia])
GO
/****** Object:  ForeignKey [FK__GrupoNoti__notic__531856C7]    Script Date: 06/15/2016 14:45:11 ******/
ALTER TABLE [dbo].[GrupoNoticia_Noticia]  WITH CHECK ADD FOREIGN KEY([noticia_idNoticia])
REFERENCES [dbo].[noticia] ([idNoticia])
GO
/****** Object:  ForeignKey [FK__GrupoNoti__grupo__4A8310C6]    Script Date: 06/15/2016 14:45:11 ******/
ALTER TABLE [dbo].[GrupoNoticia_proveedor]  WITH CHECK ADD FOREIGN KEY([grupoNoticia_idGruponoticia])
REFERENCES [dbo].[grupoNoticia] ([idGrupoNoticia])
GO
/****** Object:  ForeignKey [FK__GrupoNoti__prove__4B7734FF]    Script Date: 06/15/2016 14:45:11 ******/
ALTER TABLE [dbo].[GrupoNoticia_proveedor]  WITH CHECK ADD FOREIGN KEY([proveedor_idProveedor])
REFERENCES [dbo].[proveedor] ([idProveedor])
GO
/****** Object:  ForeignKey [FK__usuario__proveed__40F9A68C]    Script Date: 06/15/2016 14:45:11 ******/
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD FOREIGN KEY([proveedor_idProveedor])
REFERENCES [dbo].[proveedor] ([idProveedor])
GO
/****** Object:  ForeignKey [FK__usuario__rol_idR__41EDCAC5]    Script Date: 06/15/2016 14:45:11 ******/
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD FOREIGN KEY([rol_idRol])
REFERENCES [dbo].[rol] ([idRol])
GO
