/*SELECCIONAR COMPRAS*/
IF OBJECT_ID('SeleccionarUltimaCompra') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarUltimaCompra
END
GO
CREATE PROCEDURE dbo.SeleccionarUltimaCompra
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
	
	SELECT TOP 1 c.idCompra, CONCAT(p.primerNombreProveedor, ' ', p.primerApellidoProveedor) AS nombreProveedor, CONCAT(e.primerNombreEmpleado, ' ', e.primerApellidoEmpleado) AS nombreEmpleado, fechaCompra, horaCompra

	FROM dbo.Compra AS c
	INNER JOIN dbo.Proveedor p
	ON c.idProveedor = p.idProveedor
	INNER JOIN dbo.Usuario u
	ON c.idUsuario = u.idUsuario
	INNER JOIN dbo.Empleado e
	ON u.idEmpleado = e.idEmpleado
	WHERE c.estado = 1
	GROUP BY c.idCompra, p.primerNombreProveedor, p.primerApellidoProveedor, e.primerNombreEmpleado, e.primerApellidoEmpleado, fechaCompra, horaCompra
	ORDER BY c.idCompra DESC

	COMMIT
GO



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
		@precioVentaUnidad [decimal](6, 2)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	INSERT INTO dbo.DetalleCompra
	(
		idCompra, idProducto, cantidadProductoComprado, precioCompraUnidad, precioVentaUnidad
	)
	VALUES
	(
		@idCompra,
		@idProducto,
		@cantidadProductoComprado,
		@precioCompraUnidad,
		@precioVentaUnidad
	)
	COMMIT
GO


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



IF OBJECT_ID('ActualizarDetalleCompra') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.ActualizarDetalleCompra
END
GO
CREATE PROCEDURE dbo.ActualizarDetalleCompra
	(
		@idDetalleCompra [int],
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
		UPDATE dbo.DetalleCompra
		SET  idProducto = @idProducto, cantidadProductoComprado = @cantidadProductoComprado, precioCompraUnidad = @precioCompraUnidad, precioVentaUnidad = @precioVentaUnidad, observaciones = @observaciones
		WHERE idDetalleCompra = @idDetalleCompra
	COMMIT
GO


























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