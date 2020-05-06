IF OBJECT_ID('SeleccionarDetalleCompra') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarDetalleCompra
END
GO
CREATE PROCEDURE dbo.SeleccionarDetalleCompra
		@idCompra [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT dc.idDetalleCompra, p.nombreProducto, dc.cantidadProductoComprado, dc.precioCompraUnidad, dc.precioVentaUnidad, dc.observaciones
	FROM DetalleCompra AS dc
	INNER JOIN dbo.Producto p
	ON dc.idProducto = p.idProducto
	WHERE dc.idCompra = @idCompra AND dc.estado = 1

	COMMIT
GO

SeleccionarDetalleCompra 4


IF OBJECT_ID('crud_DetalleCompraInsert') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.crud_DetalleCompraInsert
END
GO
CREATE PROCEDURE dbo.crud_DetalleCompraInsert
	(
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

	INSERT INTO dbo.DetalleCompra
	(
		idCompra, idProducto, cantidadProductoComprado, precioCompraUnidad, precioVentaUnidad, observaciones, estado
	)
	VALUES
	(
		@idCompra,
		@idProducto,
		@cantidadProductoComprado,
		@precioCompraUnidad,
		@precioVentaUnidad,
		@observaciones,
		@estado

	)
	SELECT idDetalleCompra, idCompra, idProducto, cantidadProductoComprado, precioCompraUnidad, precioVentaUnidad, observaciones, estado
	FROM dbo.DetalleCompra
	WHERE (idDetalleCompra = SCOPE_IDENTITY())

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
