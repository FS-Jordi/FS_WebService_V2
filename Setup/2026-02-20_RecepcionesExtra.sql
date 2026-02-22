-- Taula per emmagatzemar informació extra de les línies de recepció (estat i comentaris)
IF OBJECT_ID('dbo.FS_SGA_Recepciones_Lin_Info', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[FS_SGA_Recepciones_Lin_Info] (
        [RecepcionIdLinea] INT NOT NULL,
        [EstadoRecep] INT DEFAULT 0,
        [Comentarios] NVARCHAR(MAX) NULL,
        PRIMARY KEY ([RecepcionIdLinea])
    );
END

-- Taula per emmagatzemar les fotografies vinculades a les línies de recepció
IF OBJECT_ID('dbo.FS_SGA_Recepciones_Lin_Fotos', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[FS_SGA_Recepciones_Lin_Fotos] (
        [IdFoto] INT IDENTITY(1,1) NOT NULL,
        [RecepcionIdLinea] INT NOT NULL,
        [NombreFoto] NVARCHAR(255) NULL,
        [DataFotoBase64] NVARCHAR(MAX) NULL, -- Guardem en Base64 per simplicitat en aquest entorn, o podria ser una ruta
        [Fecha] DATETIME DEFAULT GETDATE(),
        PRIMARY KEY ([IdFoto])
    );
    
    CREATE INDEX IX_FS_SGA_Recepciones_Lin_Fotos_Linea ON [dbo].[FS_SGA_Recepciones_Lin_Fotos] ([RecepcionIdLinea]);
END
