<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="SistemaVentas.Cliente.Create" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="col">
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="primerNombreCliente" class="col-form-label">Primer Nombre:</label>
                <input type="text" class="form-control" id="inpPrimerNombreCliente" runat="server" />
            </div>
            <div class="form-group col-md-6">
                <label for="segundoNombreCliente" class="col-form-label">Segundo Nombre:</label>
                <input type="text" class="form-control" id="inpSegundoNombreCliente" runat="server" />
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="primerApellidoCliente" class="col-form-label">Primer Apellido:</label>
                <input type="text" class="form-control" id="inpPrimerApellidoCliente" runat="server" />
            </div>
            <div class="form-group col-md-6">
                <label for="inpSegundoApellidoCliente" class="col-form-label">Segundo Apellido:</label>
                <input type="text" class="form-control" id="inpSegundoApellidoCliente" runat="server" />
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="duiCliente" class="col-form-label">DUI:</label>
                <input type="text" class="form-control" id="inpDuiCliente" runat="server" />
            </div>

            <div class="form-group col-md-6">
                <label for="nitCliente" class="col-form-label">NIT:</label>
                <input type="text" class="form-control" id="inpNitCliente" runat="server" />
            </div>

        </div>

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="telefonoCliente" class="col-form-label">Telefono:</label>
                <input type="text" class="form-control" id="inpTelefonoCliente" runat="server" />
            </div>
        </div>

        <div class="row">
            <div class="col">
                <asp:Button ID="btnRegresar" runat="server" CssClass="btn btn-secondary" Text="Regresar" OnClick="btnRegresar_OnClick" />
            </div>
            <div class="col">
                <asp:Button ID="btnCrearCliente" runat="server" CssClass="btn btn-primary" Text="Agregar Cliente" OnClick="btnCrearCliente_OnClick" />
            </div>
        </div>
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
    </div>

</asp:Content>
