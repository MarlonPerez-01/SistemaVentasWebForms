/****** Script for SelectTopNRows command from SSMS  ******/

INSERT INTO dbo.Usuario
(
--idUsuario - column value is auto-generated
idEmpleado, 
idTipoUsuario, 
nombreUsuario, 
contraseniaUsuario
)
VALUES
(
-- idUsuario - int
1, 
1, 
'marlonAdmin', -- nombreUsuario - varchar
HASHBYTES('MD5', '1234')
);
INSERT INTO dbo.Usuario
(
--idUsuario - column value is auto-generated
idEmpleado, 
idTipoUsuario, 
nombreUsuario, 
contraseniaUsuario
)
VALUES
(
-- idUsuario - int
2, 
2, 
'omarBasico', -- nombreUsuario - varchar
HASHBYTES('MD5', '1234')
);

select * from usuario
select * from empleado

