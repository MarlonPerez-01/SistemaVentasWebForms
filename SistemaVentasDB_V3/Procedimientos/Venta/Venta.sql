/*SELECCIONAR VENTAS*/
IF OBJECT_ID('SeleccionarUltimaVenta') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarUltimaVenta
END
GO
CREATE PROCEDURE dbo.SeleccionarUltimaVenta
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
	
	SELECT TOP 1 dv.idVenta, CONCAT(c.primerNombreCliente, c.primerApellidoCliente) AS nombreCliente, CONCAT(e.primerNombreEmpleado, e.primerApellidoEmpleado) AS nombreEmpleado, v.fechaVenta, v.horaVenta, SUM(dv.cantidadProducto*p.precio) AS monto
	FROM dbo.Venta v
	INNER JOIN dbo.Cliente c ON v.idCliente = c.idCliente
	INNER JOIN dbo.Empleado e ON v.idEmpleado = e.idEmpleado
	INNER JOIN dbo.DetalleVenta dv ON v.idVenta = dv.idVenta
	INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto

	WHERE v.estado = 1
	GROUP BY dv.idVenta, c.primerNombreCliente, c.primerApellidoCliente, e.primerNombreEmpleado, e.primerApellidoEmpleado, fechaVenta, horaVenta
	
	COMMIT
GO



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
	
	SELECT v.idVenta, CONCAT(c.primerNombreCliente, ' ', c.primerApellidoCliente) AS nombreCliente, CONCAT(e.primerNombreEmpleado, e.primerApellidoEmpleado) AS nombreEmpleado, v.fechaVenta, v.horaVenta, SUM(dv.cantidadProducto*p.precio) AS Monto
	FROM dbo.Venta v
	INNER JOIN dbo.Cliente c ON v.idCliente = c.idCliente
	INNER JOIN dbo.Empleado e ON v.idEmpleado = e.idEmpleado
	INNER JOIN dbo.DetalleVenta dv ON v.idVenta = dv.idVenta
	INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto

	WHERE v.estado = 1 AND dv.estado = 1
	GROUP BY v.idVenta, c.primerNombreCliente, c.primerApellidoCliente, e.primerNombreEmpleado, e.primerApellidoEmpleado, fechaVenta, horaVenta
	
	COMMIT
GO


IF OBJECT_ID('SeleccionarVentasById_e') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarVentasById_e
END
GO
CREATE PROCEDURE dbo.SeleccionarVentasById_e
		@idVenta [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idVenta, idCliente, idEmpleado, fechaVenta, horaVenta
	FROM dbo.Venta
	WHERE idVenta = @idVenta AND estado = 1

	COMMIT
GO



IF OBJECT_ID('SeleccionarDetalleVenta') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarDetalleVenta
END
GO
CREATE PROCEDURE dbo.SeleccionarDetalleVenta
		@idVenta [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT dv.idDetalleVenta, dv.idVenta, p.nombreProducto, dv.cantidadProducto, p.precio
	FROM dbo.DetalleVenta AS dv
	INNER JOIN dbo.Producto p ON
	dv.idProducto = p.idProducto

	WHERE dv.idVenta = @idVenta AND dv.estado = 1

	COMMIT
GO




IF OBJECT_ID('InsertarVenta') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.InsertarVenta
END
GO
CREATE PROCEDURE dbo.InsertarVenta
	(
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
		idCliente, idEmpleado, fechaVenta, horaVenta
	)
	VALUES
	(
		@idCliente,
		@idEmpleado,
		@fechaVenta,
		@horaVenta
	)
	
	COMMIT
GO




IF OBJECT_ID('crud_VentaUpdate') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.crud_VentaUpdate
END
GO
CREATE PROCEDURE dbo.crud_VentaUpdate
	(
		@idVenta [int],
		@idCliente [int],
		@idEmpleado [int],
		@fechaVenta [date],
		@horaVenta [time](0),
		@estado [bit]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Venta
		SET  idCliente = @idCliente, idEmpleado = @idEmpleado, fechaVenta = @fechaVenta, horaVenta = @horaVenta, estado = @estado
		WHERE (idVenta = @idVenta OR @idVenta IS NULL)
	COMMIT
GO