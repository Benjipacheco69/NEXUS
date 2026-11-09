/*
  NEXUS - Esquema inicial SQL Server
  Basado en las clases y el estado de NEXUS H3/v2.0.
  Ejecutar en SQL Server Management Studio con permisos para crear una base de datos.
  Este script crea la estructura de persistencia propuesta; la aplicación todavía debe
  implementar los repositorios y las operaciones de guardado/carga.
*/

IF DB_ID(N'NEXUS_DB') IS NULL
BEGIN
    EXEC(N'CREATE DATABASE NEXUS_DB');
END
GO

USE NEXUS_DB;
GO

IF OBJECT_ID(N'dbo.Jugador', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Jugador
    (
        IdJugador INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Jugador PRIMARY KEY,
        Nombre NVARCHAR(50) NOT NULL,
        Edad INT NOT NULL,
        FechaRegistro DATETIME2(0) NOT NULL CONSTRAINT DF_Jugador_FechaRegistro DEFAULT SYSDATETIME(),
        CONSTRAINT CK_Jugador_Edad CHECK (Edad >= 18)
    );
END
GO

IF OBJECT_ID(N'dbo.Partida', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Partida
    (
        IdPartida INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Partida PRIMARY KEY,
        IdJugador INT NOT NULL,
        FechaInicio DATETIME2(0) NOT NULL CONSTRAINT DF_Partida_FechaInicio DEFAULT SYSDATETIME(),
        FechaGuardado DATETIME2(0) NULL,
        Estado VARCHAR(15) NOT NULL CONSTRAINT DF_Partida_Estado DEFAULT 'EN_CURSO',
        Energia INT NOT NULL,
        Estabilidad INT NOT NULL,
        Ataque INT NOT NULL CONSTRAINT DF_Partida_Ataque DEFAULT 10,
        Escudo INT NOT NULL CONSTRAINT DF_Partida_Escudo DEFAULT 0,
        Experiencia INT NOT NULL CONSTRAINT DF_Partida_Experiencia DEFAULT 0,
        ZonasExploradas INT NOT NULL CONSTRAINT DF_Partida_Zonas DEFAULT 0,
        PistasIris TINYINT NOT NULL CONSTRAINT DF_Partida_Pistas DEFAULT 0,
        FilaActual TINYINT NOT NULL CONSTRAINT DF_Partida_Fila DEFAULT 0,
        ColumnaActual TINYINT NOT NULL CONSTRAINT DF_Partida_Columna DEFAULT 0,
        CONSTRAINT FK_Partida_Jugador FOREIGN KEY (IdJugador) REFERENCES dbo.Jugador(IdJugador),
        CONSTRAINT CK_Partida_Estado CHECK (Estado IN ('EN_CURSO','COMPLETADA','DERROTADA','ABANDONADA')),
        CONSTRAINT CK_Partida_Energia CHECK (Energia BETWEEN 0 AND 100),
        CONSTRAINT CK_Partida_Estabilidad CHECK (Estabilidad BETWEEN 0 AND 100),
        CONSTRAINT CK_Partida_Ataque CHECK (Ataque >= 0),
        CONSTRAINT CK_Partida_Escudo CHECK (Escudo >= 0),
        CONSTRAINT CK_Partida_Experiencia CHECK (Experiencia >= 0),
        CONSTRAINT CK_Partida_Zonas CHECK (ZonasExploradas >= 0),
        CONSTRAINT CK_Partida_Pistas CHECK (PistasIris BETWEEN 0 AND 3),
        CONSTRAINT CK_Partida_Fila CHECK (FilaActual BETWEEN 0 AND 2),
        CONSTRAINT CK_Partida_Columna CHECK (ColumnaActual BETWEEN 0 AND 2)
    );
END
GO

IF OBJECT_ID(N'dbo.CeldaPartida', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.CeldaPartida
    (
        IdPartida INT NOT NULL,
        Fila TINYINT NOT NULL,
        Columna TINYINT NOT NULL,
        EstadoCelda CHAR(1) NOT NULL,
        CONSTRAINT PK_CeldaPartida PRIMARY KEY (IdPartida, Fila, Columna),
        CONSTRAINT FK_CeldaPartida_Partida FOREIGN KEY (IdPartida) REFERENCES dbo.Partida(IdPartida) ON DELETE CASCADE,
        CONSTRAINT CK_CeldaPartida_Fila CHECK (Fila BETWEEN 0 AND 2),
        CONSTRAINT CK_CeldaPartida_Columna CHECK (Columna BETWEEN 0 AND 2),
        CONSTRAINT CK_CeldaPartida_Estado CHECK (EstadoCelda IN ('E','X','-'))
    );
END
GO

IF OBJECT_ID(N'dbo.ObjetivoPartida', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ObjetivoPartida
    (
        IdPartida INT NOT NULL,
        NumeroObjetivo TINYINT NOT NULL,
        Descripcion NVARCHAR(150) NOT NULL,
        Cumplido BIT NOT NULL CONSTRAINT DF_ObjetivoPartida_Cumplido DEFAULT 0,
        CONSTRAINT PK_ObjetivoPartida PRIMARY KEY (IdPartida, NumeroObjetivo),
        CONSTRAINT FK_ObjetivoPartida_Partida FOREIGN KEY (IdPartida) REFERENCES dbo.Partida(IdPartida) ON DELETE CASCADE,
        CONSTRAINT CK_ObjetivoPartida_Numero CHECK (NumeroObjetivo BETWEEN 1 AND 4)
    );
END
GO

IF OBJECT_ID(N'dbo.ItemCatalogo', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ItemCatalogo
    (
        IdItem INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_ItemCatalogo PRIMARY KEY,
        Nombre NVARCHAR(80) NOT NULL,
        Tipo VARCHAR(20) NOT NULL,
        Valor INT NOT NULL,
        Descripcion NVARCHAR(150) NOT NULL,
        CONSTRAINT CK_ItemCatalogo_Tipo CHECK (Tipo IN ('Celula','Escudo','ModuloAtaque','Analizador')),
        CONSTRAINT CK_ItemCatalogo_Valor CHECK (Valor >= 0)
    );
END
GO

IF OBJECT_ID(N'dbo.InventarioPartida', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.InventarioPartida
    (
        IdInventario INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_InventarioPartida PRIMARY KEY,
        IdPartida INT NOT NULL,
        IdItem INT NOT NULL,
        ValorObjeto INT NOT NULL,
        CONSTRAINT FK_InventarioPartida_Partida FOREIGN KEY (IdPartida) REFERENCES dbo.Partida(IdPartida) ON DELETE CASCADE,
        CONSTRAINT FK_InventarioPartida_Item FOREIGN KEY (IdItem) REFERENCES dbo.ItemCatalogo(IdItem),
        CONSTRAINT CK_InventarioPartida_Valor CHECK (ValorObjeto >= 0)
    );
END
GO

IF OBJECT_ID(N'dbo.EncuentroPartida', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.EncuentroPartida
    (
        IdEncuentro INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_EncuentroPartida PRIMARY KEY,
        IdPartida INT NOT NULL,
        TipoEntidad VARCHAR(10) NOT NULL,
        NombreEntidad NVARCHAR(80) NOT NULL,
        EnergiaEntidad INT NOT NULL,
        AtaqueEntidad INT NOT NULL,
        DefensaActiva BIT NOT NULL CONSTRAINT DF_Encuentro_Defensa DEFAULT 0,
        EsGuardian BIT NOT NULL CONSTRAINT DF_Encuentro_Guardian DEFAULT 0,
        CONSTRAINT UQ_EncuentroPartida_Partida UNIQUE (IdPartida),
        CONSTRAINT FK_EncuentroPartida_Partida FOREIGN KEY (IdPartida) REFERENCES dbo.Partida(IdPartida) ON DELETE CASCADE,
        CONSTRAINT CK_EncuentroPartida_Tipo CHECK (TipoEntidad IN ('Enemigo','Robot')),
        CONSTRAINT CK_EncuentroPartida_Energia CHECK (EnergiaEntidad > 0),
        CONSTRAINT CK_EncuentroPartida_Ataque CHECK (AtaqueEntidad >= 0)
    );
END
GO

/* Catálogo inicial: se insertan solo los registros que todavía no existan. */
IF NOT EXISTS (SELECT 1 FROM dbo.ItemCatalogo WHERE Nombre = N'Célula de energía')
    INSERT INTO dbo.ItemCatalogo (Nombre, Tipo, Valor, Descripcion)
    VALUES (N'Célula de energía', 'Celula', 25, N'Recupera hasta 25 puntos de energía.');

IF NOT EXISTS (SELECT 1 FROM dbo.ItemCatalogo WHERE Nombre = N'Escudo')
    INSERT INTO dbo.ItemCatalogo (Nombre, Tipo, Valor, Descripcion)
    VALUES (N'Escudo', 'Escudo', 20, N'Añade 20 puntos de protección.');

IF NOT EXISTS (SELECT 1 FROM dbo.ItemCatalogo WHERE Nombre = N'Módulo de ataque')
    INSERT INTO dbo.ItemCatalogo (Nombre, Tipo, Valor, Descripcion)
    VALUES (N'Módulo de ataque', 'ModuloAtaque', 5, N'Aumenta el ataque en 5 puntos.');

IF NOT EXISTS (SELECT 1 FROM dbo.ItemCatalogo WHERE Nombre = N'Analizador')
    INSERT INTO dbo.ItemCatalogo (Nombre, Tipo, Valor, Descripcion)
    VALUES (N'Analizador', 'Analizador', 0, N'Permite consultar información de entidades.');

IF NOT EXISTS (SELECT 1 FROM dbo.ItemCatalogo WHERE Nombre = N'Módulo desconocido')
    INSERT INTO dbo.ItemCatalogo (Nombre, Tipo, Valor, Descripcion)
    VALUES (N'Módulo desconocido', 'ModuloAtaque', 10, N'Recompensa de la misión principal; aumenta el ataque en 10 puntos.');
GO

/* Índice para listar rápidamente partidas de un jugador por fecha. */
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_Partida_Jugador_Fecha' AND object_id = OBJECT_ID(N'dbo.Partida'))
BEGIN
    CREATE INDEX IX_Partida_Jugador_Fecha
        ON dbo.Partida (IdJugador, FechaInicio DESC);
END
GO

/*
  Importante para la implementación:
  - Crear exactamente 9 filas en CeldaPartida y 4 en ObjetivoPartida al iniciar una partida.
  - La capacidad máxima de 8 objetos se valida en la lógica de aplicación dentro de una transacción.
  - Guardar/actualizar Partida, celdas, objetivos, inventario y encuentro en una sola transacción.
  - Al finalizar un encuentro, eliminar su fila de EncuentroPartida.
*/
