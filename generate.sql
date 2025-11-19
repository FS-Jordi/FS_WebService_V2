IF OBJECT_ID('dbo.ARTEC_WorkerPermission', 'U') IS NOT NULL 
  DROP TABLE dbo.ARTEC_WorkerPermission;

IF OBJECT_ID('dbo.ARTEC_Worker', 'U') IS NOT NULL 
  DROP TABLE dbo.ARTEC_Worker;

IF OBJECT_ID('dbo.ARTEC_Terminal', 'U') IS NOT NULL 
  DROP TABLE dbo.ARTEC_Terminal;

IF OBJECT_ID('dbo.ARTEC_Sinopticos_Detalle', 'U') IS NOT NULL 
  DROP TABLE dbo.ARTEC_Sinopticos_Detalle;

IF OBJECT_ID('dbo.ARTEC_Sinopticos', 'U') IS NOT NULL 
  DROP TABLE dbo.ARTEC_Sinopticos;

IF OBJECT_ID('dbo.ARTEC_Shapes', 'U') IS NOT NULL 
  DROP TABLE dbo.ARTEC_Shapes;

IF OBJECT_ID('dbo.ARTEC_Permission', 'U') IS NOT NULL 
  DROP TABLE dbo.ARTEC_Permission;

IF OBJECT_ID('dbo.ARTEC_Logintype', 'U') IS NOT NULL 
  DROP TABLE dbo.ARTEC_Logintype;

IF OBJECT_ID('dbo.ARTEC_License_Detail', 'U') IS NOT NULL 
  DROP TABLE dbo.ARTEC_License_Detail;

IF OBJECT_ID('dbo.ARTEC_License', 'U') IS NOT NULL 
DROP TABLE dbo.ARTEC_License;


CREATE TABLE [dbo].[ARTEC_License] (
	[license_code] varchar(34) COLLATE Latin1_General_CI_AI NOT NULL ,
	[license_product_code] varchar(4) COLLATE Latin1_General_CI_AI NULL ,
	[license_product_name] varchar(255) COLLATE Latin1_General_CI_AI NULL ,
	[license_customer_code] varchar(4) COLLATE Latin1_General_CI_AI NULL ,
	[license_customer_name] varchar(255) COLLATE Latin1_General_CI_AI NULL ,
	[license_num_terminals] int NULL ,
	[license_valid_to] datetime NULL ,
PRIMARY KEY ([license_code])
)
ON [PRIMARY]


CREATE TABLE [dbo].[ARTEC_License_Detail] (
	[ld_license] varchar(34) COLLATE Latin1_General_CI_AI NOT NULL ,
	[ld_num_terminal] int NOT NULL ,
	[ld_mac_address] varchar(17) COLLATE Latin1_General_CI_AI NULL ,
	[ld_ip_address] varchar(19) COLLATE Latin1_General_CI_AI NULL ,
	[ld_expires] datetime NULL ,
	[ld_name] varchar(255) COLLATE Latin1_General_CI_AI NULL ,
PRIMARY KEY ([ld_license], [ld_num_terminal]),
CONSTRAINT [fk__license_detail__license] FOREIGN KEY ([ld_license]) REFERENCES [dbo].[ARTEC_License] ([license_code]) ON DELETE CASCADE ON UPDATE CASCADE
)
ON [PRIMARY]


CREATE TABLE [dbo].[ARTEC_Logintype] (
	[logintype_id] int NOT NULL ,
	[logintype_name] varchar(20) COLLATE Latin1_General_CI_AI NULL ,
	[logintype_auto] bit NULL DEFAULT ((0)) ,
PRIMARY KEY ([logintype_id])
)
ON [PRIMARY]


CREATE TABLE [dbo].[ARTEC_Permission] (
	[permission_id] int NOT NULL ,
	[permission_name] varchar(250) COLLATE Latin1_General_CI_AI NULL ,
	[permission_group] varchar(250) COLLATE Latin1_General_CI_AI NULL ,
	[permission_order] int NULL ,
	[permission_active] bit NULL DEFAULT ((1)) ,
PRIMARY KEY ([permission_id])
)
ON [PRIMARY]


INSERT INTO ARTEC_Permission VALUES ( 1, 'Ver órdenes de trabajo', 'OT', 1, 1 );
INSERT INTO ARTEC_Permission VALUES ( 2, 'Editar órdenes de trabajo', 'OT', 1, 1 );
INSERT INTO ARTEC_Permission VALUES ( 3, 'Crear órdenes de trabajo', 'OT', 1, 1 );
INSERT INTO ARTEC_Permission VALUES ( 4, 'Introducir datos producción', 'Producción', 1, 1 );
INSERT INTO ARTEC_Permission VALUES ( 5	, 'Ver datos producción', 'Producción', 1, 1 );

