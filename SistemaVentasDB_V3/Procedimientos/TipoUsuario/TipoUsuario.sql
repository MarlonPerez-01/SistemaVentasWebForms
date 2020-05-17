/*Seleccionar Usuarios*/
IF OBJECT_ID('SeleccionarTipoUsuarios') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.SeleccionarTipoUsuarios
END
GO
CREATE PROCEDURE dbo.SeleccionarTipoUsuarios
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT idTipoUsuario, nombreTipoUsuario
	FROM dbo.TipoUsuario
	WHERE estado = 1
	COMMIT
GO


/*Insertar Tipo Usuario*/
IF OBJECT_ID('InsertarTipoUsuario') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.InsertarTipoUsuario
END
GO
CREATE PROCEDURE dbo.InsertarTipoUsuario
	(
		@nombreTipoUsuario [varchar](25)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	INSERT INTO dbo.TipoUsuario
	(
		nombreTipoUsuario
	)
	VALUES
	(
		@nombreTipoUsuario
	)

	COMMIT
GO



/*Actualizar TipoUsuario*/
IF OBJECT_ID('ActualizarTipoUsuario') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.ActualizarTipoUsuario
END
GO
CREATE PROCEDURE dbo.ActualizarTipoUsuario
	(
		@idTipoUsuario [int],
		@nombreTipoUsuario [varchar](25)
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.TipoUsuario
		SET  nombreTipoUsuario = @nombreTipoUsuario
		WHERE idTipoUsuario = @idTipoUsuario
	COMMIT
GO



/*Eliminar TipoUsuario*/
IF OBJECT_ID('EliminarTipoUsuario') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.EliminarTipoUsuario
END
GO
CREATE PROCEDURE dbo.EliminarTipoUsuario
	(
		@idTipoUsuario [int]
	)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION
		UPDATE dbo.TipoUsuario
		SET  estado = 0
		WHERE idTipoUsuario = @idTipoUsuario
	COMMIT
GO