<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SistemaVentas.Default" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Formulario</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-6 login-imagen">
            </div>
            <div class="col-6">
                <div class="row justify-content-center align-content-center" style="height: 100vh;">
                    <div class="col-12 text-center mb-2">
                        <h3 class="font-weight-light mb-4">E-Technology</h3>
                        <p class="lead">Bienvenido! Ingrese a Su cuenta</p>
                    </div>
                    <div class="alert alert-danger" id="alerta" role="alert" runat="server">
                        Los datos ingresados son inválidos.
                    </div>
                    <div class="w-100"></div>
                    <form id="form1" runat="server" class="col-12 col-md-10 col-lg-8 col-xl-6">
                        <div class="form-group">
                            <label for="txtNombreUsuario">Usuario</label>
                            <asp:TextBox ID="txtNombreUsuario" runat="server" class="form-control col-12"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="txtContraseniaUsuario">Contraseña</label>
                            <asp:TextBox ID="txtContraseniaUsuario" runat="server" class="form-control col-12" type="password"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnIngresar" runat="server" Text="Ingresar" class="btn btn-block btn-primary" OnClick="btnIngresar_OnClick" />
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="Login/Scripts/jquery-3.0.0.slim.min.js"></script>
    <script src="Login/Scripts/popper.min.js"></script>
    <script src="Login/Scripts/bootstrap.min.js"></script>
    <style>
        .login-imagen {
            background-image: url('/Images/login-img.jpg');
            height: 100vh;
            background-size: cover;
            background-repeat: no-repeat;
        }
    </style>
</body>
</html>
