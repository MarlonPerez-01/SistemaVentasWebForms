<%@ Page Title="PuntoDeCompra" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.PuntoDeCompra.Index" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1>Listado de Compra</h1>

    <div class="w-100"></div>

    <asp:LinkButton ID="btnCrearCompra" runat="server" CommandName="crear" CommandArgument='<%#Eval("idCompra") %>' OnClick="btnCrearCompra_OnClick"><i class="fas fa-search-plus"></i>Crear Compra</asp:LinkButton>

    <div class="w-100"></div>

    <div class="datosCompra">
        <p>Datos de la Compra</p>
        <div>
            <label for="inpIdCompra">ID:</label>
            <input id="inpIdCompra" runat="server" type="text" disabled="disabled" />
        </div>
        <div>
            <label for="inpNombreProveedor">Proveedor:</label>
            <input id="inpNombreProveedor" runat="server" type="text" disabled="disabled" />
        </div>
        <div>
            <label for="inpNombreEmpleado">Usuario</label>
            <input id="inpNombreEmpleado" runat="server" type="text" disabled="disabled" />
        </div>
        <div>
            <label for="inpFechaCompra">Fecha</label>
            <input id="inpFechaCompra" runat="server" type="text" disabled="disabled" />
        </div>
        <div>
            <label for="inpHoraCompra">Hora</label>
            <input id="inpHoraCompra" runat="server" type="text" disabled="disabled" />
        </div>
    </div>

    <div class="w-100"></div>

    <div class="detalle-compra">
        <h3>Agregar Productos a la Compra</h3>
        <div>
            <label for="ddlProducto_dc">Producto</label>
            <asp:DropDownList ID="ddlProducto_dc" runat="server"></asp:DropDownList>
        </div>
        <div>
            <label for="inpCantidadProductoComprado">Cantidad</label>
            <input id="inpCantidadProductoComprado" runat="server" type="text" />
        </div>
        <div>
            <label for="inpPrecioCompraUnidad">Precio Compra Unidad</label>
            <input id="inpPrecioCompraUnidad" runat="server" type="text" />
        </div>
        <div>
            <label for="inpPrecioVentaUnidad">Precio Venta Unidad</label>
            <input id="inpPrecioVentaUnidad" runat="server" type="text" />
        </div>
        <div>
            <label for="inpObservaciones">Observaciones</label>
            <input id="inpObservaciones" runat="server" type="text" />
        </div>
        <div>
            <asp:Button ID="btnAgregarProducto" CommandName="Agregar" runat="server" Text="Agregar" OnClick="btnAgregarProducto_OnClick" />
        </div>
    </div>

    <div class="w-100"></div>

    <h3>Detalle Compra</h3>

    <div class="w-100"></div>

    <asp:GridView ID="GridView1" CssClass="table table-sm  table-striped text-center" runat="server" AutoGenerateColumns="False" DataKeyNames="idDetalleCompra" OnRowCommand="GridView1_OnRowCommand">
        <Columns>
            <asp:BoundField DataField="idDetalleCompra" HeaderText="ID" />
            <asp:BoundField DataField="nombreProducto" HeaderText="Producto" />
            <asp:BoundField DataField="cantidadProductoComprado" HeaderText="Cantidad" />
            <asp:BoundField DataField="precioCompraUnidad" HeaderText="Precio Compra Unidad" />
            <asp:BoundField DataField="precioVentaUnidad" HeaderText="Precio Venta Unidad" />
            <asp:BoundField DataField="observaciones" HeaderText="Observaciones" />

            <asp:TemplateField HeaderText="Editar" SortExpression="">
                <ItemTemplate>
                    <asp:LinkButton ID="btnEditar" runat="server" CommandName="editar" CommandArgument='<%#Eval("idDetalleCompra") %>'><i class="fas fa-pencil-alt"></i></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Eliminar" SortExpression="">
                <ItemTemplate>
                    <asp:LinkButton ID="btnEliminar" runat="server" CommandName="eliminar" CommandArgument='<%#Eval("idDetalleCompra") %>'><i class="fas fa-trash-alt"></i></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <div class="w-100"></div>
    <button>Generar Factura</button>


    <div id="fondoModal"></div>

    <!--Inicia Modal Crear-->
    <asp:Panel ID="modalCrear" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio">
                <label>Crear Compra</label>
                <a id="" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="inpIdCompra_c">ID:</label>
                    <input id="inpIdCompra_c" runat="server" type="text" disabled="disabled" />
                </div>
                <div>
                    <label for="ddlProveedor_c">Proveedor:</label>
                    <asp:DropDownList ID="ddlProveedor_c" runat="server"></asp:DropDownList>
                </div>
                <div>
                    <label for="ddlUsuario_c">Usuario:</label>
                    <asp:DropDownList ID="ddlUsuario_c" runat="server"></asp:DropDownList>
                </div>
                <div>
                    <label for="inpFechaCompra_c">Fecha:"</label>
                    <input id="inpFechaCompra_c" runat="server" type="date" />
                </div>
                <div>
                    <label for="inpHoraCompra_c">Hora:</label>
                    <input id="inpHoraCompra_c" runat="server" type="time" />
                </div>
            </div>
            <div class="modal-footer-mio">
                <asp:Button ID="btnCrear" CommandName="Crear" runat="server" Text="Crear" OnClick="btnCrear_OnClick" />
                <button type="button" class="cerrar">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Crear-->


    <!--Inicia Modal Editar-->
    <asp:Panel ID="modalEditar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio">
                <label>Editar Proveedor</label>
                <a id="" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="inpIdDetalleCompra_e" class="col-form-label">Id:</label>
                    <input type="text" class="form-control" id="inpIdDetalleCompra_e" runat="server" />
                </div>
                <div>
                    <label for="ddlProducto_e" class="col-form-label">Producto:</label>
                    <asp:DropDownList ID="ddlProducto_e" runat="server"></asp:DropDownList>
                </div>
                <div>
                    <label for="inpCantidadProductoComprado_e" class="col-form-label">Cantidad Producto Comprado:</label>
                    <input type="text" class="form-control" id="inpCantidadProductoComprado_e" runat="server" />
                </div>
                <div>
                    <label for="inpPrecioCompraUnidad_e" class="col-form-label">Precio Compra Unidad:</label>
                    <input type="text" class="form-control" id="inpPrecioCompraUnidad_e" runat="server" />
                </div>
                <div>
                    <label for="inpPrecioVentaUnidad_e" class="col-form-label">Precio Venta Unidad:</label>
                    <input type="text" class="form-control" id="inpPrecioVentaUnidad_e" runat="server" />
                </div>
                <div>
                    <label for="inpObservaciones_e" class="col-form-label">Observaciones:</label>
                    <input type="text" class="form-control" id="inpObservaciones_e" runat="server" />
                </div>
            </div>
            <div class="modal-footer-mio">
                <asp:Button ID="btnActualizar" CommandName="" runat="server" Text="Actualizar" OnClick="btnActualizar_OnClick" />
                <button type="button" class="cerrar">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Editar-->


    <!--Inicia Modal Eliminar-->
    <asp:Panel ID="modalEliminar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Eliminar Proveedor</label>
                <a id="" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <label for="lblIdDetalleCompraEliminar" class="col-form-label">Está a punto de eliminar la compra con el identificador:</label>
                    <asp:Label ID="lblIdDetalleCompraEliminar" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio text-center">
                <asp:Button ID="btnEliminar" CssClass="mod" CommandName="" runat="server" Text="Eliminar" OnClick="btnEliminar_OnClick" />
                <button type="button" class="cerrar mod">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Eliminar-->


    <style type="text/css">
        #fondoModal {
            position: fixed;
            left: 0px;
            top: 0px;
            z-index: 4;
            opacity: 0.55;
            -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=55)";
            filter: alpha(opacity=55); /* second!*/
            background-color: black;
            display: none;
            width: 100%;
            height: 100%;
        }


        /*mi css*/

        .titulo {
            text-align: center;
            margin-bottom: 1em;
            color: rgb(100, 47, 224);
            font-weight: 400;
        }

        .down {
            transform: translateY(10%);
        }

        /*crear nuevo*/

        .btn-small {
            background-color: rgb(119, 100, 228);
            border-color: rgb(119, 100, 228);
            font-size: 0.7rem;
            width: 12rem;
            color: white;
            border-radius: 0;
        }

        /*dropdown*/

        .btn-opc {
            width: 8rem;
            border: 1px solid rgb(217, 212, 212);
            border-radius: 4px;
            font-size: 1rem;
        }

        .form-size {
            width: 8rem;
            height: 1.9rem;
        }

        tr:first-of-type {
            background-color: rgb(119, 100, 228) !important;
            color: white;
            border-radius: 100px;
        }

        th {
            font-weight: 200;
        }

        /*vuelve los bordes de la tabla redondos*/

        .round-border {
            border-radius: 6px;
            -moz-border-radius: 4px;
            -webkit-border-radius: 4px;
            overflow: hidden;
            font-size: 0.9rem;
        }


        .table-striped > tbody > tr:nth-child(odd) > td,
        .table-striped > tbody > tr:nth-child(odd) > th {
            background-color: rgba(119, 100, 228, 0.1);
        }

        #GridView1 th, #GridView1 td {
            border: none;
        }

        teble a:hover {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }


        /* mueve botones a la derecha */

        .m-left {
            margin-left: 10rem;
        }

        /*mover paginacion a la derecha*/

        .move {
            margin-left: 41.5rem;
            font-size: 0.7rem;
        }

        /*tamaño texto*/

        .p-size {
            font-size: 0.8rem;
        }


        /*ESTILOS MODALS*/

        .center {
            transform: translateX(-50%);
            margin-left: 50%;
        }

        .mod {
            background-color: rgb(119, 100, 228);
            width: 15rem;
            color: white;
        }

        .drop {
            border-radius: 5px;
            width: 18rem;
            height: 2.4rem !important;
            border: 0.5px solid #ced4da;
            color: #495057;
            display: inline;
        }

        .success {
            border-color: #2ecc71;
        }

        .fail {
            border-color: #e74c3c;
        }

        .title-fix {
            line-height: 28px;
        }
    </style>

    <script type="text/javascript" language="javascript">

        $(".table").attr({
            border: "0",
            cellpadding: "0",
            cellspacing: "0"
        });

        function mostrarDetalles() {
            $('#fondoModal').show();

        }
        function esconderDetalles() {
            $('#fondoModal').hide();
        }

        function mostrarEditar() {
            $('#fondoModal').show();
            $('#<%=modalEditar.ClientID %>').show();
        }
        function esconderEditar() {
            $('#fondoModal').hide();
            $('#<%=modalEditar.ClientID %>').hide();
        }

        function mostrarEliminar() {
            $('#fondoModal').show();
            $('#<%=modalEliminar.ClientID %>').show();
        }
        function esconderEliminar() {
            $('#fondoModal').hide();
            $('#<%=modalEliminar.ClientID %>').hide();
        }


        function mostrarCrear() {
            $('#fondoModal').show();
            $('#<%=modalCrear.ClientID%>').show();
        }
        function esconderCrear() {
            $('#fondoModal').hide();
            $('#<%=modalCrear.ClientID%>').hide();
        }

        $(".cerrar").on('click', function () {
            esconderDetalles();
            $('#fondoModal').hide();

            $('#<%=modalEliminar.ClientID %>').hide();
            $('#<%=modalEditar.ClientID %>').hide();
            $('#<%=modalCrear.ClientID%>').hide();
        });

    </script>

</asp:Content>
