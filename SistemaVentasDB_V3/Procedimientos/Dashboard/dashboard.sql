	

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

