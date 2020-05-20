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

	SELECT idUsuario, nombreUsuario, CONCAT(e.primerNombreEmpleado, ' ', e.segundoNombreEmpleado, ' ', e.primerApellidoEmpleado, ' ', e.segundoApellidoEmpleado) AS nombreEmpleado, tu.nombreTipoUsuario
	FROM dbo.Usuario AS u
	INNER JOIN dbo.Empleado e
	ON u.idEmpleado = e.idEmpleado
	INNER JOIN dbo.TipoUsuario tu
	ON u.idTipoUsuario = tu.idTipoUsuario

	WHERE u.estado = 1

	COMMIT
GO



--SeleccionarUsuarioById
IF OBJECT_ID('SeleccionarUsuarioById') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarUsuarioById
END
GO
CREATE PROCEDURE dbo.SeleccionarUsuarioById
	(@idUsuario [int])
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

	WHERE idUsuario = @idUsuario AND u.estado = 1

	COMMIT
GO



--Para llenar el modal editar
IF OBJECT_ID('SeleccionarUsuarioByIdEditar') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarUsuarioByIdEditar
END
GO
CREATE PROCEDURE dbo.SeleccionarUsuarioByIdEditar
	(@idUsuario [int])
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT u.idUsuario, CONCAT(e.primerNombreEmpleado, ' ', e.segundoNombreEmpleado, ' ', e.primerApellidoEmpleado, ' ', e.segundoApellidoEmpleado) AS nombreEmpleado, u.idTipoUsuario, u.nombreUsuario, u.contraseniaUsuario
	FROM Usuario AS u
	INNER JOIN dbo.Empleado e
	ON u.idEmpleado = e.idEmpleado
	WHERE u.idUsuario = @idUsuario AND u.estado = 1
	COMMIT
GO

SeleccionarUsuarioByIdEditar 1
select * from Usuario

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
