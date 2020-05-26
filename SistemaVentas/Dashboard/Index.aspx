<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Dashboard.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="col">
        
        <div class="row">
            <div class="col">
                <div class="card">
                    <img class="card-img-top img-fluid size" src="https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80" alt="">
                    <div class="card-body">
                        <label>Efectivo en Ventas: </label>
                        <label id="lblCantidadVentaDinero" runat="server"></label>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card">
                    <img class="card-img-top img-fluid" src="https://images.unsplash.com/photo-1521791136064-7986c2920216?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60" alt="">
                    <div class="card-body">
                        <label>Venta Mayor: </label>
                        <label id="lblVentaMayor" runat="server"></label>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card">
                    <img class="card-img-top img-fluid" src="https://images.unsplash.com/photo-1559589689-577aabd1db4f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80" alt="">
                    <div class="card-body">
                        <label>Cantidad de Ventas: </label>
                        <label id="lblCantidadVentas" runat="server"></label>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col">
                <div class="card">
                    <img class="card-img-top img-fluid" src="https://source.unsplash.com/random/300x200" alt="">
                    <div class="card-body">
                        <label>Producto más Vendido: </label>
                        <label id="lblProductoMasVendido" runat="server"></label>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card">
                    <img class="card-img-top img-fluid" src="https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80" alt="">
                    <div class="card-body">
                        <label>Cantidad de Empleados: </label>
                        <label id="lblCantidadEmpleado" runat="server"></label>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card">
                    <img class="card-img-top img-fluid" src="https://images.unsplash.com/photo-1512756290469-ec264b7fbf87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=649&q=80" alt="">
                    <div class="card-body">
                        <label>Cantidad de Categorías: </label>
                        <label id="lblCantidadCategorias" runat="server"></label>
                    </div>
                </div>
            </div>
        </div>


    </div>

    <style>

        .card {
        
            font-weight: bold;
        
        }

        .card img {
            width: 100%;
            height: 12rem;
        }

    </style>

</asp:Content>
