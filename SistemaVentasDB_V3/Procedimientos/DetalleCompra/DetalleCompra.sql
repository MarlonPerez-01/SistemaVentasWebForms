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

	SELECT dc.idCompra, dc.idDetalleCompra, p.nombreProducto, dc.cantidadProductoComprado, dc.precioCompraUnidad, dc.precioVentaUnidad, dc.observaciones
	FROM DetalleCompra AS dc
	INNER JOIN dbo.Producto p
	ON dc.idProducto = p.idProducto
	WHERE dc.idCompra = @idCompra AND dc.estado = 1

	COMMIT
GO

SeleccionarDetalleCompra 53


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

InsertarDetalleCompra 6, 2, 20, 130, 160, null
SELECT c.* FROM dbo.Compra c
SELECT dc.* FROM dbo.DetalleCompra dc

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
