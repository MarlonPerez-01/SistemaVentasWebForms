<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Venta.Index" ClientIDMode="Static"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="col">
    
        <h5 class="mt-3 d-block titulo">Listado de Ventas</h5>

        <div class="row mt-2">
            <div class="col text-left">
                <asp:TextBox ID="txtBuscar" CssClass="b-inline-block form-size ml-2 btn-opc down pl-2" runat="server"></asp:TextBox>
                <asp:Button ID="btnBuscar" CssClass="btn b-inline-block btn-small ml-2" runat="server" Text="Buscar" OnClick="btnBuscar_OnClick" />
            </div>

            <div class="col text-right">
                <a href="~/PuntoDeVenta/Index.aspx" class="btn btn-small btn-primary b-inline-block mr-3" runat="server"><span>Crear Venta</span></a>
            </div>

        </div>

         <div class="round-border mt-3">

            <asp:GridView ID="GridView1" CssClass="table table-sm  table-striped text-center" runat="server" AutoGenerateColumns="False" DataKeyNames="idVenta" OnRowCommand="GridView1_OnRowCommand" AllowPaging="True" PageSize="10" OnPageIndexChanging="GridView1_OnPageIndexChanging">
                <Columns>

                    <asp:BoundField DataField="idVenta" HeaderText="ID" />
                    <asp:BoundField DataField="nombreCliente" HeaderText="Cliente" />
                    <asp:BoundField DataField="nombreEmpleado" HeaderText="Empleado" />
                    <asp:BoundField DataField="fechaVenta" HeaderText="Fecha" />
                    <asp:BoundField DataField="horaVenta" HeaderText="Hora" />
                    <asp:BoundField DataField="monto" HeaderText="Monto" />

                    <asp:TemplateField HeaderText="Detalles" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDetalles" runat="server" CommandName="detalles" CommandArgument='<%#Eval("idVenta") %>'><i class="fas fa-search-plus"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Editar" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditar" runat="server" CommandName="editar" CommandArgument='<%#Eval("idVenta") %>'><i class="fas fa-pencil-alt"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Eliminar" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEliminar" runat="server" CommandName="eliminar" CommandArgument='<%#Eval("idVenta") %>'><i class="fas fa-trash-alt"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle CssClass="GridPager prueba" />
            </asp:GridView>

        </div>

        <!--contador de botones para cambiar de index-->

        <div class="mt-3">

            <p class="d-inline-block ml-3 font-weight-light p-size">Han sido encontrados <span id="cantidadVentas" runat="server"></span> registros en la base de datos</p>

            <nav class="d-inline-block text-sm-right move">
                <ul class="pagination">
                    
                    <li class="page-item">
                        <a class="page-link border rounded-circle ml-1" href="#">1</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link border rounded-circle ml-1" href="#">2</a>
                    </li>
                   
                    
                </ul>
            </nav>

        </div>

        <div id="fondoModal"></div>

    </div>

    <!--Inicia Modal Detalles-->
    <asp:Panel ID="modalDetalles" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <h5>Detalles</h5>
                <a style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">

                <div class="round-border mt-3">
                    <asp:GridView ID="GridView2" CssClass="table table-sm  table-striped" runat="server" AutoGenerateColumns="False" DataKeyNames="idDetalleVenta" OnRowCommand="GridView1_OnRowCommand" AllowPaging="True" PageSize="10" OnPageIndexChanging="GridView1_OnPageIndexChanging">
                        <Columns>
                            <asp:BoundField DataField="idDetalleVenta" HeaderText="ID" />
                            <asp:BoundField DataField="nombreProducto" HeaderText="Nombre Producto" />
                            <asp:BoundField DataField="cantidadProducto" HeaderText="Cantidad Producto Vendido" />
                            <asp:BoundField DataField="precio" HeaderText="Precio Venta Unidad" />
                        </Columns>
                    </asp:GridView>
                </div>

            </div>
            <div class="modal-footer-mio text-center mt-3">
                <asp:Button ID="btnImprimir" CssClass="mod btn" CommandName="" runat="server" Text="Imprimir" OnClick="btnImprimir_OnClick" />
                <button type="button" class="mod btn" runat="server" OnServerClick="cerrarTodo">Cerrar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Detalles-->


    <!--Inicia Modal Editar-->
    <asp:Panel ID="modalEditar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Editar Venta</label>
                <a style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                
                
                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpIdVenta_e" class="col-form-label"><i class="fas fa-box-open d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpIdVenta_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="ddlCliente_e" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <asp:DropDownList ID="ddlCliente_e" CssClass="d-inline drop" runat="server"></asp:DropDownList>
                    </div>
                </div>
                
                <div class="mt-4">
                    <div class="d-inline">
                        <label for="ddlEmpleado_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <asp:DropDownList ID="ddlEmpleado_e" CssClass="d-inline drop" runat="server"></asp:DropDownList>
                    </div>
                    <div class="d-inline">
                        <label for="inpFechaVenta" class="col-form-label"><i class="far fa-calendar-alt d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpFechaVenta" runat="server" />
                    </div>
                </div>
                
                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpHoraVenta" class="col-form-label"><i class="far fa-clock d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpHoraVenta" runat="server" />
                    </div>
                </div>

            </div>
            <div class="modal-footer-mio text-center mt-3">
                <asp:Button ID="btnActualizar" CssClass="mod btn" CommandName="" runat="server" Text="Actualizar" OnClick="btnActualizar_OnClick" />
                <button type="button" class="mod btn" runat="server" OnServerClick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Editar-->


    <!--Inicia Modal Eliminar-->
    <asp:Panel ID="modalEliminar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <h5>Eliminar Venta</h5>
                <a style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <label for="lblIdVentaEliminar" class="col-form-label">Está a punto de eliminar la venta con el identificador:</label>
                    <asp:Label ID="lblIdVentaEliminar" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio text-center mt-3">
                <asp:Button ID="btnEliminar" CssClass="mod btn" CommandName="" runat="server" Text="Eliminar" OnClick="btnEliminar_OnClick" />
                <button type="button" class="mod btn" runat="server" OnServerClick="cerrarTodo">Cancelar</button>
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

        .btn-small, .btn-small:hover {
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

        #GridView1 th, #GridView1 td {
            border: none;
        }

        #GridView2 th, #GridView2 td {
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

        .mod, .mod:hover {
            background-color: rgb(119, 100, 228);
            width: 15rem;
            color: white;
            border-radius: 4px;
            border: 1px solid rgb(119, 100, 228);
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

        /*pagination*/

        .prueba tr{
        
            display: none;
        
        }

        /*detalles*/

        #modalDetalles label {
        
            font-weight: bold;
        
        }

        .prueba td {
        
            background-color: white!important;
        
        }

    </style>

    <script type="text/javascript" language="javascript">

        $(".table").attr({
            border: "0",
            cellpadding: "0",
            cellspacing: "0"
        });


        document.addEventListener('DOMContentLoaded', function () {

            $(".pagination li:nth-child(1)").on("click", function () {
                document.querySelector(".prueba td:nth-child(1) a").click();
            });

            $(".pagination li:nth-child(2)").on("click", function () {
                document.querySelector(".prueba td:nth-child(2) a").click();
            });

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

        $(".cerrar").on('click', function () {
            esconderDetalles();
            $('#fondoModal').hide();
            $('#<%=modalDetalles.ClientID %>').hide();
            $('#<%=modalEliminar.ClientID %>').hide();
            $('#<%=modalEditar.ClientID %>').hide();
        });

        //verificacion


        var bFormE = $("#btnActualizar")


        var updaVenta = [$("#inpIdVenta_e"), $("#ddlCliente_e"), $("#ddlEmpleado_e"), $("#inpFechaVenta"),
            $("#inpHoraVenta")]


        bFormE.on("click", function (event) {

            checkInputs(updaVenta);

            if (updaVenta[0].hasClass("fail") || updaVenta[1].hasClass("fail") || updaVenta[2].hasClass("fail") || updaVenta[3].hasClass("fail") || updaVenta[4].hasClass("fail")) {

                event.preventDefault();

            }

        });


        function checkInputs(lista) {


            var id = lista[0];
            var cliente = lista[1];
            var usuario = lista[2];
            var fecha = lista[3];
            var hora = lista[4];



            //verificacion primer nombre

            if (id.val().trim() === '') {
                setErrorFor(id, "id");
            }
            else {
                setSuccessFor(id);
            }

            //verificacion segundo nombre

            if (cliente.val().trim() === '') {
                setErrorFor(cliente, "Cliente");
            }
            else {
                setSuccessFor(cliente);
            }

            //verificacion primer apellido

            if (usuario.val().trim() === '') {
                setErrorFor(usuario, "Usuario");
            }
            else {
                setSuccessFor(usuario);
            }

            // segundo apellido

            if (fecha.val().trim() === '') {
                setErrorFor(fecha, "Fecha");
            }
            else {
                setSuccessFor(fecha);
            }

            // segundo apellido

            if (hora.val().trim() === '') {
                setErrorFor(hora, "Hora");
            }
            else {
                setSuccessFor(hora);
            }



        }

        function setErrorFor(input, message) {
            input.val("");
            input.attr("placeholder", message)
            input.addClass("fail")

        }

        function setSuccessFor(input) {
            input.css("border-color", "#2ecc71")
            input.removeClass("fail").addClass("success")
        }

    </script>
</asp:Content>
