/*SELECCIONAR MARCAS*/
IF OBJECT_ID('SeleccionarMarcas') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarMarcas
END
GO
CREATE PROCEDURE dbo.SeleccionarMarcas

AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idMarca, nombreMarca
	FROM dbo.Marca
	WHERE estado = 1
	
	COMMIT
GO

EXEC SeleccionarMarcas


/*INSERTAR MARCA*/
IF OBJECT_ID('InsertarMarca') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.InsertarMarca
END
GO
CREATE PROCEDURE dbo.InsertarMarca
	(
		@nombreMarca [varchar](50)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	INSERT INTO dbo.Marca
	(
		nombreMarca
	)
	VALUES
	(
		@nombreMarca
	)
	
	COMMIT
GO

EXEC InsertarMarca 'DELL'


/*Actualizar Marca*/
IF OBJECT_ID('ActualizarMarca') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.ActualizarMarca
END
GO
CREATE PROCEDURE dbo.ActualizarMarca
	(
		@idMarca [int],
		@nombreMarca [varchar](50)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Marca
		SET  nombreMarca = @nombreMarca
		WHERE idMarca = @idMarca
	COMMIT
GO

EXEC ActualizarMarca

/*Eliminar Marca*/
IF OBJECT_ID('EliminarMarca') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.EliminarMarca
END
GO
CREATE PROCEDURE dbo.EliminarMarca
	(
		@idMarca [int]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Marca
		SET estado = 0
		WHERE idMarca = @idMarca
	COMMIT
GO

EXEC EliminarMarca