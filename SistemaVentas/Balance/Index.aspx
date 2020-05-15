<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Balance.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="detalle-compra">
        <h3>Agregar Productos a la Compra</h3>
        <div>
            <label for="ddlProducto_dc">Producto</label>
            <asp:DropDownList ID="ddlProducto_dc" runat="server"></asp:DropDownList>
        </div>
        <div>
            <label for="inpCantidadProductoComprado">Cantidad</label>
            <input id="inpCantidadProductoComprado" runat="server" type="text"/>
        </div>
        <div>
            <label for="inpPrecioCompraUnidad">Precio Compra Unidad</label>
            <input id="inpPrecioCompraUnidad" runat="server" type="text"/>
        </div>
        <div>
            <label for="inpPrecioVentaUnidad">Precio Venta Unidad</label>
            <input id="inpPrecioVentaUnidad" runat="server" type="text"/>
        </div>
        <div>
            <label for="inpObservaciones">Observaciones</label>
            <input id="inpObservaciones" runat="server" type="text"/>
        </div>
        <div>
            <asp:Button ID="btnAgregarProducto" CommandName="Agregar" runat="server" Text="Agregar" OnClick="btnAgregarProducto_OnClick" />
        </div>
    </div>
</asp:Content>
