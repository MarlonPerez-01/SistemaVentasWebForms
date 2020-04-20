/*Seleccionar Clientes*/

IF OBJECT_ID('SeleccionarClientes') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarClientes
END
GO
CREATE PROCEDURE dbo.SeleccionarClientes

AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idCliente, primerNombreCliente, segundoNombreCliente, primerApellidoCliente, segundoApellidoCliente, duiCliente, nitCliente, telefonoCliente
	FROM dbo.Cliente
	WHERE estado = 1
	COMMIT
GO

EXEC SeleccionarClientes



/*Seleccionar Clientes por ID*/

IF OBJECT_ID('SeleccionarClientesById') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarClientesById
END
GO
CREATE PROCEDURE dbo.SeleccionarClientesById
		@idCliente [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idCliente, primerNombreCliente, segundoNombreCliente, primerApellidoCliente, segundoApellidoCliente, duiCliente, nitCliente, telefonoCliente, estado
	FROM dbo.Cliente
	WHERE idCliente = @idCliente AND estado = 1

	COMMIT
GO

EXEC SeleccionarClientesById 3


/*Insertar Clientes*/
IF OBJECT_ID('InsertarCliente') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.InsertarCliente
END
GO

CREATE PROCEDURE dbo.InsertarCliente
	(
		@primerNombreCliente [varchar](50),
		@segundoNombreCliente [varchar](50),
		@primerApellidoCliente [varchar](50),
		@segundoApellidoCliente [varchar](50),
		@duiCliente [varchar](10),
		@nitCliente [varchar](20),
		@telefonoCliente [int]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	INSERT INTO dbo.Cliente
	(
		primerNombreCliente, segundoNombreCliente, primerApellidoCliente, segundoApellidoCliente, duiCliente, nitCliente, telefonoCliente
	)
	VALUES
	(
		@primerNombreCliente,
		@segundoNombreCliente,
		@primerApellidoCliente,
		@segundoApellidoCliente,
		@duiCliente,
		@nitCliente,
		@telefonoCliente
	)

	COMMIT
GO

EXEC InsertarCliente 'marlonCliente', 'antonio', 'hurtado', 'perez', '12345678-9', '12345678', 78585858



/*Actualizar Clientes*/
IF OBJECT_ID('ActualizarCliente') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.ActualizarCliente
END
GO
CREATE PROCEDURE dbo.ActualizarCliente
	(
		@idCliente [int],
		@primerNombreCliente [varchar](50),
		@segundoNombreCliente [varchar](50),
		@primerApellidoCliente [varchar](50),
		@segundoApellidoCliente [varchar](50),
		@duiCliente [varchar](10),
		@nitCliente [varchar](20),
		@telefonoCliente [int]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Cliente
		SET  primerNombreCliente = @primerNombreCliente, segundoNombreCliente = @segundoNombreCliente, primerApellidoCliente = @primerApellidoCliente, segundoApellidoCliente = @segundoApellidoCliente, duiCliente = @duiCliente, nitCliente = @nitCliente, telefonoCliente = @telefonoCliente
		WHERE idCliente = @idCliente
	COMMIT
GO

EXEC ActualizarCliente 1, 'editado', 'editado', 'editado', 'editado', '12345678-9', '12345678', 71455858
SeleccionarClientes



/*Eliminar Cliente*/
IF OBJECT_ID('EliminarCliente') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.EliminarCliente
END
GO
CREATE PROCEDURE dbo.EliminarCliente
	(
		@idCliente [int]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Cliente
		SET  estado = 0
		WHERE idCliente = @idCliente
	COMMIT
GO

EXEC EliminarCliente