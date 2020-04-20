SELECT u.* FROM dbo.Usuario u

IF OBJECT_ID('Login') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.Login
END
GO
CREATE PROCEDURE dbo.Login
		@nombreUsuario varchar(50),
		@contraseniaUsuario varchar(50)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
	
	BEGIN TRANSACTION

	SELECT nombreUsuario, contraseniaUsuario
	FROM dbo.Usuario
	WHERE nombreUsuario = @nombreUsuario AND contraseniaUsuario = @contraseniaUsuario AND estado = 1

	COMMIT
GO

login 'MarlonUser', '2134554'