IF OBJECT_ID('ValidarUsuario') IS NOT NULL
BEGIN
	DROP PROCEDURE dbo.ValidarUsuario
END
GO
CREATE PROCEDURE dbo.ValidarUsuario
	@nombreUsuario varchar(max),
	@contraseniaUsuario varchar(max)
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON
BEGIN TRANSACTION
IF EXISTS ( SELECT nombreUsuario, contraseniaUsuario
	FROM Usuario
	WHERE (nombreUsuario= @nombreUsuario AND
	contraseniaUsuario=HASHBYTES('MD5', @contraseniaUsuario))
)
BEGIN
	SELECT 1 AS RESULTADO, u.nombreUsuario, u.contraseniaUsuario, u.idTipoUsuario, u.idEmpleado, e.fotografiaEmpleado
	FROM Usuario AS u
	INNER JOIN dbo.Empleado e ON u.idEmpleado = e.idEmpleado
	WHERE nombreUsuario = @nombreUsuario AND contraseniaUsuario=HASHBYTES('MD5', @contraseniaUsuario) AND u.estado = 1
END
ELSE
BEGIN
	SELECT 0 AS RESULTADO, 'Usuario o contraseña incorrecta' AS Mensaje
END
COMMIT
GO

ValidarUsuario 'marlonBasico', 1234


/*INSERT dbo.Usuario
(
    --idUsuario - column value is auto-generated
    idEmpleado,
    idTipoUsuario,
    nombreUsuario,
    contraseniaUsuario,
    estado
)
VALUES
(
    -- idUsuario - int
    2,
    2,
    'usuarioEliminar',
	HASHBYTES('MD5','1234'),
    1
)*/