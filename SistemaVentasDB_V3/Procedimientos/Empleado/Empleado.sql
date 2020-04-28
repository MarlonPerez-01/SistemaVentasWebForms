/*SeleccionarEmpleadoById*/

IF OBJECT_ID('SeleccionarEmpleadoById') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarEmpleadoById
END
GO
CREATE PROCEDURE dbo.SeleccionarEmpleadoById
		@idEmpleado [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT e.idEmpleado, CONCAT(e.primerNombreEmpleado, ' ' ,e.segundoNombreEmpleado,  ' ' ,e.primerApellidoEmpleado,  ' ' ,e.segundoApellidoEmpleado) AS nombreEmpleado, e.duiEmpleado, e.nitEmpleado, e.fotografiaEmpleado, e.sexoEmpleado, e.fechaNacimientoEmpleado, e.fechaContrato, e.telefonoEmpleado, e.correoEmpleado, CONCAT(e.departamentoEmpleado,  ', ' , e.municipioEmpleado,  ', ' ,e.detallesDireccionEmpleado) AS direccionEmpleado, c.nombreCargo
	FROM dbo.Empleado AS e
	INNER JOIN dbo.Cargo c ON e.idCargo = c.idCargo
	WHERE idEmpleado = @idEmpleado AND e.estado = 1
	COMMIT
GO

 SeleccionarEmpleadoById 9




 /*SeleccionarEmpleadoById MODAL EDITAR*/

IF OBJECT_ID('SeleccionarEmpleadoById_e') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarEmpleadoById_e
END
GO
CREATE PROCEDURE dbo.SeleccionarEmpleadoById_e
		@idEmpleado [int]
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT e.idEmpleado, e.primerNombreEmpleado, e.segundoNombreEmpleado, e.primerApellidoEmpleado, e.segundoApellidoEmpleado, e.duiEmpleado, e.nitEmpleado, e.fotografiaEmpleado, e.fechaNacimientoEmpleado, e.fechaContrato, e.telefonoEmpleado, e.correoEmpleado, e.departamentoEmpleado,  e.municipioEmpleado, e.detallesDireccionEmpleado
	FROM dbo.Empleado AS e
	WHERE idEmpleado = @idEmpleado AND e.estado = 1
	COMMIT
GO

 SeleccionarEmpleadoById_e 9
 SELECT e.* FROM dbo.Empleado e



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

	SELECT idEmpleado, e.fotografiaEmpleado, primerNombreEmpleado, primerApellidoEmpleado, c.nombreCargo, telefonoEmpleado, correoEmpleado, fechaContrato
	FROM dbo.Empleado AS e
	INNER JOIN dbo.Cargo c
	ON e.idCargo = c.idCargo
	WHERE e.estado = 1

	COMMIT
GO

EXEC SeleccionarEmpleados


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
		@fotografiaEmpleado varbinary(max),
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

EXEC InsertarEmpleado 1, 'carlos', 'jose', 'lopez', 'perez', '12345678-9', '12345678', NULL, '20001212', '20201212', 74585858, 'marlon@gmail.com', 'm', 'san salvador', 'soyapango', 'casa xd'

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
