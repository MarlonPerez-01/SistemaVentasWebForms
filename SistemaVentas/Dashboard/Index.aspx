<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Dashboard.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="col">
        <div>
            <label>Efectivo en Ventas</label>
            <label id="lblCantidadVentaDinero" runat="server"></label>
        </div>
        <div>
            <label>Venta Mayor</label>
            <label id="lblVentaMayor" runat="server"></label>
        </div>
        <div>
            <label>Cantidad de Ventas</label>
            <label id="lblCantidadVentas" runat="server"></label>
        </div>
        <div>
            <label>Producto más Vendido</label>
            <label id="lblProductoMasVendido" runat="server"></label>
        </div>
        <div>
            <label>Cantidad de Empleados</label>
            <label id="lblCantidadEmpleado" runat="server"></label>
        </div>
        <div>
            <label>Cantidad de Categorías</label>
            <label id="lblCantidadCategorias" runat="server"></label>
        </div>
    </div>

</asp:Content>
