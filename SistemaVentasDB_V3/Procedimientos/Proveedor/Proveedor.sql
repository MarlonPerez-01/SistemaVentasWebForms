/*SELECCIONAR PROVEEDORES*/
IF OBJECT_ID('SeleccionarProveedores') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarProveedores
END
GO
CREATE PROCEDURE dbo.SeleccionarProveedores
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idProveedor, primerNombreProveedor, segundoNombreProveedor, primerApellidoProveedor, segundoApellidoProveedor, empresaProveedor, telefonoProveedor
	FROM dbo.Proveedor
	WHERE estado = 1

	COMMIT
GO

EXEC SeleccionarProveedores

/*INSERTAR PROVEEDORES*/
IF OBJECT_ID('InsertarProveedor') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.InsertarProveedor
END
GO
CREATE PROCEDURE dbo.InsertarProveedor
	(
		@primerNombreProveedor [varchar](50),
		@segundoNombreProveedor [varchar](50),
		@primerApellidoProveedor [varchar](50),
		@segundoApellidoProveedor [varchar](50),
		@telefonoProveedor [int],
		@empresaProveedor [varchar](50)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	INSERT INTO dbo.Proveedor
	(
		primerNombreProveedor, segundoNombreProveedor, primerApellidoProveedor, segundoApellidoProveedor, telefonoProveedor, empresaProveedor
	)
	VALUES
	(
		@primerNombreProveedor,
		@segundoNombreProveedor,
		@primerApellidoProveedor,
		@segundoApellidoProveedor,
		@telefonoProveedor,
		@empresaProveedor
	)
	
	COMMIT
GO

EXEC InsertarProveedor 'JoseProveedor', 'Roberto', 'Lopez', 'Perez', 75858596, 'HP'



/*ACTUALIZAR PROVEEDOR*/
IF OBJECT_ID('ActualizarProveedor') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.ActualizarProveedor
END
GO
CREATE PROCEDURE dbo.ActualizarProveedor
	(
		@idProveedor [int],
		@primerNombreProveedor [varchar](50),
		@segundoNombreProveedor [varchar](50),
		@primerApellidoProveedor [varchar](50),
		@segundoApellidoProveedor [varchar](50),
		@telefonoProveedor [int],
		@empresaProveedor [varchar](50)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Proveedor
		SET  primerNombreProveedor = @primerNombreProveedor, segundoNombreProveedor = @segundoNombreProveedor, primerApellidoProveedor = @primerApellidoProveedor, segundoApellidoProveedor = @segundoApellidoProveedor, telefonoProveedor = @telefonoProveedor, empresaProveedor = @empresaProveedor
		WHERE idProveedor = @idProveedor
	COMMIT
GO

EXEC ActualizarProveedor


/*ELIMINAR PROVEEDOR*/
IF OBJECT_ID('EliminarProveedor') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.EliminarProveedor
END
GO
CREATE PROCEDURE dbo.EliminarProveedor
	(
		@idProveedor [int]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Proveedor
		SET estado = 0
		WHERE idProveedor = @idProveedor
	COMMIT
GO

EXEC EliminarProveedor '2'
