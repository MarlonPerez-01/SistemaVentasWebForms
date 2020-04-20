<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="SistemaVentas.Usuario.Create" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col">
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="ddlIdEmpleado" class="col-form-label">Id Empleado:</label>
                <asp:DropDownList ID="ddlIdEmpleado" runat="server">
                </asp:DropDownList>

            </div>
            <div class="form-group col-md-6">
                <label for="idTipoUsuario" class="col-form-label">Tipo de Usuario:</label>
                <asp:DropDownList ID="ddlIdTipoUsuario" runat="server">
                </asp:DropDownList>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="inpNombreUsuario" class="col-form-label">Nombre de Usuario:</label>
                <input type="text" class="form-control" id="inpNombreUsuario" runat="server" />
            </div>
            <div class="form-group col-md-6">
                <label for="inpContraseniaUsuario" class="col-form-label">Contraseña:</label>
                <input type="text" class="form-control" id="inpContraseniaUsuario" runat="server" />
            </div>
        </div>

        <div class="row">
            <div class="col">
                <asp:Button ID="btnRegresar" runat="server" CssClass="btn btn-secondary" Text="Regresar" OnClick="btnRegresar_OnClick" />
            </div>
            <div class="col">
                <asp:Button ID="btnCrearUsuario" runat="server" CssClass="btn btn-primary" Text="Agregar Cliente" OnClick="btnCrearUsuario_OnClick" />
            </div>
        </div>
        <asp:Label ID="lblMensaje" runat="server" Text=""></asp:Label>
    </div>
</asp:Content>
