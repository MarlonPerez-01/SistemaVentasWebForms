/*Seleccionar Usuarios*/
IF OBJECT_ID('SeleccionarUsuarios') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarUsuarios
END
GO
CREATE PROCEDURE dbo.SeleccionarUsuarios

AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idUsuario, idEmpleado, idTipoUsuario, nombreUsuario, contraseniaUsuario
	FROM dbo.Usuario
	WHERE estado = 1

	COMMIT
GO



/*V2*/
IF OBJECT_ID('SeleccionarUsuarios2') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarUsuarios2
END
GO
CREATE PROCEDURE dbo.SeleccionarUsuarios2

AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idUsuario, nombreUsuario, CONCAT(e.primerNombreEmpleado, ' ', e.segundoNombreEmpleado, ' ', e.primerApellidoEmpleado, ' ', e.segundoApellidoEmpleado) AS nombreEmpleado, tu.nombreTipoUsuario
	FROM dbo.Usuario AS u
	INNER JOIN dbo.Empleado e
	ON u.idEmpleado = e.idEmpleado
	INNER JOIN dbo.TipoUsuario tu
	ON u.idTipoUsuario = tu.idTipoUsuario

	WHERE u.estado = 1

	COMMIT
GO

EXEC SeleccionarUsuarios2

EXEC TipoUsuarioList





/*Insertar Usuario*/

IF OBJECT_ID('InsertarUsuario') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.InsertarUsuario
END
GO

CREATE PROCEDURE dbo.InsertarUsuario
	(
		@idEmpleado [int],
		@idTipoUsuario [int],
		@nombreUsuario [varchar](25),
		@contraseniaUsuario [varchar](25)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	INSERT INTO dbo.Usuario
	(
		idEmpleado, idTipoUsuario, nombreUsuario, contraseniaUsuario
	)
	VALUES
	(
		@idEmpleado,
		@idTipoUsuario,
		@nombreUsuario,
		@contraseniaUsuario
	)
	COMMIT
GO

EXEC InsertarUsuario 1, 1, 'marlonUser', '1234'

SeleccionarUsuarios

InsertarTipoUsuario 'Basico'


/*Actualizar Usuario*/
IF OBJECT_ID('ActualizarUsuario') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.ActualizarUsuario
END
GO
CREATE PROCEDURE dbo.ActualizarUsuario
	(
		@idUsuario [int],
		@idTipoUsuario [int],
		@nombreUsuario [varchar](25),
		@contraseniaUsuario [varchar](25)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Usuario
		SET idTipoUsuario = @idTipoUsuario, nombreUsuario = @nombreUsuario, contraseniaUsuario = @contraseniaUsuario
		WHERE idUsuario = @idUsuario
	COMMIT
GO

EXEC ActualizarUsuario

/*Eliminar Usuario*/
IF OBJECT_ID('EliminarUsuario') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.EliminarUsuario
END
GO
CREATE PROCEDURE dbo.EliminarUsuario
	(
		@idUsuario [int]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.Usuario
		SET  estado = 0
		WHERE idUsuario = @idUsuario
	COMMIT
GO

EXEC EliminarUsuario