CREATE TABLE [dbo].[ARTEC_Shapes] (
	[shape_id] int NOT NULL ,
	[shape_name] varchar(25) COLLATE Latin1_General_CI_AI NULL ,
PRIMARY KEY ([shape_id])
)
ON [PRIMARY]


CREATE TABLE [dbo].[ARTEC_Sinopticos] (
	[sinoptico_id] int NOT NULL ,
	[CodigoEmpresa] smallint NULL ,
	[CentroTrabajo] varchar(10) COLLATE Latin1_General_CI_AI NULL ,
	[sinoptico_imagen] image NULL ,
	[sinoptico_descripcion] varchar(50) COLLATE Latin1_General_CI_AI NULL ,
PRIMARY KEY ([sinoptico_id])
)
ON [PRIMARY]


CREATE TABLE [dbo].[ARTEC_Sinopticos_Detalle] (
	[sinoptico_id] int NOT NULL ,
	[sinoptico_id_detalle] int NOT NULL ,
	[sinoptico_coord_x] float(53) NULL ,
	[sinoptico_coord_y] float(53) NULL ,
	[shape_id] int NULL ,
	[sinoptico_width] float(53) NULL ,
	[sinoptico_height] float(53) NULL ,
	[sinoptico_color] int NULL ,
	[sinoptico_seccion] varchar(10) COLLATE Latin1_General_CI_AI NULL ,
	[sinoptico_polyline_x_points] varchar(5000) COLLATE Latin1_General_CI_AI NULL ,
	[sinoptico_polyline_y_points] varchar(5000) COLLATE Latin1_General_CI_AI NULL ,
PRIMARY KEY ([sinoptico_id], [sinoptico_id_detalle]),
CONSTRAINT [fk_sinopticos_detalle] FOREIGN KEY ([sinoptico_id]) REFERENCES [dbo].[ARTEC_Sinopticos] ([sinoptico_id]) ON DELETE CASCADE ON UPDATE CASCADE
)


CREATE TABLE [dbo].[ARTEC_Terminal] (
	[terminal_mac_address] varchar(17) COLLATE Latin1_General_CI_AI NOT NULL ,
	[terminal_config_json] text COLLATE Latin1_General_CI_AI NULL ,
	[terminal_pcname] varchar(255) COLLATE Latin1_General_CI_AI NULL ,
	[terminal_ip] varchar(19) COLLATE Latin1_General_CI_AI NULL ,
	[terminal_name] varchar(255) COLLATE Latin1_General_CI_AI NULL ,
PRIMARY KEY ([terminal_mac_address])
)
ON [PRIMARY]
	TEXTIMAGE_ON [PRIMARY]


CREATE TABLE [dbo].[ARTEC_Worker] (
	[worker_idoperario_sage] uniqueidentifier NOT NULL ,
	[worker_codigooperario] int NOT NULL ,
	[worker_cardnumber] varchar(50) COLLATE Latin1_General_CI_AI NULL ,
	[worker_active] bit NULL ,
	[worker_username] varchar(255) COLLATE Latin1_General_CI_AI NULL ,
	[worker_password] varchar(255) COLLATE Latin1_General_CI_AI NULL ,
	[worker_superadmin] bit NULL ,
	[worker_onlyaccesscentre] bit NULL ,
PRIMARY KEY ([worker_idoperario_sage]),
CONSTRAINT [unq_codigooperario] UNIQUE ([worker_codigooperario] ASC)
)
ON [PRIMARY]


CREATE TABLE [dbo].[ARTEC_WorkerPermission] (
	[worker_codigooperario] int NOT NULL ,
	[permission_id] int NOT NULL ,
PRIMARY KEY ([worker_codigooperario], [permission_id]),
CONSTRAINT [fk_workerpermission] FOREIGN KEY ([worker_codigooperario]) REFERENCES [dbo].[ARTEC_Worker] ([worker_codigooperario]) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT [fk_workerpermission_permission] FOREIGN KEY ([permission_id]) REFERENCES [dbo].[ARTEC_Permission] ([permission_id]) ON DELETE CASCADE ON UPDATE CASCADE
)
ON [PRIMARY]
