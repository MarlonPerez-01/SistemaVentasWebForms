create procedure SP_LoginUser
(@nombreUsuario varchar(50), @contraseniaUsuario varchar(50))
as
Begin
	if exists ( select * from Usuario Where nombreUsuario=@nombreUsuario and contraseniaUsuario=HASHBYTES('MD5',@contraseniaUsuario))
	Begin
		select 1 as Resultado, TU.nombreTipoUsuario, US.nombreUsuario from TipoUsuario as TU INNER JOIN Usuario as US ON Tu.idTipoUsuario= US.idTipoUsuario where US.nombreUsuario=@nombreUsuario
	End
	Else
	begin
		Select 0 as Resutado,'Credenciales incorrectas' as 'Mensaje'
	End
End


exec SP_LoginUser 'lopez1731s', 'admin123'

