
--Cantidad Vendida en dinero
SELECT SUM(dv.cantidadProducto * p.precio) FROM dbo.DetalleVenta dv
INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto


--Venta Mayor
SELECT MAX(dv.cantidadProducto * p.precio) FROM dbo.DetalleVenta dv
INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto


--Cantidad de Ventas
SELECT COUNT(v.idVenta) FROM dbo.Venta v


SELECT v.* FROM dbo.Venta v

SELECT Count(idVenta)
FROM dbo.Venta v
GROUP BY dateadd(DAY,0, datediff(day,0, v.fechaVenta)), v.idVenta

Selec

SELECT SUM(total) FROM invoices
  WHERE created_at BETWEEN '2017-08-24 00:00:00' AND '2017-08-24 23:59:59';






  


IF OBJECT_ID('obtenerVentasPordia') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.obtenerVentasPordia
END
GO
CREATE PROCEDURE dbo.obtenerVentasPordia
	@nombreUsuario varchar(max),
	@contraseniaUsuario varchar(max)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
BEGIN TRANSACTION

SELECT DATEPART(YEAR, fechaVenta) AS 'Anio',
		DATEPART(MONTH, fechaVenta) AS 'Mes',
        DATEPART(DAY, fechaVenta) AS 'Dia',
        COUNT(*) AS 'Venta'
FROM      Venta
GROUP BY  DATEPART(DAY, fechaVenta),
          DATEPART(MONTH, fechaVenta),
          DATEPART(YEAR, fechaVenta)
ORDER BY  'Anio',
          'Mes',
          'Dia'


COMMIT
GO




IF OBJECT_ID('obtenerProductosMasVendidos') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.obtenerProductosMasVendidos
END
GO
CREATE PROCEDURE dbo.obtenerProductosMasVendidos

AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
BEGIN TRANSACTION

SELECT p.nombreProducto, dv.cantidadProducto FROM dbo.DetalleVenta dv
INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto

COMMIT
GO

obtenerProductosMasVendidos


IF OBJECT_ID('obtenerProductosMasVendidos') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.obtenerProductosMasVendidos
END
GO
CREATE PROCEDURE dbo.obtenerProductosMasVendidos

AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
BEGIN TRANSACTION

SELECT p.nombreProducto AS PlanName, dv.cantidadProducto as PaymentAmount FROM dbo.DetalleVenta dv
INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto

COMMIT
GO

obtenerProductosMasVendidos
