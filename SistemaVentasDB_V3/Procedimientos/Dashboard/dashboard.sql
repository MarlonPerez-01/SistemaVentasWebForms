
--Cantidad Vendida en dinero
IF OBJECT_ID('obtenerCantidadVentasDinero') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.obtenerCantidadVentasDinero
END
GO
CREATE PROCEDURE dbo.obtenerCantidadVentasDinero

AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
BEGIN TRANSACTION

SELECT SUM(dv.cantidadProducto * p.precio) FROM dbo.DetalleVenta dv
INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto

COMMIT
GO


--Venta Mayor
IF OBJECT_ID('obtenerVentaMayor') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.obtenerVentaMayor
END
GO
CREATE PROCEDURE dbo.obtenerVentaMayor

AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
BEGIN TRANSACTION

SELECT TOP 1 SUM(dv.cantidadProducto * p.precio) AS ventaMayor
FROM dbo.DetalleVenta dv
INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto
GROUP BY dv.idVenta
ORDER BY ventaMayor DESC

COMMIT
GO



--Cantidad de Ventas

IF OBJECT_ID('obtenerCantidadVentas') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.obtenerCantidadVentas
END
GO
CREATE PROCEDURE dbo.obtenerCantidadVentas

AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
BEGIN TRANSACTION

SELECT COUNT(v.idVenta) FROM dbo.Venta v

COMMIT
GO



--Producto mas vendido
IF OBJECT_ID('obtenerProductoMasVendido') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.obtenerProductoMasVendido
END
GO
CREATE PROCEDURE dbo.obtenerProductoMasVendido

AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
BEGIN TRANSACTION

SELECT TOP 1 p.nombreProducto FROM dbo.DetalleVenta dv
INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto
ORDER BY dv.cantidadProducto DESC

COMMIT
GO

obtenerProductosMasVendidos


--Cantidad Empleados
IF OBJECT_ID('obtenerCantidadEmpleados') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.obtenerCantidadEmpleados
END
GO
CREATE PROCEDURE dbo.obtenerCantidadEmpleados

AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
BEGIN TRANSACTION

SELECT COUNT(idEmpleado) AS cantidadEmpleado
FROM empleado
COMMIT
GO


--Cantidad Categorias
IF OBJECT_ID('ObtenerCantidadCategorias') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.ObtenerCantidadCategorias
END
GO
CREATE PROCEDURE dbo.ObtenerCantidadCategorias

AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
BEGIN TRANSACTION

SELECT COUNT(idCategoria) AS cantidadCategorias
FROM dbo.Categoria
COMMIT
GO



SELECT

	(SELECT SUM(dv.cantidadProducto * p.precio) FROM dbo.DetalleVenta dv
	INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto) AS cantidadVendidaDinero,

	(SELECT TOP 1 SUM(dv.cantidadProducto * p.precio) AS ventaMayor
	FROM dbo.DetalleVenta dv
	INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto
	GROUP BY dv.idVenta
	ORDER BY ventaMayor DESC) AS ventaMayor,
	
	(SELECT COUNT(v.idVenta) FROM dbo.Venta v) AS cantidadVentas,

	(SELECT TOP 1 p.nombreProducto FROM dbo.DetalleVenta dv
	INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto
	ORDER BY dv.cantidadProducto DESC) AS productoMasVendido,

	(SELECT COUNT(idEmpleado) AS cantidadEmpleado
	FROM empleado) AS cantidadEmpleado,

	(SELECT COUNT(idCategoria) AS cantidadCategorias
	FROM dbo.Categoria
	) AS cantidadCategorias


	

IF OBJECT_ID('dashboardSP') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.dashboardSP
END
GO
CREATE PROCEDURE dbo.dashboardSP

AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
BEGIN TRANSACTION


SELECT

	(SELECT SUM(dv.cantidadProducto * p.precio) FROM dbo.DetalleVenta dv
	INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto) AS cantidadVendidaDinero,

	(SELECT TOP 1 SUM(dv.cantidadProducto * p.precio) AS ventaMayor
	FROM dbo.DetalleVenta dv
	INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto
	GROUP BY dv.idVenta
	ORDER BY ventaMayor DESC) AS ventaMayor,
	
	(SELECT COUNT(v.idVenta) FROM dbo.Venta v) AS cantidadVentas,

	(SELECT TOP 1 p.nombreProducto FROM dbo.DetalleVenta dv
	INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto
	ORDER BY dv.cantidadProducto DESC) AS productoMasVendido,

	(SELECT COUNT(idEmpleado) AS cantidadEmpleado
	FROM empleado) AS cantidadEmpleado,

	(SELECT COUNT(idCategoria) AS cantidadCategorias
	FROM dbo.Categoria
	) AS cantidadCategorias


COMMIT
GO


dashboardSP