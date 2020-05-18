<%@ Page Title="Proveedor" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Proveedor.Index" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    
    <div class="col">

        <h5 class="mt-3 d-block titulo">Listado de Proveedor</h5>

         <div class="row mt-2">

            <div class="col text-left">
                <asp:TextBox ID="txtBuscar" CssClass="b-inline-block form-size ml-2 btn-opc down pl-2" runat="server"></asp:TextBox>
                <asp:Button ID="btnBuscar" CssClass="btn b-inline-block btn-small ml-2" runat="server" Text="Buscar" OnClick="btnBuscar_OnClick" />
            </div>
        
            <div class="col text-right">
                <asp:LinkButton ID="btnCrearProveedor" CssClass="btn btn-small btn-primary b-inline-block mr-3" runat="server" CommandName="crear" CommandArgument='<%#Eval("idProveedor") %>' OnClick="btnCrearProveedor_OnClick">Crear Proveedor</asp:LinkButton>
            </div>

        </div>

        <div class="round-border mt-3">
            <asp:GridView ID="GridView1" CssClass="table table-sm  table-striped text-center" runat="server" AutoGenerateColumns="False" DataKeyNames="idProveedor" OnRowCommand="GridView1_OnRowCommand" AllowPaging="True" PageSize="20" OnPageIndexChanging="GridView1_OnPageIndexChanging">
                <Columns>
                    <asp:BoundField DataField="idProveedor" HeaderText="ID" />
                    <asp:BoundField DataField="primerNombreProveedor" HeaderText="Primer Nombre" />
                    <asp:BoundField DataField="segundoNombreProveedor" HeaderText="Segundo Nombre" />
                    <asp:BoundField DataField="primerApellidoProveedor" HeaderText="Primer Apellido" />
                    <asp:BoundField DataField="segundoApellidoProveedor" HeaderText="Segundo Apellido" />
                    <asp:BoundField DataField="empresaProveedor" HeaderText="Empresa" />
                    <asp:BoundField DataField="telefonoProveedor" HeaderText="Teléfono" />

                    <asp:TemplateField HeaderText="Detalles" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDetalles" runat="server" CommandName="detalles" CommandArgument='<%#Eval("idProveedor") %>'><i class="fas fa-search-plus"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Editar" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditar" runat="server" CommandName="editar" CommandArgument='<%#Eval("idProveedor") %>'><i class="fas fa-pencil-alt"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Eliminar" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEliminar" runat="server" CommandName="eliminar" CommandArgument='<%#Eval("idProveedor") %>'><i class="fas fa-trash-alt"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>


        <!--contador de botones para cambiar de index-->

        <div class="mt-3">

            <p class="d-inline-block ml-3 font-weight-light p-size">Mostrando del 1 al 10 de 100 clientes</p>

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
            <div class="modal-header-mio text-center">
                <label>Crear Proveedor</label>
                <a style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                
                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpPrimerNombreProveedor_c" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" placeholder="Primer nombre" class="form-control d-inline" id="inpPrimerNombreProveedor_c" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpSegundoNombreProveedor_c" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" placeholder="Segundo nombre" class="form-control d-inline" id="inpSegundoNombreProveedor_c" runat="server" />
                    </div>
                </div>
                
                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpPrimerApellidoProveedor_c" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" placeholder="Primer apellido" class="form-control d-inline" id="inpPrimerApellidoProveedor_c" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpSegundoApellidoProveedor_c" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" placeholder="Segundo apellido" class="form-control d-inline" id="inpSegundoApellidoProveedor_c" runat="server" />
                    </div>
                </div>
                
                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpEmpresaProveedor_c" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" placeholder="Empresa" class="form-control d-inline" id="inpEmpresaProveedor_c" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpTelefonoProveedor_c" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" placeholder="Telefono" class="form-control d-inline" id="inpTelefonoProveedor_c" runat="server" />
                    </div>
                </div>
            
            </div>
            <div class="modal-footer-mio text-center  mt-4">
                <asp:Button ID="btnCrear" CssClass="mod" CommandName="Crear" runat="server" Text="Crear" OnClick="btnCrear_OnClick" />
                <button type="button" class="mod" runat="server" OnServerClick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Crear-->


    <!--Inicia Modal Detalles-->
    <asp:Panel ID="modalDetalles" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Detalles Proveedor</label>
                <a style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <label>ID:</label>
                    <asp:Label ID="lblIdProveedor" runat="server"></asp:Label>
                </div>
                <div>
                    <label>Primer Nombre:</label>
                    <asp:Label ID="lblPrimerNombreProveedor" runat="server"></asp:Label>
                </div>
                <div>
                    <label>Segundo Nombre:</label>
                    <asp:Label ID="lblSegundoNombreProveedor" runat="server"></asp:Label>
                </div>
                <div>
                    <label>Primer Apellido:</label>
                    <asp:Label ID="lblPrimerApellidoProveedor" runat="server"></asp:Label>
                </div>
                <div>
                    <label>Segundo Apellido:</label>
                    <asp:Label ID="lblSegundoApellidoProveedor" runat="server"></asp:Label>
                </div>
                <div>
                    <label>Telefono:</label>
                    <asp:Label ID="lblTelefonoProveedor" runat="server"></asp:Label>
                </div>
                <div>
                    <label>Empresa:</label>
                    <asp:Label ID="lblEmpresaProveedor" runat="server"></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio text-center mt-3">
                <asp:Button ID="btnImprimir" CssClass="mod" runat="server" Text="Imprimir" />
                <button type="button" class="mod" runat="server" OnServerClick="cerrarTodo">Cerrar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Detalles-->


    <!--Inicia Modal Editar-->
    <asp:Panel ID="modalEditar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Editar Proveedor</label>
                <a style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                
                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpIdProveedor_e" class="col-form-label">Id:</label>
                        <input type="text" class="form-control d-inline" id="inpIdProveedor_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpPrimerNombreProveedor_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpPrimerNombreProveedor_e" runat="server" />
                    </div>
                </div>
                
                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpSegundoNombreProveedor_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpSegundoNombreProveedor_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpPrimerApellidoProveedor_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpPrimerApellidoProveedor_e" runat="server" />
                    </div>
                </div>
                
                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpSegundoApellidoProveedor_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpSegundoApellidoProveedor_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpTelefonoProveedor_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpTelefonoProveedor_e" runat="server" />
                    </div>
                </div>
                
                <div class="mt-4">
                    <label for="inpEmpresaProveedor_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                    <input type="text" class="form-control d-inline" id="inpEmpresaProveedor_e" runat="server" />
                </div>

            </div>
            <div class="modal-footer-mio text-center mt-4">
                <asp:Button ID="btnActualizar" CssClass="mod" CommandName="" runat="server" Text="Actualizar" OnClick="btnActualizar_OnClick" />
                <button type="button" class="mod" runat="server" OnServerClick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Editar-->


    <!--Inicia Modal Eliminar-->
    <asp:Panel ID="modalEliminar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Eliminar Proveedor</label>
                <a style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <label for="lblIdProveedorEliminar" class="col-form-label">Está a punto de eliminar el proveedor con el identificador:</label>
                    <asp:Label ID="lblIdProveedorEliminar" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio text-center mt-3">
                <asp:Button ID="btnEliminar" CssClass="mod" CommandName="" runat="server" Text="Eliminar" OnClick="btnEliminar_OnClick" />
                <button type="button" class="mod" runat="server" OnServerClick="cerrarTodo">Cancelar</button>
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
            background-color: rgb(119, 100, 228)!important;
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

        /*dropdowns*/

       .drop {
       
           border-radius: 5px;
           width: 18rem;
           height: 2.4rem; 
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
            $('#<%=modalDetalles.ClientID %>').hide();
            $('#<%=modalEliminar.ClientID %>').hide();
            $('#<%=modalEditar.ClientID %>').hide();
            $('#<%=modalCrear.ClientID%>').hide();
        });

        //verificacion

        var bForm = $("#btnCrear");
        var bFormE = $("#btnActualizar")


        var crearProve = [$("#inpPrimerNombreProveedor_c"), $("#inpSegundoNombreProveedor_c"), $("#inpPrimerApellidoProveedor_c"), $("#inpSegundoApellidoProveedor_c"),
        $("#inpEmpresaProveedor_c"), $("#inpTelefonoProveedor_c")]


        var updaProve = [$("#inpPrimerNombreProveedor_e"), $("#inpSegundoNombreProveedor_e"), $("#inpPrimerApellidoProveedor_e"), $("#inpSegundoApellidoProveedor_e"),
        $("#inpEmpresaProveedor_e"), $("#inpTelefonoProveedor_e"), $("#inpIdProveedor_e")]

        bForm.on("click", function (event) {

            checkInputs(crearProve);

            if (crearProve[0].hasClass("fail") || crearProve[1].hasClass("fail") || crearProve[2].hasClass("fail") || crearProve[3].hasClass("fail") || crearProve[4].hasClass("fail") || crearProve[5].hasClass("fail") || crearProve[6].hasClass("fail") || crearProve[7].hasClass("fail")) {

                event.preventDefault();

            }

        });


        bFormE.on("click", function (event) {

            checkInputs(updaProve);

            if (updaProve[0].hasClass("fail") || updaProve[1].hasClass("fail") || updaProve[2].hasClass("fail") || updaProve[3].hasClass("fail") || updaProve[4].hasClass("fail") || updaProve[5].hasClass("fail") || updaProve[6].hasClass("fail") || updaProve[7].hasClass("fail") || updaProve[8].hasClass("fail")) {

                event.preventDefault();

            }

        });


        function checkInputs(lista) {


            var pNombre = lista[0];
            var sNombre = lista[1];
            var pApell = lista[2];
            var sApell = lista[3];
            var empresa = lista[4];
            var telefono = lista[5];






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

            //empresa

            if (empresa.val().trim() === '') {
                setErrorFor(empresa, "campo obligatorio");
            }

            else {
                setSuccessFor(empresa);
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
