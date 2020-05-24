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
	
	SELECT c.idCompra, CONCAT(p.primerNombreProveedor, ' ', p.primerApellidoProveedor) AS nombreProveedor, CONCAT(e.primerNombreEmpleado, ' ', e.primerApellidoEmpleado) AS nombreEmpleado, fechaCompra, horaCompra, SUM(dc.cantidadProductoComprado*dc.precioCompraUnidad) AS monto

	FROM dbo.Compra AS c
	INNER JOIN dbo.Proveedor p ON c.idProveedor = p.idProveedor
	INNER JOIN dbo.Usuario u ON c.idUsuario = u.idUsuario
	INNER JOIN dbo.Empleado e ON u.idEmpleado = e.idEmpleado
	INNER JOIN dbo.DetalleCompra dc ON c.idCompra = dc.idCompra
	WHERE c.estado = 1
	GROUP BY c.idCompra, p.primerNombreProveedor, p.primerApellidoProveedor, e.primerNombreEmpleado, e.primerApellidoEmpleado, fechaCompra, horaCompra
	
	COMMIT
GO


/*Seleccionar Compra By Id*/
IF OBJECT_ID('SeleccionarCompraById_e') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarCompraById_e
END
GO
CREATE PROCEDURE dbo.SeleccionarCompraById_e
		@idCompra [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idCompra, idProveedor, idUsuario, fechaCompra, horaCompra
	FROM dbo.Compra
	WHERE idCompra = @idCompra AND estado = 1

	COMMIT
GO



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

	DECLARE @idCompra AS INT

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

	SELECT SCOPE_IDENTITY()
	COMMIT
GO


IF OBJECT_ID('ActualizarCompra') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.ActualizarCompra
END
GO
CREATE PROCEDURE dbo.ActualizarCompra
	(
		@idCompra [int],
		@idProveedor [int],
		@idUsuario [int],
		@fechaCompra [date],
		@horaCompra [time](0)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Compra
		SET  idProveedor = @idProveedor, idUsuario = @idUsuario, fechaCompra = @fechaCompra, horaCompra = @horaCompra
		WHERE idCompra = @idCompra AND estado = 1
	COMMIT
GO



/*Eliminar Compra*/
IF OBJECT_ID('EliminarCompra') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.EliminarCompra
END
GO
CREATE PROCEDURE dbo.EliminarCompra
	(
		@idCompra [int]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Compra
		SET estado = 0
		WHERE idCompra = @idCompra
	COMMIT
GO
