<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.PuntoDeCompra.Index" ClientIDMode="Static"%>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  
    <h1>Contenido</h1>
    
    <div class="w-100"></div>
    <div>
        <div>
            <label for="inpIdCompra">ID:</label>
            <input id="inpIdCompra" runat="server" type="text" disabled="disabled"/>
        </div>
        <div>
            <label for="ddlProveedor">Proveedor:</label>
            <asp:DropDownList ID="ddlProveedor" runat="server"></asp:DropDownList>
        </div>
        <div>
            <label for="ddlUsuario">Usuario</label>
            <asp:DropDownList ID="ddlUsuario" runat="server"></asp:DropDownList>
        </div>
        <div>
            <label for="inpFechaCompra">Fecha</label>
            <input id="inpFechaCompra" runat="server" type="date" />
        </div>
        <div>
            <label for="inpHoraCompra">Hora</label>
            <input id="inpHoraCompra" runat="server" type="time" />
        </div>
        <asp:Button ID="btnFactura" runat="server" Text="Generar" OnClick="btnFactura_OnClick"/>
    </div>
    
    

</asp:Content>