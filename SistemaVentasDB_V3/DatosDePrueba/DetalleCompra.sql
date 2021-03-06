
USE [SistemaVentasDB2]
GO

INSERT INTO [dbo].[DetalleCompra]
           ([idCompra]
           ,[idProducto]
           ,[cantidadProductoComprado]
           ,[precioCompraUnidad]
           ,[precioVentaUnidad]
           ,[observaciones]
           ,[estado])
     VALUES
           (8
           ,1
           ,20
           ,30
           ,0
           ,'no hay'
           ,1)
GO


INSERT INTO [dbo].[DetalleCompra]
           ([idCompra]
           ,[idProducto]
           ,[cantidadProductoComprado]
           ,[precioCompraUnidad]
           ,[precioVentaUnidad]
           ,[observaciones]
           ,[estado])
     VALUES
           (9
           ,1
           ,10
           ,40
           ,0
           ,'no hay'
           ,1)
GO

SELECT dc.* FROM dbo.DetalleCompra dc
SELECT c.* FROM dbo.Compra c


SELECT *
FROM dbo.DetalleCompra dc
WHERE dc.idCompra = 8


SELECT dc.idDetalleCompra, p.nombreProducto, (p.precio * p.descuento)
FROM dbo.DetalleCompra dc
INNER JOIN dbo.Producto p ON dc.idProducto = p.idProducto
WHERE dc.idCompra = 8


SELECT *
FROM dbo.DetalleVenta dv
INNER JOIN dbo.Producto p ON dv.idProducto = p.idProducto
WHERE dc.idCompra = 8


SELECT v.* FROM dbo.Venta v
SELECT dv.* FROM dbo.DetalleVenta dv

insert into detalleCompra([idCompra]
      ,[idProducto]
      ,[cantidadProductoComprado]
      ,[precioCompraUnidad]
	  values(6,10,10,20)


	  insert into detalleCompra([idCompra]
      ,[idProducto]
      ,[cantidadProductoComprado]
      ,[precioCompraUnidad]
      ,[precioVentaUnidad])
	  values(6,1,10,20,30)


	  insert into detalleCompra([idCompra]
      ,[idProducto]
      ,[cantidadProductoComprado]
      ,[precioCompraUnidad]
      ,[precioVentaUnidad])
	  values(6,1,10,20,30)


insert into detalleCompra([idCompra]
      ,[idProducto]
      ,[cantidadProductoComprado]
      ,[precioCompraUnidad]
      ,[precioVentaUnidad])
	  values(2,2,50,10,30)

insert into detalleCompra([idCompra]
      ,[idProducto]
      ,[cantidadProductoComprado]
      ,[precioCompraUnidad]
      ,[precioVentaUnidad])
	  values(3,3,30,20,30)