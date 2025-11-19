IF OBJECT_ID('dbo.FS_Operations', 'U') IS NULL 
	CREATE TABLE [dbo].[FS_Operations] (
		[oper_id] int NOT NULL IDENTITY(1,1) ,
		[oper_product_code] varchar(8) COLLATE Latin1_General_CI_AI NULL ,
		[oper_name] varchar(100) COLLATE Latin1_General_CI_AI NULL ,
		[oper_mac_address] varchar(12) COLLATE Latin1_General_CI_AI NULL ,
		[oper_ip_address] varchar(15) COLLATE Latin1_General_CI_AI NULL ,
		[oper_datetime] datetime NULL ,
		[oper_params] varchar(2048) COLLATE Latin1_General_CI_AI NULL ,
		[oper_status] int NULL ,
		[oper_message] nvarchar(2048) COLLATE Latin1_General_CI_AI NULL ,
		PRIMARY KEY ([oper_id])
	)
	ON [PRIMARY]

IF OBJECT_ID('dbo.FS_updates', 'U') IS NULL 
	CREATE TABLE [dbo].[FS_updates] (
		[UPDATE_Id] int NOT NULL ,
		[UPDATE_EXTRANET_LastUpdate] datetime NULL ,
		[UPDATE_CDP_LastUpdate] datetime NULL ,
		[UPDATE_PLANIFICADOR_LastUpdate] datetime NULL ,
		[UPDATE_CONFIGURADOR_LastUpdate] datetime NULL,
		PRIMARY KEY ([UPDATE_Id])
	)
	ON [PRIMARY]

TRUNCATE TABLE FS_updates

INSERT INTO FS_Updates ( UPDATE_Id, UPDATE_EXTRANET_LastUpdate, UPDATE_CDP_LastUpdate, UPDATE_PLANIFICADOR_LastUpdate, UPDATE_CONFIGURADOR_LastUpdate ) 
VALUES ( 1, '1980-01-01', '1980-01-01', '1980-01-01', '1980-01-01' )
