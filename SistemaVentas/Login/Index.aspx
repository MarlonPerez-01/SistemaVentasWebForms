<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Login.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="Styles/bootstrap.min.css" rel="stylesheet" />
    <link href="Styles/login.css" rel="stylesheet" />
    <title></title>
    <style>
        body {
            background-image: url("https://images.pexels.com/photos/1957477/pexels-photo-1957477.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940");
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: 50%;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="container" style="top: 12em; position: relative;">
                <div class="row">
                    <div class="col-md-8">
                    </div>
                    <div class="col-md-4">
                        <h3 class="text-center">E-Tecnology</h3>
                        <p class="text-center">Bienvenido! Ingrese su cuenta</p>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Usuario</label>
                            <asp:TextBox ID="user_text" runat="server" class="form-control"></asp:TextBox>
                            <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                        </div>

                        <div class="form-group">
                            <label for="exampleInputEmail1">Contraseña</label>
                            <asp:TextBox ID="password_text" runat="server" class="form-control" TextMode="Password"></asp:TextBox>
                        </div>
                        <br />
                        <div class="d-flex">
                            <div class="col-4 form-group form-check">
                                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">Recordarme</label>
                            </div>
                            <div class="col-8 align-content-end" style="position: absolute; left: 11em;">
                                <asp:LinkButton ID="LinkButton1" runat="server">¿Olvidaste tu Contraseña?</asp:LinkButton>
                            </div>
                        </div>
                        <asp:Label ID="test" runat="server" Text=""></asp:Label>
                        <br />
                        <br />
                        <br />
                        <div class="col-12">
                            <asp:LinkButton ID="login_btn" runat="server" class="btn btn-primary btn-sm btn-block" OnClick="login_btn_Click">Iniciar Sesión</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="Scripts/jquery-3.4.1.slim.min.js"></script>
    <script src="Scripts/popper.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
</body>
</html>
