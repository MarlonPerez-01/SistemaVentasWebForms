<%@ Page Title="Usuario" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Usuario.Index" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    

    <div class="col">
    
        <h5 class="mt-3 d-block titulo">Listado de Usuarios</h5>
    
        <div class="row mt-2">
            <div class="col text-left">
                <asp:TextBox ID="txtBuscar" CssClass="b-inline-block form-size ml-2 btn-opc down pl-2" runat="server"></asp:TextBox>
                <asp:Button ID="btnBuscar" CssClass="btn b-inline-block btn-small ml-2" runat="server" Text="Buscar" OnClick="btnBuscar_OnClick"/>
            </div>

            <div class="col text-right">
                <asp:LinkButton ID="btnCrearUsuario" CssClass="btn btn-small btn-primary b-inline-block mr-3" runat="server" CommandName="crear" CommandArgument='<%#Eval("idUsuario") %>' OnClick="btnCrearUsuario_Click">Crear Usuario</asp:LinkButton>
            </div>
        </div>
    
        <div class="round-border mt-3">
            <asp:GridView ID="GridView1" CssClass="table table-sm  table-striped text-center" runat="server" AutoGenerateColumns="False" DataKeyNames="idUsuario" OnRowCommand="GridView1_OnRowCommand" AllowPaging="True" PageSize="10" OnPageIndexChanging="GridView1_OnPageIndexChanging">
                <Columns>
                    <asp:BoundField DataField="idUsuario" HeaderText="ID" />
                    <asp:BoundField DataField="nombreUsuario" HeaderText="Nombre de Usuario" />
                    <asp:BoundField DataField="nombreEmpleado" HeaderText="Empleado" />
                    <asp:BoundField DataField="nombreTipoUsuario" HeaderText="Tipo de Usuario" />

                    <asp:TemplateField HeaderText="Detalles" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDetalles" runat="server" CommandName="detalles" CommandArgument='<%#Eval("idUsuario") %>'><i class="fas fa-search-plus"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Editar" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditar" runat="server" CommandName="editar" CommandArgument='<%#Eval("idUsuario") %>'><i class="fas fa-pencil-alt"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Eliminar" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEliminar" runat="server" CommandName="eliminar" CommandArgument='<%#Eval("idUsuario") %>'><i class="fas fa-trash-alt"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>


        <!--contador de botones para cambiar de index-->

        <div class="mt-3">

            <p class="d-inline-block ml-3 font-weight-light p-size">Han sido encontrados <label id="cantidadUsuarios" runat="server"></label> registros en la base de datos</p>

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
    <asp:Panel ID="modalDetalles" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Detalles Usuarios</label>
                <a style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <label>ID:</label>
                    <asp:Label ID="lblIdUsuario" runat="server"></asp:Label>
                </div>
                <div>
                    <label>Nombre Usuario:</label>
                    <asp:Label ID="lblNombreUsuario" runat="server"></asp:Label>
                </div>
                <div>
                    <label>Nombre Empleado:</label>
                    <asp:Label ID="lblNombreEmpleado" runat="server"></asp:Label>
                </div>
                <div>
                    <label>Tipo Usuario:</label>
                    <asp:Label ID="lblTipoUsuario" runat="server"></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio text-center mt-3">
                <asp:Button ID="btnImprimir" CssClass="mod" runat="server" Text="Imprimir" />
                <button type="button" class="mod" runat="server" OnServerClick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Detalles-->
    

    <!--Inicia Modal Editar-->
    <asp:Panel ID="modalEditar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Editar Usuario</label>
                <a style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                
                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpIdUsuario_e"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpIdUsuario_e" runat="server" readonly="readonly"/>
                    </div>
                    <div class="d-inline">
                        <label for="inpEmpleado_e"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpEmpleado_e" runat="server" readonly="readonly"/>
                    </div>
                </div>
                
                <div class="mt-4">
                    <div class="d-inline">
                        <label for="ddlTipoUsuario_e"><i class="far fa-user d-inline mr-2"></i></label>
                        <asp:DropDownList ID="ddlTipoUsuario_e" CssClass="d-inline drop" runat="server"></asp:DropDownList>
                    </div>
                    <div class="d-inline">
                        <label for="inpNombreUsuario_e"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpNombreUsuario_e" runat="server" />
                    </div>
                </div>
            
                <div class="mt-4">
                    <div>
                        <label for="inpContraseniaUsuario_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpContraseniaUsuario_e" runat="server" />
                    </div>
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
                <label>Eliminar Usuario</label>
                <a style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <label for="lblIdUsuarioEliminar" class="col-form-label">Está a punto de eliminar el usuario con el identificador:</label>
                    <asp:Label ID="lblIdUsuarioEliminar" runat="server"></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio text-center mt-3">
                <asp:Button ID="btnEliminar" CssClass="mod" CommandName="" runat="server" Text="Eliminar" OnClick="btnEliminar_OnClick" />
                <button type="button" class="mod" runat="server" OnServerClick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Eliminar-->

    <!--Inicia Modal Crear-->
    <asp:Panel ID="modalCrear" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio">
                <label>Crear Usuario</label>
                <a style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                
                <div class="mt-4">
                    <div class="d-inline">
                        <label><i class="far fa-user d-inline mr-2"></i></label>
                        <asp:DropDownList ID="ddlEmpleado_c" CssClass="d-inline drop" runat="server"></asp:DropDownList>
                    </div>
                    <div class="d-inline">
                        <label><i class="far fa-user d-inline mx-2"></i></label>
                        <asp:DropDownList ID="ddlTipoUsuario_c" CssClass="d-inline drop" runat="server"></asp:DropDownList>
                    </div>
                </div>
                
                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpNombreUsuario_c" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" placeholder="Nombre usuario" class="form-control d-inline" id="inpNombreUsuario_c" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpContraseniaUsuario_c" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" placeholder="Contraseña" class="form-control d-inline" id="inpContraseniaUsuario_c" runat="server" />
                    </div>
                </div>

            </div>
            <div class="modal-footer-mio text-center mt-4">
                <asp:Button ID="btnCrear" CssClass="mod" CommandName="Crear" runat="server" Text="Crear" OnClick="btnCrear_OnClick" />
                <button type="button" class="mod" runat="server" OnServerClick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Crear-->
    
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


        var crearUser = [$("#ddlEmpleado_c"), $("#ddlTipoUsuario_c"), $("#inpNombreUsuario_c"), $("#inpContraseniaUsuario_c")]


        var updaUser = [$("#inpEmpleado_e"), $("#ddlTipoUsuario_e"), $("#inpNombreUsuario_e"), $("#inpContraseniaUsuario_e")]

        bForm.on("click", function (event) {

            checkInputs(crearUser);

            if (crearUser[0].hasClass("fail") || crearUser[1].hasClass("fail") || crearUser[2].hasClass("fail") || crearUser[3].hasClass("fail")) {

                event.preventDefault();

            }

        });


        bFormE.on("click", function (event) {

            checkInputs(updaUser);

            if (updaUser[0].hasClass("fail") || updaUser[1].hasClass("fail") || updaUser[2].hasClass("fail") || updaUser[3].hasClass("fail")) {

                event.preventDefault();

            }

        });


        function checkInputs(lista) {


            var nombre = lista[0];
            var tipo = lista[1];
            var nUsuario = lista[2];
            var contra = lista[3];



            /*esto da problemas

            if (id.val().trim() === '') {
                setErrorFor(id, "campo obligatorio");
            }
            else {
                setSuccessFor(id);
            }*/


            //verificacion primer nombre

            if (nombre.val().trim() === '') {
                setErrorFor(nombre, "campo obligatorio");
            }
            else {
                setSuccessFor(nombre);
            }

            //verificacion segundo nombre

            if (tipo.val().trim() === '') {
                setErrorFor(tipo, "campo obligatorio");
            }
            else {
                setSuccessFor(tipo);
            }

            //verificacion primer apellido

            if (nUsuario.val().trim() === '') {
                setErrorFor(nUsuario, "campo obligatorio");
            }
            else {
                setSuccessFor(nUsuario);
            }

            // segundo apellido

            if (contra.val().trim() === '') {
                setErrorFor(contra, "campo obligatorio");
            }
            else {
                setSuccessFor(contra);
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




    </script>

    
</asp:Content>