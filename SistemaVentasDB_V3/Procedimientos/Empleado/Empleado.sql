/*SELECCIONAR EMPLEADOS*/

IF OBJECT_ID('SeleccionarEmpleados') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarEmpleados
END
GO
CREATE PROCEDURE dbo.SeleccionarEmpleados
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idEmpleado, fotografiaEmpleado, primerNombreEmpleado, primerApellidoEmpleado, c.nombreCargo, telefonoEmpleado, correoEmpleado, fechaContrato
	FROM dbo.Empleado AS e
	INNER JOIN dbo.Cargo c
	ON e.idCargo = c.idCargo
	WHERE e.estado = 1

	COMMIT
GO

EXEC SeleccionarEmpleados




/*Estaban con tipo int*/
ALTER TABLE Empleado
ALTER COLUMN departamentoEmpleado varchar(50) NOT NULL
ALTER TABLE Empleado
ALTER COLUMN municipioEmpleado varchar(50) NOT NULL
ALTER TABLE Empleado
ALTER COLUMN detallesDireccionEmpleado varchar(50) NOT NULL



/*Insertar Empleado*/
IF OBJECT_ID('InsertarEmpleado') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.InsertarEmpleado
END
GO
CREATE PROCEDURE dbo.InsertarEmpleado
	(
		@idCargo [int],
		@primerNombreEmpleado [varchar](50),
		@segundoNombreEmpleado [varchar](50),
		@primerApellidoEmpleado [varchar](50),
		@segundoApellidoEmpleado [varchar](50),
		@duiEmpleado [varchar](10),
		@nitEmpleado [varchar](14),
		@fotografiaEmpleado [varbinary](max),
		@fechaNacimientoEmpleado [date],
		@fechaContrato [date],
		@telefonoEmpleado [int],
		@correoEmpleado [varchar](50),
		@sexoEmpleado [char](1),
		@departamentoEmpleado [varchar](50),
		@municipioEmpleado [varchar](50),
		@detallesDireccionEmpleado [varchar](50)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	INSERT INTO dbo.Empleado
	(
		idCargo, primerNombreEmpleado, segundoNombreEmpleado, primerApellidoEmpleado, segundoApellidoEmpleado, duiEmpleado, nitEmpleado, fotografiaEmpleado, fechaNacimientoEmpleado, fechaContrato, telefonoEmpleado, correoEmpleado, sexoEmpleado, departamentoEmpleado, municipioEmpleado, detallesDireccionEmpleado
	)
	VALUES
	(
		@idCargo,
		@primerNombreEmpleado,
		@segundoNombreEmpleado,
		@primerApellidoEmpleado,
		@segundoApellidoEmpleado,
		@duiEmpleado,
		@nitEmpleado,
		@fotografiaEmpleado,
		@fechaNacimientoEmpleado,
		@fechaContrato,
		@telefonoEmpleado,
		@correoEmpleado,
		@sexoEmpleado,
		@departamentoEmpleado,
		@municipioEmpleado,
		@detallesDireccionEmpleado
	)
	COMMIT
GO

SeleccionarEmpleados


/*Insertar Empleado*/
IF OBJECT_ID('InsertarEmpleado') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.InsertarEmpleado
END
GO
CREATE PROCEDURE dbo.InsertarEmpleado
	(
		@idCargo [int],
		@primerNombreEmpleado [varchar](50),
		@segundoNombreEmpleado [varchar](50),
		@primerApellidoEmpleado [varchar](50),
		@segundoApellidoEmpleado [varchar](50),
		@duiEmpleado [varchar](10),
		@nitEmpleado [varchar](14),
		--@fotografiaEmpleado [varbinary](max),
		@fechaNacimientoEmpleado [date],
		@fechaContrato [date],
		@telefonoEmpleado [int],
		@correoEmpleado [varchar](50),
		@sexoEmpleado [char](1),
		@departamentoEmpleado [varchar](50),
		@municipioEmpleado [varchar](50),
		@detallesDireccionEmpleado [varchar](50)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	INSERT INTO dbo.Empleado
	(
		idCargo, primerNombreEmpleado, segundoNombreEmpleado, primerApellidoEmpleado, segundoApellidoEmpleado, duiEmpleado, nitEmpleado,
		--fotografiaEmpleado,
		fechaNacimientoEmpleado, fechaContrato, telefonoEmpleado, correoEmpleado, sexoEmpleado, departamentoEmpleado, municipioEmpleado, detallesDireccionEmpleado
	)
	VALUES
	(
		@idCargo,
		@primerNombreEmpleado,
		@segundoNombreEmpleado,
		@primerApellidoEmpleado,
		@segundoApellidoEmpleado,
		@duiEmpleado,
		@nitEmpleado,
		--@fotografiaEmpleado,
		@fechaNacimientoEmpleado,
		@fechaContrato,
		@telefonoEmpleado,
		@correoEmpleado,
		@sexoEmpleado,
		@departamentoEmpleado,
		@municipioEmpleado,
		@detallesDireccionEmpleado
	)
	COMMIT
GO


EXEC InsertarEmpleado 1, 'marlon', 'antonio', 'hurtado', 'perez', '12345678-9', '12345678', '20001212', '20201212', 74585858, 'marlon@gmail.com', 'm', 'san salvador', 'soyapango', 'casa xd'
SELECT * FROM dbo.Empleado e



EXEC InsertarEmpleado 1, 'marlon', 'antonio', 'hurtado', 'perez', '12345678-9', '12345678', NULL, '20001212', '20201212', 74585858, 'marlon@gmail.com', 'm', 'san salvador', 'soyapango', 'casa xd'

EXEC InsertarEmpleado 1, 'carlos', 'jose', 'lopez', 'perez', '12345678-9', '12345678', NULL, '20001212', '20201212', 74585858, 'marlon@gmail.com', 'm', 'san salvador', 'soyapango', 'casa xd'

SeleccionarUsuarios

/*Actualizar Empleado*/
IF OBJECT_ID('ActualizarEmpleado') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.ActualizarEmpleado
END
GO
CREATE PROCEDURE dbo.ActualizarEmpleado
	(
		@idEmpleado [int],
		@idCargo [int],
		@primerNombreEmpleado [varchar](50),
		@segundoNombreEmpleado [varchar](50),
		@primerApellidoEmpleado [varchar](50),
		@segundoApellidoEmpleado [varchar](50),
		@duiEmpleado [varchar](10),
		@nitEmpleado [varchar](14),
		@fotografiaEmpleado [varbinary](max),
		@fechaNacimientoEmpleado [date],
		@fechaContrato [date],
		@telefonoEmpleado [int],
		@correoEmpleado [varchar](50),
		@sexoEmpleado [char](1),
		@departamentoEmpleado [int],
		@municipioEmpleado [int],
		@detallesDireccionEmpleado [int]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Empleado
		SET  idCargo = @idCargo, primerNombreEmpleado = @primerNombreEmpleado, segundoNombreEmpleado = @segundoNombreEmpleado, primerApellidoEmpleado = @primerApellidoEmpleado, segundoApellidoEmpleado = @segundoApellidoEmpleado, duiEmpleado = @duiEmpleado, nitEmpleado = @nitEmpleado, fotografiaEmpleado = @fotografiaEmpleado, fechaNacimientoEmpleado = @fechaNacimientoEmpleado, fechaContrato = @fechaContrato, telefonoEmpleado = @telefonoEmpleado, correoEmpleado = @correoEmpleado, sexoEmpleado = @sexoEmpleado, departamentoEmpleado = @departamentoEmpleado, municipioEmpleado = @municipioEmpleado, detallesDireccionEmpleado = @detallesDireccionEmpleado
		WHERE idEmpleado = @idEmpleado
	COMMIT
GO


/*Eliminar Empleado*/

IF OBJECT_ID('EliminarEmpleado') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.EliminarEmpleado
END
GO
CREATE PROCEDURE dbo.EliminarEmpleado
	(
		@idEmpleado [int]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Empleado
		SET estado = 0
		WHERE idEmpleado = @idEmpleado
	COMMIT
GO

EXEC EliminarEmpleado