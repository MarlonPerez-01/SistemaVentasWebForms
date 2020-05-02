IF OBJECT_ID('crud_DetalleCompraSelect') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.crud_DetalleCompraSelect
END
GO
CREATE PROCEDURE dbo.crud_DetalleCompraSelect
		@idDetalleCompra [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idDetalleCompra, idCompra, idProducto, cantidadProductoComprado, precioCompraUnidad, precioVentaUnidad, observaciones, estado
	FROM dbo.DetalleCompra
	WHERE idDetalleCompra = @idDetalleCompra

	COMMIT
GO

SELECT c.* FROM dbo.Compra c



IF OBJECT_ID('InsertarDetalleCompra') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.InsertarDetalleCompra
END
GO
CREATE PROCEDURE dbo.InsertarDetalleCompra
	(
		@idCompra [int],
		@idProducto [int],
		@cantidadProductoComprado [int],
		@precioCompraUnidad [decimal](6, 2),
		@precioVentaUnidad [decimal](6, 2),
		@observaciones [varchar](100)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	INSERT INTO dbo.DetalleCompra
	(
		idCompra, idProducto, cantidadProductoComprado, precioCompraUnidad, precioVentaUnidad, observaciones
	)
	VALUES
	(
		@idCompra,
		@idProducto,
		@cantidadProductoComprado,
		@precioCompraUnidad,
		@precioVentaUnidad,
		@observaciones
	)
	COMMIT
GO



InsertarDetalleCompra 4, 2, 5, 50.00, 70.00, 'ninguna'
InsertarDetalleCompra 5, 2, 5, 50.00, 70.00, 'ninguna'

SELECT c.* FROM dbo.Compra c
SELECT dc.* FROM dbo.DetalleCompra dc





/*SELECCIONAR PRODUCTOS*/
IF OBJECT_ID('SeleccionarProductosById') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarProductosById
END
GO
CREATE PROCEDURE dbo.SeleccionarProductosById

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

SeleccionarProductosById 

SELECT dc.* FROM dbo.DetalleCompra dc



IF OBJECT_ID('crud_ProvisionInsert') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.crud_ProvisionInsert
END
GO
CREATE PROCEDURE dbo.crud_ProvisionInsert
	(
		@idProducto [int],
		@cantidadProductoDisponible [int],
		@cantidadProductoVendido [int],
		@estado [bit]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	INSERT INTO dbo.Provision
	(
		idProducto, cantidadProductoDisponible, cantidadProductoVendido, estado
	)
	VALUES
	(
		@idProducto,
		@cantidadProductoDisponible,
		@cantidadProductoVendido,
		@estado
	)
	
	COMMIT
GO





IF OBJECT_ID('crud_DetalleCompraUpdate') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.crud_DetalleCompraUpdate
END
GO
CREATE PROCEDURE dbo.crud_DetalleCompraUpdate
	(
		@idDetalleCompra [int],
		@idCompra [int],
		@idProducto [int],
		@cantidadProductoComprado [int],
		@precioCompraUnidad [decimal](6, 2),
		@precioVentaUnidad [decimal](6, 2),
		@observaciones [varchar](100),
		@estado [bit]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.DetalleCompra
		SET  idCompra = @idCompra, idProducto = @idProducto, cantidadProductoComprado = @cantidadProductoComprado, precioCompraUnidad = @precioCompraUnidad, precioVentaUnidad = @precioVentaUnidad, observaciones = @observaciones, estado = @estado
		WHERE (idDetalleCompra = @idDetalleCompra OR @idDetalleCompra IS NULL)
	COMMIT
GO
IF OBJECT_ID('crud_DetalleCompraDelete') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.crud_DetalleCompraDelete
END
GO
CREATE PROCEDURE dbo.crud_DetalleCompraDelete
		@idDetalleCompra [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		DELETE FROM dbo.DetalleCompra
		WHERE (idDetalleCompra = @idDetalleCompra OR @idDetalleCompra IS NULL)
	COMMIT
GO
