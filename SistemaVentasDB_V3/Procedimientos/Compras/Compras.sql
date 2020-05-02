/*SELECCIONAR COMPRAS*/
IF OBJECT_ID('SeleccionarCompras') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarCompras
END
GO
CREATE PROCEDURE dbo.SeleccionarCompras
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
	
	SELECT c.idCompra, p.primerNombreProveedor, p.primerApellidoProveedor, e.primerNombreEmpleado, e.primerApellidoEmpleado, fechaCompra, horaCompra, SUM(dc.cantidadProductoComprado*dc.precioCompraUnidad) AS monto

	FROM dbo.Compra AS c
	INNER JOIN dbo.Proveedor p
	ON c.idProveedor = p.idProveedor
	INNER JOIN dbo.Usuario u
	ON c.idUsuario = u.idUsuario
	INNER JOIN dbo.Empleado e
	ON u.idEmpleado = e.idEmpleado
	INNER JOIN dbo.DetalleCompra dc
	ON c.idCompra = dc.idCompra
	GROUP BY c.idCompra, p.primerNombreProveedor, p.primerApellidoProveedor, e.primerNombreEmpleado, e.primerApellidoEmpleado, fechaCompra, horaCompra
	COMMIT
GO

EXEC SeleccionarCompras



/*INSERTAR COMPRAS*/
IF OBJECT_ID('InsertarCompra') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.InsertarCompra
END
GO
CREATE PROCEDURE dbo.InsertarCompra
	(
		@idProveedor [int],
		@idUsuario [int],
		@fechaCompra [date],
		@horaCompra [time](0)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	INSERT INTO dbo.Compra
	(
		idProveedor, idUsuario, fechaCompra, horaCompra
	)
	VALUES
	(
		@idProveedor,
		@idUsuario,
		@fechaCompra,
		@horaCompra
	)
	
	COMMIT
GO



EXEC InsertarCompras 2, 13, '2011/12/1', '12:00'


IF OBJECT_ID('crud_CompraUpdate') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.crud_CompraUpdate
END
GO
CREATE PROCEDURE dbo.crud_CompraUpdate
	(
		@idCompra [int],
		@idProveedor [int],
		@idUsuario [int],
		@fechaCompra [date],
		@horaCompra [time](0),
		@estado [bit]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Compra
		SET  idProveedor = @idProveedor, idUsuario = @idUsuario, fechaCompra = @fechaCompra, horaCompra = @horaCompra, estado = @estado
		WHERE (idCompra = @idCompra OR @idCompra IS NULL)
	COMMIT
GO
IF OBJECT_ID('crud_CompraDelete') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.crud_CompraDelete
END
GO
CREATE PROCEDURE dbo.crud_CompraDelete
		@idCompra [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		DELETE FROM dbo.Compra
		WHERE (idCompra = @idCompra OR @idCompra IS NULL)
	COMMIT
GO
