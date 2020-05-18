<%@ Page Title="Cliente" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Cliente.Index" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="col">

        <h5 class="mt-3 d-block titulo">Listado de Clientes</h5>

        <div class="row mt-2">
            <div class="col text-left">
                <asp:TextBox ID="txtBuscar" CssClass="b-inline-block form-size ml-2 btn-opc down pl-2" runat="server"></asp:TextBox>
                <asp:Button ID="btnBuscar" CssClass="btn b-inline-block btn-small ml-2" runat="server" Text="Buscar" OnClick="btnBuscar_OnClick" />
            </div>

            <div class="col text-right">
                <asp:LinkButton ID="btnCrearCliente" CssClass="btn btn-small btn-primary b-inline-block mr-3" runat="server" CommandName="crear" CommandArgument='<%#Eval("idCliente") %>' OnClick="btnCrearCliente_OnClick">Crear Cliente</asp:LinkButton>
            </div>

        </div>



        <div class="round-border mt-3">

            <asp:GridView ID="GridView1" CssClass="table table-sm  table-striped text-center" runat="server" AutoGenerateColumns="False" DataKeyNames="idCliente" OnRowCommand="GridView1_OnRowCommand" AllowPaging="True" PageSize="20" OnPageIndexChanging="GridView1_OnPageIndexChanging">
                <Columns>

                    <asp:BoundField DataField="idCliente" HeaderText="ID" />
                    <asp:BoundField DataField="primerNombreCliente" HeaderText="Primer Nombre" />
                    <asp:BoundField DataField="segundoNombreCliente" HeaderText="Segundo Nombre" />
                    <asp:BoundField DataField="primerApellidoCliente" HeaderText="Primer Apellido" />
                    <asp:BoundField DataField="segundoApellidoCliente" HeaderText="Segundo Apellido" />
                    <asp:BoundField DataField="duiCliente" HeaderText="DUI" />
                    <asp:BoundField DataField="nitCliente" HeaderText="NIT" />
                    <asp:BoundField DataField="telefonoCliente" HeaderText="Telefono Cliente" />

                    <asp:TemplateField HeaderText="Detalles" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDetalles" runat="server" CommandName="detalles" CommandArgument='<%#Eval("idCliente") %>'><i class="fas fa-search-plus"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Editar" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditar" runat="server" CommandName="editar" CommandArgument='<%#Eval("idCliente") %>'><i class="fas fa-pencil-alt"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Eliminar" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEliminar" runat="server" CommandName="eliminar" CommandArgument='<%#Eval("idCliente") %>'><i class="fas fa-trash-alt"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>

        </div>

        <!--contador de botones para cambiar de index-->

        <div class="mt-3">

            <p class="d-inline-block ml-3 font-weight-light p-size">Han sido encontrados <span id="cantidadClientes" runat="server"></span> registros en la base de datos</p>

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
    <!--Inicia Modal Crear-->
    <asp:Panel ID="modalCrear" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio">
                <label>Crear Cliente</label>
                <a style="float: right; text-decoration: none" runat="server" onserverclick="cerrarTodo">X</a>
            </div>

            <div class="modal-body-mio text-center">

                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpPrimerNombreCliente_c" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" placeholder="Primer nombre" class="form-control d-inline" id="inpPrimerNombreCliente_c" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpSegundoNombreCliente_c" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" placeholder="Segundo nombre" class="form-control d-inline" id="inpSegundoNombreCliente_c" runat="server" />
                    </div>
                </div>


                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpPrimerApellidoCliente_c" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" placeholder="Primer apellido" class="form-control d-inline" id="inpPrimerApellidoCliente_c" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpSegundoApellidoCliente_c" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" placeholder="Segundo apellido" class="form-control d-inline" id="inpSegundoApellidoCliente_c" runat="server" />
                    </div>
                </div>


                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpDuiCliente_c" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" placeholder="DUI" class="form-control d-inline" id="inpDuiCliente_c" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpNitCliente_c" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" placeholder="NIT" class="form-control d-inline" id="inpNitCliente_c" runat="server" />
                    </div>
                </div>

                <div class="mt-4">
                    <label for="inpTelefonoCliente_c" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                    <input type="text" placeholder="Telefono" class="form-control d-inline" id="inpTelefonoCliente_c" runat="server" />
                </div>

            </div>


            <div class="modal-footer-mio mt-5 text-center">
                <asp:Button ID="btnCrear" CssClass="mod d-inline" CommandName="Crear" runat="server" Text="Crear" OnClick="btnCrear_OnClick" />
                <button type="button" class="mod" runat="server" onserverclick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Crear-->


    <!--Inicia Modal Detalles-->
    <asp:Panel ID="modalDetalles" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Detalles Clientes</label>
                <a style="float: right; text-decoration: none" runat="server" onserverclick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <label>ID:</label>
                    <asp:Label ID="lblIdCliente" runat="server"></asp:Label>
                </div>
                <div>
                    <label>Primer Nombre:</label>
                    <asp:Label ID="lblPrimerNombreCliente" runat="server"></asp:Label>
                </div>
                <div>
                    <label>Segundo Nombre:</label>
                    <asp:Label ID="lblSegundoNombreCliente" runat="server"></asp:Label>
                </div>
                <div>
                    <label>Primer Apellido:</label>
                    <asp:Label ID="lblPrimerApellidoCliente" runat="server"></asp:Label>
                </div>
                <div>
                    <label>Segundo Apellido:</label>
                    <asp:Label ID="lblSegundoApellidoCliente" runat="server"></asp:Label>
                </div>
                <div>
                    <label>DUI:</label>
                    <asp:Label ID="lblDuiCliente" runat="server"></asp:Label>
                </div>
                <div>
                    <label>NIT:</label>
                    <asp:Label ID="lblNitCliente" runat="server"></asp:Label>
                </div>
                <div>
                    <label>Telefono:</label>
                    <asp:Label ID="lblTelefonoCliente" runat="server"></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio text-center">
                <asp:Button ID="btnImprimir" CssClass="mod" runat="server" Text="Imprimir" />
                <button type="button" class="mod" runat="server" onserverclick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Detalles-->


    <!--Inicia Modal Editar-->
    <asp:Panel ID="modalEditar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Editar Cliente</label>
                <a style="float: right; text-decoration: none" runat="server" onserverclick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">

                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpIdCliente_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpIdCliente_e" runat="server" readonly="readonly" />
                    </div>
                    <div class="d-inline">
                        <label for="inpPrimerNombreCliente_e" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpPrimerNombreCliente_e" runat="server" />
                    </div>
                </div>

                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpSegundoNombreCliente_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpSegundoNombreCliente_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpPrimerApellidoCliente_e" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpPrimerApellidoCliente_e" runat="server" />
                    </div>
                </div>


                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpSegundoApellidoCliente_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpSegundoApellidoCliente_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpDuiCliente_e" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpDuiCliente_e" runat="server" />
                    </div>
                </div>

                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpNitCliente_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpNitCliente_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpTelefonoCliente_e" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpTelefonoCliente_e" runat="server" />
                    </div>
                </div>

            </div>
            <div class="modal-footer-mio text-center mt-4">
                <asp:Button ID="btnActualizar" CssClass="mod" CommandName="" runat="server" Text="Actualizar" OnClick="btnActualizar_OnClick" />
                <button type="button" class="mod" runat="server" onserverclick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Editar-->


    <!--Inicia Modal Eliminar-->
    <asp:Panel ID="modalEliminar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor text-center">
            <div class="modal-header-mio">
                <label>Eliminar Cliente</label>
                <a style="float: right; text-decoration: none" runat="server" onserverclick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <label for="lblIdClienteEliminar" class="col-form-label">Está a punto de eliminar el cliente con el identificador:</label>
                    <asp:Label ID="lblIdClienteEliminar" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio text-center">
                <asp:Button ID="btnEliminar" CssClass="mod" CommandName="" runat="server" Text="Eliminar" OnClick="btnEliminar_OnClick" />
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


        function mostrarCrear() {
            $('#fondoModal').show();
            $('#<%=modalCrear.ClientID%>').show();
        }
        function esconderCrear() {
            $('#fondoModal').hide();
            $('#<%=modalCrear.ClientID%>').hide();
        }


        //verificacion

        var bForm = $("#btnCrear");
        var bFormE = $("#btnActualizar")


        var crearCliente = [$("#inpPrimerNombreCliente_c"), $("#inpSegundoNombreCliente_c"), $("#inpPrimerApellidoCliente_c"), $("#inpSegundoApellidoCliente_c"),
        $("#inpDuiCliente_c"), $("#inpNitCliente_c"), $("#inpTelefonoCliente_c")]


        var updaCliente = [$("#inpPrimerNombreCliente_e"), $("#inpSegundoNombreCliente_e"), $("#inpPrimerApellidoCliente_e"), $("#inpSegundoApellidoCliente_e"),
        $("#inpDuiCliente_e"), $("#inpNitCliente_e"), $("#inpTelefonoCliente_e"), $("#inpIdCliente_e")]

        bForm.on("click", function (event) {

            checkInputs(crearCliente);

            if (crearCliente[0].hasClass("fail") || crearCliente[1].hasClass("fail") || crearCliente[2].hasClass("fail") || crearCliente[3].hasClass("fail") || crearCliente[4].hasClass("fail") || crearCliente[5].hasClass("fail") || crearCliente[6].hasClass("fail") || crearCliente[7].hasClass("fail")) {

                event.preventDefault();

            }

        });


        bFormE.on("click", function (event) {

            checkInputs(updaCliente);

            if (updaCliente[0].hasClass("fail") || updaCliente[1].hasClass("fail") || updaCliente[2].hasClass("fail") || updaCliente[3].hasClass("fail") || updaCliente[4].hasClass("fail") || updaCliente[5].hasClass("fail") || updaCliente[6].hasClass("fail") || updaCliente[7].hasClass("fail") || updaCliente[8].hasClass("fail")) {

                event.preventDefault();

            }

        });


        function checkInputs(lista, e) {


            var pNombre = lista[0];
            var sNombre = lista[1];
            var pApell = lista[2];
            var sApell = lista[3];
            var dui = lista[4];
            var nit = lista[5];
            var telefono = lista[6];
            var id = lista[7];


            /*esto da problemas

            if (id.val().trim() === '') {
                setErrorFor(id, "campo obligatorio");
            }
            else {
                setSuccessFor(id);
            }*/


            //verificacion primer nombre

            if (pNombre.val().trim() === '') {
                setErrorFor(pNombre, "campo obligatorio");
            }
            else {
                setSuccessFor(pNombre);
            }

            //verificacion segundo nombre

            if (sNombre.val().trim() === '') {
                setErrorFor(sNombre, "campo obligatorio");
            }
            else {
                setSuccessFor(sNombre);
            }

            //verificacion primer apellido

            if (pApell.val().trim() === '') {
                setErrorFor(pApell, "campo obligatorio");
            }
            else {
                setSuccessFor(pApell);
            }

            // segundo apellido

            if (sApell.val().trim() === '') {
                setErrorFor(sApell, "campo obligatorio");
            }
            else {
                setSuccessFor(sApell);
            }

            //dui

            if (isDui(dui.val().trim())) {

                setSuccessFor(dui);

            }

            else if (dui.val().trim() === '') {
                setErrorFor(dui, "campo obligatorio");
            }

            else {
                setErrorFor(dui, "dui invalido");
            }

            //nit

            if (isNit(nit.val().trim())) {

                setSuccessFor(nit);

            }
            else if (nit.val().trim() === '') {
                setErrorFor(nit, "campo obligatorio");
            }

            else {
                setErrorFor(nit, "nit invalido");
            }

            //telefono

            if (isPho(telefono.val().trim())) {

                setSuccessFor(telefono);

            }
            else if (telefono.val().trim() === '') {
                setErrorFor(telefono, "campo obligatorio");
            }
            else {
                setErrorFor(telefono, "telefono invalido");
            }


            // una vez se verifica todo (si uno de los elementos tiene la clase fail no se envia la form)



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

        function isDui(d) {
            //aqui va la regrex para dui
            return /^\d{8}-\d{1}$/.test(d)
        }

        function isNit(n) {
            //aqui va la regrex para nit
            return /^\d{8}$/.test(n)
        }

        function isPho(p) {
            //aqui va la regrex para nit
            return /^[2-7]-?\d{7}$/.test(p)
        }

    </script>

</asp:Content>
