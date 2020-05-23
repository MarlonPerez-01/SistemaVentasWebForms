<%@ Page Title="Cargo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Cargo.Index" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="col">

        <h5 class="mt-3 d-block titulo">Listado de Cargos</h5>


        <div class="row mt-2">

            <div class="col text-left">
                <asp:TextBox ID="txtBuscar" CssClass="b-inline-block form-size ml-2 btn-opc down pl-2" runat="server"></asp:TextBox>
                <asp:Button ID="btnBuscar" CssClass="btn b-inline-block btn-small ml-2" runat="server" Text="Buscar" OnClick="btnBuscar_OnClick" />
            </div>

            <div class="col text-right">
                <asp:LinkButton ID="btnCrearCargo" CssClass="btn btn-small btn-primary b-inline-block mr-3" runat="server" CommandName="crear" CommandArgument='<%#Eval("idCargo") %>' OnClick="btnCrearCargo_OnClick">Crear Cargo</asp:LinkButton>
            </div>

        </div>

        <div class="round-border mt-3">

            <asp:GridView ID="GridView1" CssClass="table table-sm  table-striped text-center" runat="server" AutoGenerateColumns="False" DataKeyNames="idCargo" OnRowCommand="GridView1_OnRowCommand" AllowPaging="True" PageSize="10" OnPageIndexChanging="GridView1_OnPageIndexChanging">
                <Columns>

                    <asp:BoundField DataField="idCargo" HeaderText="ID" SortExpression="idCargo"/>
                    <asp:BoundField DataField="nombreCargo" HeaderText="Cargo" />
                    <asp:BoundField DataField="salarioCargo" HeaderText="Salario" />

                    <asp:TemplateField HeaderText="Detalles" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDetalles" runat="server" CommandName="detalles" CommandArgument='<%#Eval("idCargo") %>'><i class="fas fa-search-plus"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Editar" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditar" runat="server" CommandName="editar" CommandArgument='<%#Eval("idCargo") %>'><i class="fas fa-pencil-alt"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Eliminar" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEliminar" runat="server" CommandName="eliminar" CommandArgument='<%#Eval("idCargo") %>'><i class="fas fa-trash-alt"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

        </div>


        <!--contador de botones para cambiar de index-->

        <div class="mt-3">

            <p class="d-inline-block ml-3 font-weight-light p-size">Han sido encontrados <span id="cantidadCargos" runat="server"></span> registros en la base de datos</p>

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


    </div>

    <div id="fondoModal"></div>

    <!--Inicia Modal Crear-->
    <asp:Panel ID="modalCrear" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <h5>Crear Cargo</h5>
                <a id="cerrarCrearX" style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo"></a>
            </div>
            <div class="modal-body-mio text-center">
                
                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpNombreCargo_c" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" placeholder="Cargo" class="form-control d-inline" id="inpNombreCargo_c" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpSalarioCargo_c" class="col-form-label"><i class="far fa-money-bill-alt d-inline mx-2"></i></label>
                        <input type="text" placeholder="Salario" class="form-control d-inline" id="inpSalarioCargo_c" runat="server" />
                    </div>
                </div>
                
            </div>
            <div>
                <div class="modal-footer-mio text-center mt-3">
                    <asp:Button ID="btnCrear" CssClass="mod btn" CommandName="Crear" runat="server" Text="Crear" OnClick="btnCrear_OnClick" />
                    <button type="button" class="mod btn" id="cerrarCrear" runat="server" OnServerClick="cerrarTodo">Cancelar</button>
                </div>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Crear-->


    <!--Inicia Modal Detalles-->
    <asp:Panel ID="modalDetalles" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <h5>Detalles Cargos</h5>
                <a style="float: right; text-decoration: none" runat="server" id="cerrarDetallesX" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div style="display: none">
                    <label>ID:</label>
                    <asp:Label ID="lblIdCargo" runat="server"></asp:Label>
                </div>
                <div>
                    <label>Nombre:</label>
                    <asp:Label ID="lblNombreCargo" runat="server"></asp:Label>
                </div>
                <div>
                    <label>Salario:</label>
                    <asp:Label ID="lblSalarioCargo" runat="server"></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio text-center mt-3">
                <asp:Button ID="btnImprimir" CssClass="mod btn" runat="server" Text="Imprimir" />
                <button type="button" class="mod btn" id="cerrarDetalles" runat="server" OnServerClick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Detalles-->


    <!--Inicia Modal Editar-->
    <asp:Panel ID="modalEditar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <h5>Editar Cargo</h5>
                <a id="cerrarEditarX" style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">


                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpIdCargo_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpIdCargo_e" runat="server" readonly="readonly"/>
                    </div>
                    <div class="d-inline">
                        <label for="inpNombreCargo_e" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpNombreCargo_e" runat="server" placeholder="Cargo"/>
                    </div>
                </div>


                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpSalarioCargo_e" class="col-form-label"><i class="far fa-money-bill-alt d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpSalarioCargo_e" runat="server" placeholder="Salario"/>
                    </div>
                </div>


            </div>
            <div class="modal-footer-mio text-center mt-3">
                <asp:Button ID="btnActualizar" CssClass="mod btn" CommandName="" runat="server" Text="Actualizar" OnClick="btnActualizar_OnClick" />
                <button type="button" class="mod btn" id="cerrarEditar" runat="server" OnServerClick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Editar-->


    <!--Inicia Modal Eliminar-->
    <asp:Panel ID="modalEliminar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <h5>Eliminar Cargo</h5>
                <a id="cerrarEliminarX" style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <label for="lblIdCargoEliminar" class="col-form-label">Está a punto de eliminar el cargo con el identificador:</label>
                    <asp:Label ID="lblIdCargoEliminar" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio text-center mt-3">
                <asp:Button ID="btnEliminar" CssClass="mod btn" CommandName="" runat="server" Text="Eliminar" OnClick="btnEliminar_OnClick" />
                <button type="button" class="mod btn" id="cerrarEliminar" runat="server" OnServerClick="cerrarTodo">Cancelar</button>
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


        var crearCargo = [$("#inpNombreCargo_c"), $("#inpSalarioCargo_c")]


        var updaCargo = [$("#inpNombreCargo_e"), $("#inpSalarioCargo_e"), $("#inpIdCargo_e")]

        bForm.on("click", function (event) {

            checkInputs(crearCargo);

            if (crearCargo[0].hasClass("fail") || crearCargo[1].hasClass("fail")) {

                event.preventDefault();

            }

        });


        bFormE.on("click", function (event) {

            checkInputs(updaCargo);

            if (updaCargo[0].hasClass("fail") || updaCargo[1].hasClass("fail") || updaCargo[2].hasClass("fail")) {

                event.preventDefault();

            }

        });


        function checkInputs(lista) {


            var nombre = lista[0];
            var salario = lista[1]
            var id = lista[2];






            //verificacion primer nombre

            if (nombre.val().trim() === '') {
                setErrorFor(nombre, "Categoria");
            }
            else {
                setSuccessFor(nombre);
            }


            //salario

            if (isGr(salario.val().trim())) {

                setSuccessFor(salario);

            }

            else if (salario.val().trim() === '') {
                setErrorFor(salario, "salario");
            }

            else {
                setErrorFor(salario, "El salario es muy bajo");
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


        function isGr(s) {

            s = parseInt(s);

            if (s > 300) {
                return true
            }
            else {
                return false
            }
        }




    </script>
</asp:Content>