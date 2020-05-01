/*Listado Nombres Empleados*/
IF OBJECT_ID('EmpleadoList') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.EmpleadoList
END
GO
CREATE PROCEDURE dbo.EmpleadoList

AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT e.idEmpleado, CONCAT(e.primerNombreEmpleado, ' ', e.segundoNombreEmpleado, ' ', e.primerApellidoEmpleado, ' ', e.segundoApellidoEmpleado) AS nombreEmpleado
	FROM dbo.Empleado e
	WHERE estado = 1

	COMMIT
GO


/*Listado Nombre Cargo*/
IF OBJECT_ID('CargoList') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.CargoList
END
GO
CREATE PROCEDURE dbo.CargoList
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT dbo.Cargo.idCargo, dbo.Cargo.nombreCargo
	FROM dbo.Cargo
	WHERE estado = 1
	COMMIT
GO



/*Listado Nombre TipoCargo*/
IF OBJECT_ID('TipoCargoList') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.TipoCargoList
END
GO
CREATE PROCEDURE dbo.TipoCargoList
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT dbo.Cargo.idCargo, dbo.Cargo.nombreCargo
	FROM dbo.Cargo
	WHERE estado = 1
	COMMIT
GO


/*Listado Nombre TipoUsuario*/
IF OBJECT_ID('TipoUsuarioList') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.TipoUsuarioList
END
GO
CREATE PROCEDURE dbo.TipoUsuarioList
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
	
	SELECT tu.idTipoUsuario, tu.nombreTipoUsuario
	FROM dbo.TipoUsuario tu
	WHERE estado = 1
	COMMIT
GO


/*Listado Nombre CategoriaList*/
IF OBJECT_ID('MarcaList') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.MarcaList
END
GO
CREATE PROCEDURE dbo.MarcaList
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT m.idMarca, m.nombreMarca
	FROM dbo.Marca m
	WHERE estado = 1
	COMMIT
GO



/*Listado Nombre ProductoList*/
IF OBJECT_ID('ProductoList') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.ProductoList
END
GO
CREATE PROCEDURE dbo.ProductoList
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT p.idProducto, p.nombreProducto
	FROM dbo.Producto p
	WHERE estado = 1
	COMMIT
GO

/*Listado Nombre ProveedorL*/
IF OBJECT_ID('ProveedorList') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.ProveedorList
END
GO
CREATE PROCEDURE dbo.ProveedorList
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT p.idProveedor, CONCAT(p.primerNombreProveedor, ' ' , p.segundoNombreProveedor, ' ' , p.primerApellidoProveedor,  ' ' , p.segundoApellidoProveedor) AS nombreProveedor
	FROM dbo.Proveedor p
	WHERE estado = 1
	COMMIT
GO

