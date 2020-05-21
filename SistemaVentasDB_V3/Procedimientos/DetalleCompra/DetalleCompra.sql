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

	SELECT dc.idCompra, dc.idDetalleCompra, p.nombreProducto, dc.cantidadProductoComprado, dc.precioCompraUnidad
	FROM DetalleCompra AS dc
	INNER JOIN dbo.Producto p
	ON dc.idProducto = p.idProducto
	WHERE dc.idCompra = @idCompra AND dc.estado = 1

	COMMIT
GO




IF OBJECT_ID('SeleccionarDetalleCompra_e') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarDetalleCompra_e
END
GO
CREATE PROCEDURE dbo.SeleccionarDetalleCompra_e
		@idDetalleCompra [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idDetalleCompra, idProducto, cantidadProductoComprado, precioCompraUnidad
	FROM DetalleCompra
	WHERE idDetalleCompra = @idDetalleCompra AND estado = 1

	COMMIT
GO


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
		@precioCompraUnidad [decimal](6, 2)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	INSERT INTO dbo.DetalleCompra
	(
		idCompra, idProducto, cantidadProductoComprado, precioCompraUnidad
	)
	VALUES
	(
		@idCompra,
		@idProducto,
		@cantidadProductoComprado,
		@precioCompraUnidad
	)
	COMMIT
GO
