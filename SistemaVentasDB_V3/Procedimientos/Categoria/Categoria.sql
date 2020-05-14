/*SELECCIONAR CATEGORIAS*/
IF OBJECT_ID('SeleccionarCategorias') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarCategorias
END
GO
CREATE PROCEDURE dbo.SeleccionarCategorias

AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idCategoria, nombreCategoria
	FROM dbo.Categoria
	WHERE estado = 1

	COMMIT
GO

EXEC SeleccionarCategorias 


/*Seleccionar Categoria By ID*/
IF OBJECT_ID('SeleccionarCategoriaById') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarCategoriaById
END
GO
CREATE PROCEDURE dbo.SeleccionarCategoriaById
		@idCategoria [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idCategoria, nombreCategoria, estado
	FROM dbo.Categoria
	WHERE idCategoria = @idCategoria AND estado = 1

	COMMIT
GO

/*INSERTAR CATEGORIA*/
IF OBJECT_ID('InsertarCategoria') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.InsertarCategoria
END
GO
CREATE PROCEDURE dbo.InsertarCategoria
	(
		@nombreCategoria [varchar](50)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	INSERT INTO dbo.Categoria
	(
		nombreCategoria
	)
	VALUES
	(
		@nombreCategoria

	)
	COMMIT
GO

EXEC InsertarCategoria 'Monitores'


/*Actualizar Categoria*/
IF OBJECT_ID('ActualizarCategoria') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.ActualizarCategoria
END
GO
CREATE PROCEDURE dbo.ActualizarCategoria
	(
		@idCategoria [int],
		@nombreCategoria [varchar](50)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Categoria
		SET  nombreCategoria = @nombreCategoria
		WHERE idCategoria = @idCategoria
	COMMIT
GO

EXEC ActualizarCategoria



/*Eliminar Categoria*/
IF OBJECT_ID('EliminarCategoria') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.EliminarCategoria
END
GO
CREATE PROCEDURE dbo.EliminarCategoria
	(
		@idCategoria [int]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Categoria
		SET  estado = 0
		WHERE idCategoria = @idCategoria
	COMMIT
GO

EXEC EliminarCategoria