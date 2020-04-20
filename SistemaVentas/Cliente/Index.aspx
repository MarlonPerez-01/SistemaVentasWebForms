<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Cliente.Index" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Listado de Clientes</h2>
    <hr />

    <asp:GridView ID="gvClientes" runat="server" AutoGenerateColumns="true">
    </asp:GridView>

    <script>
        var divTabla = document.getElementById("MainContent_gvClientes").parentElement;

    </script>



    <div class="w-100"></div>

    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>


</asp:Content>

