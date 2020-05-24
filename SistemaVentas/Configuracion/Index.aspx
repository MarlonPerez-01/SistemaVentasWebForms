<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Configuracion.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h3>Cambiar Contraseña</h3>

    <div class="w-100"></div>

    <div>

        <div class="d-inline">
            <label for="inpContraseniaAntigua" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
            <input type="text" placeholder="Contraseña Antigua" class="form-control" id="inpContraseniaAntigua" runat="server" />
        </div>
        <div class="d-inline">
            <label for="inpContraseniaNueva" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
            <input type="text" placeholder="Contraseña Nueva" class="form-control" id="inpContraseniaNueva" runat="server" />
        </div>
    </div>

</asp:Content>
