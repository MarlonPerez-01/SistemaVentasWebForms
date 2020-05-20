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
	
	SELECT TOP 1 dv.idVenta, CONCAT(c.primerNombreCliente, c.primerApellidoCliente) AS nombreCliente, CONCAT(e.primerNombreEmpleado, e.primerApellidoEmpleado) AS nombreEmpleado, v.fechaVenta, v.horaVenta, dc.precioVentaUnidad, SUM(dv.cantidadProducto*dc.precioVentaUnidad) AS monto
	FROM dbo.Venta v
	INNER JOIN dbo.Cliente c ON v.idCliente = c.idCliente
	INNER JOIN dbo.Empleado e ON v.idEmpleado = e.idEmpleado
	INNER JOIN dbo.DetalleVenta dv ON v.idVenta = dv.idVenta
	INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto
	INNER JOIN dbo.DetalleCompra dc ON p.idProducto = dc.idProducto

	WHERE v.estado = 1
	GROUP BY dv.idVenta, c.primerNombreCliente, c.primerApellidoCliente, e.primerNombreEmpleado, e.primerApellidoEmpleado, fechaVenta, horaVenta, dc.precioVentaUnidad
	
	COMMIT
GO


SELECT TOP 1 dv.idVenta, CONCAT(c.primerNombreCliente, c.primerApellidoCliente) AS nombreCliente, CONCAT(e.primerNombreEmpleado, e.primerApellidoEmpleado) AS nombreEmpleado, v.fechaVenta, v.horaVenta, dc.precioVentaUnidad, SUM(dv.cantidadProducto*dc.precioVentaUnidad) AS monto
	FROM dbo.Venta v
	INNER JOIN dbo.Cliente c ON v.idCliente = c.idCliente
	INNER JOIN dbo.Empleado e ON v.idEmpleado = e.idEmpleado
	INNER JOIN dbo.DetalleVenta dv ON v.idVenta = dv.idVenta
	INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto
	INNER JOIN dbo.DetalleCompra dc ON p.idProducto = dc.idProducto

	WHERE v.estado = 1
	GROUP BY dv.idVenta, c.primerNombreCliente, c.primerApellidoCliente, e.primerNombreEmpleado, e.primerApellidoEmpleado, fechaVenta, horaVenta, dc.precioVentaUnidad




SELECT dv.idVenta, CONCAT(c.primerNombreCliente, c.primerApellidoCliente) AS nombreCliente, CONCAT(e.primerNombreEmpleado, e.primerApellidoEmpleado) AS nombreEmpleado, v.fechaVenta, v.horaVenta, dc.precioVentaUnidad, SUM(dv.cantidadProducto*dc.precioVentaUnidad) AS monto
	FROM dbo.Venta v
	INNER JOIN dbo.Cliente c ON v.idCliente = c.idCliente
	INNER JOIN dbo.Empleado e ON v.idEmpleado = e.idEmpleado
	INNER JOIN dbo.DetalleVenta dv ON v.idVenta = dv.idVenta
	INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto
	INNER JOIN dbo.DetalleCompra dc ON p.idProducto = dc.idProducto

	WHERE v.estado = 1
	GROUP BY dv.idVenta, c.primerNombreCliente, c.primerApellidoCliente, e.primerNombreEmpleado, e.primerApellidoEmpleado, fechaVenta, horaVenta, dc.precioVentaUnidad






SeleccionarVentas
SELECT * FROM dbo.Cliente c WHERE c.estado = 1

SELECT v.* FROM dbo.Venta v
SELECT dv.* FROM dbo.DetalleVenta dv
go
SeleccionarVentas

SELECT dv.idDetalleVenta, dv.idProducto, dv.cantidadProducto, dv.descuentoProducto, SUM(dv.cantidadProducto * dc.precioVentaUnidad) AS Monto
FROM dbo.DetalleVenta dv
INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto
INNER JOIN dbo.DetalleCompra dc ON p.idProducto = dc.idProducto

GROUP BY dv.idVenta, dv.idDetalleVenta, dv.idProducto, dv.cantidadProducto, dv.descuentoProducto, dv.estado

SELECT * FROM dbo.Producto p
INNER JOIN dbo.DetalleCompra dc ON p.idProducto = dc.idProducto

	
	SELECT v.idVenta, CONCAT(c.primerNombreCliente, ' ', c.primerApellidoCliente) AS nombreCliente, CONCAT(e.primerNombreEmpleado, e.primerApellidoEmpleado) AS nombreEmpleado, v.fechaVenta, v.horaVenta, SUM(dv.cantidadProducto*p.precio) AS Monto
	FROM dbo.Venta v
	INNER JOIN dbo.Cliente c ON v.idCliente = c.idCliente
	INNER JOIN dbo.Empleado e ON v.idEmpleado = e.idEmpleado
	INNER JOIN dbo.DetalleVenta dv ON v.idVenta = dv.idVenta
	INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto

	WHERE v.estado = 1 AND dv.estado = 1
	GROUP BY v.idVenta, c.primerNombreCliente, c.primerApellidoCliente, e.primerNombreEmpleado, e.primerApellidoEmpleado, fechaVenta, horaVenta
	

	SELECT * FROM dbo.DetalleVenta dv
	SELECT v.* FROM dbo.Venta v
	SELECT * FROM dbo.Producto p


	SELECT v.* FROM dbo.Venta v


	InsertarVenta 3, 4, '20190105', '1200'


	


	USE [SistemaVentasDB2]
GO

INSERT INTO [dbo].[DetalleVenta]
           ([idVenta]
           ,[idProducto]
           ,[cantidadProducto])
     VALUES
           (
           1
           ,2
           ,10)
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
IF OBJECT_ID('crud_VentaDelete') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.crud_VentaDelete
END
GO
CREATE PROCEDURE dbo.crud_VentaDelete
		@idVenta [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		DELETE FROM dbo.Venta
		WHERE (idVenta = @idVenta OR @idVenta IS NULL)
	COMMIT
GO
