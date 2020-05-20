<%@ Page Title="Compra" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaCompras.Compra.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="col">

        <h5 class="mt-3 d-block titulo">Listado de Compras</h5>

        <div class="row mt-2">

            <div class="col text-left">
                <asp:TextBox ID="txtBuscar" CssClass="b-inline-block form-size ml-2 btn-opc down pl-2" runat="server"></asp:TextBox>
                <asp:Button ID="btnBuscar" CssClass="btn b-inline-block btn-small ml-2" runat="server" Text="Buscar" OnClick="btnBuscar_OnClick" />
            </div>

            <div class="col text-right">
                <a href="~/PuntoDeCompra/Index.aspx" class="btn btn-small btn-primary b-inline-block mr-3" runat="server"><span>Crear Compra</span></a>
            </div>

        </div>

        <div class="round-border mt-3">

            <asp:GridView ID="GridView1" CssClass="table table-sm  table-striped text-center" runat="server" AutoGenerateColumns="False" DataKeyNames="idCompra" OnRowCommand="GridView1_OnRowCommand" AllowPaging="True" PageSize="10" OnPageIndexChanging="GridView1_OnPageIndexChanging">
                <Columns>

                    <asp:BoundField DataField="idCompra" HeaderText="ID" />
                    <asp:BoundField DataField="nombreProveedor" HeaderText="Proveedor" />
                    <asp:BoundField DataField="nombreEmpleado" HeaderText="Empleado" />
                    <asp:BoundField DataField="fechaCompra" HeaderText="Fecha" />
                    <asp:BoundField DataField="horaCompra" HeaderText="Hora" />
                    <asp:BoundField DataField="monto" HeaderText="Monto" />

                    <asp:TemplateField HeaderText="Detalles" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDetalles" runat="server" CommandName="detalles" CommandArgument='<%#Eval("idCompra") %>'><i class="fas fa-search-plus"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Editar" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditar" runat="server" CommandName="editar" CommandArgument='<%#Eval("idCompra") %>'><i class="fas fa-pencil-alt"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Eliminar" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEliminar" runat="server" CommandName="eliminar" CommandArgument='<%#Eval("idCompra") %>'><i class="fas fa-trash-alt"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

        </div>


        <!--contador de botones para cambiar de index-->

        <div class="mt-3">

            <p class="d-inline-block ml-3 font-weight-light p-size">Han sido encontrados <span id="cantidadCompras" runat="server"></span> registros en la base de datos</p>

            <nav class="d-inline-block text-sm-right move">
                <ul class="pagination">
                    <li class="page-item">
                        <a class="page-link border rounded-circle" href="#">
                            <span>&laquo;</span>
                            <span class="sr-only">Previous</span>
                        </a>
                    </li>
                    <li class="page-item">
                        <a class="page-link border rounded-circle ml-1" href="#">1</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link border rounded-circle ml-1" href="#">2</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link border rounded-circle mx-1" href="#">3</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link border rounded-circle" href="#">
                            <span>&raquo;</span>
                            <span class="sr-only">Next</span>
                        </a>
                    </li>
                </ul>
            </nav>

        </div>


    </div>

    <div id="fondoModal"></div>

    <!--Inicia Modal Detalles-->
    <asp:Panel ID="modalDetalles" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 60%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Detalles</label>
                <a style="float: right; text-decoration: none" runat="server" onserverclick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">

                <div class="round-border mt-3">
                    <asp:GridView ID="GridView2" CssClass="table table-sm  table-striped" runat="server" AutoGenerateColumns="False" DataKeyNames="idDetalleCompra" OnRowCommand="GridView1_OnRowCommand" OnPageIndexChanging="GridView1_OnPageIndexChanging">
                        <Columns>
                            <asp:BoundField DataField="idDetalleCompra" HeaderText="ID" />
                            <asp:BoundField DataField="nombreProducto" HeaderText="Nombre Producto" />
                            <asp:BoundField DataField="cantidadProductoComprado" HeaderText="Cantidad Producto Comprado" />
                            <asp:BoundField DataField="precioCompraUnidad" HeaderText="Precio Compra Unidad" />
                            <asp:BoundField DataField="precioCompraUnidad" HeaderText="Precio Compra Unidad" />
                            <asp:BoundField DataField="observaciones" HeaderText="observaciones" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <div class="modal-footer-mio text-center mt-3">
                <asp:Button ID="btnImprimir" CssClass="mod" CommandName="" runat="server" Text="Imprimir" OnClick="btnImprimir_OnClick" />
                <button type="button" class="mod" runat="server" onserverclick="cerrarTodo">Cerrar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Detalles-->


    <!--Inicia Modal Editar-->
    <asp:Panel ID="modalEditar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Editar Compra</label>
                <a style="float: right; text-decoration: none" runat="server" onserverclick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">


                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpIdCompra_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpIdCompra_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpPrimerNombreCompra_e" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <asp:DropDownList ID="ddlProveedor_e" CssClass="d-inline drop" runat="server"></asp:DropDownList>
                    </div>
                </div>

                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpSegundoNombreCompra_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <asp:DropDownList ID="ddlUsuario_e" CssClass="d-inline drop" runat="server"></asp:DropDownList>
                    </div>
                    <div class="d-inline">
                        <label for="inpFechaCompra" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpFechaCompra" runat="server" />
                    </div>
                </div>


                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpHoraCompra" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpHoraCompra" runat="server" />
                    </div>
                </div>



            </div>
            <div class="modal-footer-mio text-center mt-3">
                <asp:Button ID="btnActualizar" CssClass="mod" CommandName="" runat="server" Text="Actualizar" OnClick="btnActualizar_OnClick" />
                <button type="button" class="mod" runat="server" onserverclick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Editar-->


    <!--Inicia Modal Eliminar-->
    <asp:Panel ID="modalEliminar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Eliminar Compra</label>
                <a style="float: right; text-decoration: none" runat="server" onserverclick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <label for="lblIdCompraEliminar" class="col-form-label">Está a punto de eliminar la compra con el identificador:</label>
                    <asp:Label ID="lblIdCompraEliminar" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio text-center">
                <asp:Button ID="Button1" CssClass="mod" CommandName="" runat="server" Text="Eliminar" OnClick="btnEliminar_OnClick" />
                <button type="button" class="mod" runat="server" onserverclick="cerrarTodo">Cancelar</button>
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
            font-size: 0.7rem;
            width: 8rem;
            color: white;
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

        #MainContent_GridView1 th, #MainContent_GridView1 td {
            border: none;
        }

        #MainContent_GridView2 th, #MainContent_GridView2 td {
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
            border-color: #ced4da;
            color: #495057;
        }


        .success {
            border-color: #2ecc71;
        }

        .fail {
            border-color: #e74c3c;
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
            $('#<%=modalDetalles.ClientID %>').show();
        }
        function esconderDetalles() {
            $('#fondoModal').hide();
            $('#<%=modalDetalles.ClientID %>').hide();
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
    </script>
</asp:Content>
