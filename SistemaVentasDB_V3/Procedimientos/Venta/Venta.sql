/*SELECCIONAR VENTAS*/
IF OBJECT_ID('SeleccionarVentas') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarVentas
END
GO
CREATE PROCEDURE dbo.SeleccionarVentas
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idVenta, c.primerNombreCliente, c.primerApellidoCliente, e.primerNombreEmpleado, e.primerApellidoEmpleado, fechaVenta, horaVenta, SUM((dv.cantidadProducto*dv.idProducto)-(dv.cantidadProducto*dv.descuentoProducto)) AS monto
	FROM dbo.Venta AS v
	INNER JOIN dbo.Empleado e
	ON v.idEmpleado = e.idEmpleado
	INNER JOIN dbo.Cliente c
	ON v.idCliente = c.idCliente
	INNER JOIN dbo.DetalleVenta dv
	ON v.idDetalleVenta = dv.idDetalleVenta
	INNER JOIN dbo.DetalleCompra dc
	ON dc.idProducto = dv.idProducto

	WHERE v.estado = 1
	GROUP BY idVenta, c.primerNombreCliente, c.primerApellidoCliente, e.primerNombreEmpleado, e.primerApellidoEmpleado, fechaVenta, horaVenta
	
	COMMIT
GO

EXEC SeleccionarVentas

EXEC SeleccionarClientes

/*INSERTAR VENTA*/
IF OBJECT_ID('InsertarVenta') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.InsertarVenta
END
GO
CREATE PROCEDURE dbo.InsertarVenta
	(
		@idDetalleVenta [int],
		@idCliente [int],
		@idEmpleado [int],
		@fechaVenta [date],
		@horaVenta [time](0)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	INSERT INTO dbo.Venta
	(
		idDetalleVenta, idCliente, idEmpleado, fechaVenta, horaVenta
	)
	VALUES
	(
		@idDetalleVenta,
		@idCliente,
		@idEmpleado,
		@fechaVenta,
		@horaVenta
	)
	
	COMMIT
GO

EXEC InsertarVenta ''


/*Actualizar Venta*/

IF OBJECT_ID('ActualizarVenta') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.ActualizarVenta
END
GO
CREATE PROCEDURE dbo.ActualizarVenta
	(
		@idVenta [int],
		--@idDetalleVenta [int],
		@idCliente [int],
		@idEmpleado [int],
		@fechaVenta [date],
		@horaVenta [time](0)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Venta
		SET idCliente = @idCliente, idEmpleado = @idEmpleado, fechaVenta = @fechaVenta, horaVenta = @horaVenta
		WHERE idVenta = @idVenta
	COMMIT
GO

EXEC ActualizarVenta



/*Eliminar Venta*/
IF OBJECT_ID('EliminarVenta') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.EliminarVenta
END
GO
CREATE PROCEDURE dbo.EliminarVenta
	(
		@idVenta [int]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Venta
		SET estado = 0
		WHERE idVenta = @idVenta
	COMMIT
GO

EXEC EliminarVenta

SeleccionarClientes