IF OBJECT_ID('SeleccionarProductoById_e') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarProductoById_e
END
GO
CREATE PROCEDURE dbo.SeleccionarProductoById_e
		@idProducto [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idProducto, idCategoria, idMarca, nombreProducto, precio, descuento, descripcionProducto, imagenProducto
	FROM dbo.Producto
	WHERE idProducto = @idProducto AND estado = 1

	COMMIT
GO

/*SELECCIONAR PRODUCTOS*/
IF OBJECT_ID('SeleccionarProductos') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarProductos
END
GO
CREATE PROCEDURE dbo.SeleccionarProductos

AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idProducto, imagenProducto, nombreProducto, m.nombreMarca, c.nombreCategoria
	FROM dbo.Producto AS p
	INNER JOIN dbo.Marca m
	ON p.idMarca = m.idMarca
	INNER JOIN dbo.Categoria c
	ON p.idCategoria = c.idCategoria

	WHERE p.estado = 1

	COMMIT
GO


/*Seleccionar Productos By Id detalles*/
IF OBJECT_ID('SeleccionarProductoById_d') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarProductoById_d
END
GO
CREATE PROCEDURE dbo.SeleccionarProductoById_d
		@idProducto [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT p.idProducto, c.nombreCategoria, m.nombreMarca, p.nombreProducto, p.descripcionProducto, p.imagenProducto, p.precio
	FROM dbo.Producto AS p
	INNER JOIN dbo.Categoria c
	ON p.idCategoria = c.idCategoria
	INNER JOIN dbo.Marca m
	ON p.idMarca = m.idMarca

	WHERE p.idProducto = @idProducto AND p.estado = 1

	COMMIT
GO


/*Seleccionar Productos By Id*/
IF OBJECT_ID('SeleccionarProductoById') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarProductoById
END
GO
CREATE PROCEDURE dbo.SeleccionarProductoById
		@idProducto [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idProducto, idCategoria, idMarca, nombreProducto, precio, descuento, descripcionProducto, imagenProducto, estado
	FROM dbo.Producto
	WHERE idProducto = @idProducto AND estado = 1

	COMMIT
GO





/*INSERTAR PRODUCTOS*/
IF OBJECT_ID('InsertarProducto') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.InsertarProducto
END
GO
CREATE PROCEDURE dbo.InsertarProducto
	(
		@idCategoria [int],
		@idMarca [int],
		@nombreProducto [varchar](100),
		@precio [decimal](6, 2),
		@descuento [decimal](6, 2),
		@descripcionProducto [varchar](max),
		@imagenProducto [varbinary](max)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	INSERT INTO dbo.Producto
	(
		idCategoria, idMarca, nombreProducto, precio, descuento, descripcionProducto, imagenProducto
	)
	VALUES
	(
		@idCategoria,
		@idMarca,
		@nombreProducto,
		@precio,
		@descuento,
		@descripcionProducto,
		@imagenProducto
	)

	COMMIT
GO

/*Actualizar Producto*/
IF OBJECT_ID('ActualizarProducto') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.ActualizarProducto
END
GO
CREATE PROCEDURE dbo.ActualizarProducto
	(
		@idProducto [int],
		@idCategoria [int],
		@idMarca [int],
		@nombreProducto [varchar](100),
		@precio [decimal](6, 2),
		@descuento [decimal](6, 2),
		@descripcionProducto [varchar](max),
		@imagenProducto [varbinary](max)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Producto
		SET  idCategoria = @idCategoria, idMarca = @idMarca, nombreProducto = @nombreProducto, precio = @precio, descuento = @descuento, descripcionProducto = @descripcionProducto, imagenProducto = ISNULL (@imagenProducto, imagenProducto)
		WHERE idProducto = @idProducto
	COMMIT
GO

/*Eliminar Producto*/
IF OBJECT_ID('EliminarProducto') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.EliminarProducto
END
GO
CREATE PROCEDURE dbo.EliminarProducto
	(
		@idProducto [int]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Producto
		SET estado = 0
		WHERE idProducto = @idProducto
	COMMIT
GO


	