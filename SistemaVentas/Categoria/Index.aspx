<%@ Page Title="Categoria" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Categoria.Categoria" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="col">
    
        <h5 class="mt-3 d-block titulo">Listado de Categorias</h5>

    
        <div class="row mt-2">
                <div class="col text-left pl-3">
                    <asp:TextBox ID="txtBuscar" CssClass="b-inline-block form-size ml-2 btn-opc down pl-2" runat="server"></asp:TextBox>
                    <asp:Button ID="btnBuscar" CssClass="btn b-inline-block btn-small ml-2" runat="server" Text="Buscar" OnClick="btnBuscar_OnClick" />
                </div>
        </div>
    


        <div class="row">

            <div class="col-8 pl-4">
                 <div class="round-border mt-3">
                    <asp:GridView ID="GridView1" CssClass="table table-sm  table-striped text-center" runat="server" AutoGenerateColumns="False" DataKeyNames="idCategoria" OnRowCommand="GridView1_OnRowCommand" AllowPaging="True" PageSize="10" OnPageIndexChanging="GridView1_OnPageIndexChanging">
                        <Columns>

                            <asp:BoundField DataField="idCategoria" HeaderText="ID" />
                            <asp:BoundField DataField="nombreCategoria" HeaderText="Categoria" />

                            <asp:TemplateField HeaderText="Detalles" SortExpression="">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDetalles" runat="server" CommandName="detalles" CommandArgument='<%#Eval("idCategoria") %>'><i class="fas fa-search-plus"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Editar" SortExpression="">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEditar" runat="server" CommandName="editar" CommandArgument='<%#Eval("idCategoria") %>'><i class="fas fa-pencil-alt"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Eliminar" SortExpression="">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnEliminar" runat="server" CommandName="eliminar" CommandArgument='<%#Eval("idCategoria") %>'><i class="fas fa-trash-alt"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="GridPager prueba" />
                    </asp:GridView>
                </div>
            </div>

            <div id="fondoModal"></div>


           
            <!--Inicia Modal Crear-->
            <div class="col-4 pl-5">
                <div class="text-center">
                    <div>
                        <label>Agregar Categoria</label>
                    </div>
                    <div>
                        <div>
                            <input type="text" placeholder="Nombre categoria" class="form-control btn-opc-m d-inline" id="inpNombreCategoria_c" runat="server" />
                        </div>
                    </div>
                    <div>
                        <asp:Button ID="btnCrear" CssClass="btn btn-small-m mt-2 d-inline" CommandName="Crear" runat="server" Text="Crear" OnClick="btnCrear_OnClick" />
                    </div>
                </div>
            </div>
            <!--Termina Modal Crear-->

        </div>

         <!--contador de botones para cambiar de index-->

        <div class="mt-3">
            
            <p class="d-inline-block ml-2 font-weight-light p-size">Han sido encontrados <label id="cantidadCategorias" runat="server"></label> registros en la base de datos</p>

            <nav class="d-inline-block text-sm-right move mr-3">
                <ul class="pagination">
                    
                    <li class="page-item active">
                        <a class="page-link border rounded-circle ml-1" href="#">1</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link border rounded-circle ml-1" href="#">2</a>
                    </li>
                    
                    
                </ul>
            </nav>

        </div>

    </div>

    <!--Inicia Modal Detalles-->
    <asp:Panel ID="modalDetalles" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <h5>Detalles Categoria</h5>
                <a id="cerrarDetallesX" style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div style="display: none">
                    <label>ID:</label>
                    <asp:Label ID="lblIdCategoria" runat="server"></asp:Label>
                </div>
                <div>
                    <label>Categoria:</label>
                    <asp:Label ID="lblNombreCategoria" runat="server"></asp:Label>
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
                <h5>Editar Categoria</h5>
                <a id="cerrarEditarX" style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                
                
                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpIdCategoria_e" class="col-form-label"><i class="far fa-user mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpIdCategoria_e" runat="server" disabled="True"/>
                    </div>
                    <div class="d-inline">
                        <label for="inpNombreCategoria_e" class="col-form-label"><i class="far fa-bookmark mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpNombreCategoria_e" runat="server" />
                    </div>
                </div>


            </div>
            <div class="modal-footer-mio text-center mt-3">
                <asp:Button ID="btnActualizar" CssClass="mod btn" runat="server" Text="Actualizar" OnClick="btnActualizar_OnClick" />
                <button type="button" class="mod btn" runat="server" OnServerClick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Editar-->


    <!--Inicia Modal Eliminar-->
    <asp:Panel ID="modalEliminar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <h5>Eliminar Categoria</h5>
                <a style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <label for="lblIdCategoriaEliminar" class="col-form-label">Está a punto de eliminar la marca con el identificador:</label>
                    <asp:Label ID="lblIdCategoriaEliminar" runat="server" Text=""></asp:Label>
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

        .mod, .mod:hover {
            background-color: rgb(119, 100, 228);
            width: 15rem;
            color: white;
            border-radius: 4px;
            border: 1px solid rgb(119, 100, 228);
        }

        

        /*empleado*/

        .img-fix {

            width: 4rem;
            height: 4rem;
            border-radius: 100px;
        }

        /*#GridView1 td{
        
            line-height: 4rem;
        
        }*/

        /*empleado crear*/


        #vistaPreviaImagen {
            
            background-color: darkgray;
            width: 6rem;
            height: 6rem;
        }


        #vistaPreviaImagen img{
        
            width: 6rem;
            height: 6rem;

        
        }

       /*dropdowns*/

       .drop {
       
           border-radius: 5px;
           width: 18rem;
           height: 2.4rem!important; 
           border-color: #ced4da;
           color: #495057;
       }

       /*empleado detalles detalles*/

        #imgFotografiaEmpleado {
        
            width:6rem;
            height:6rem;
            border-radius: 100px;
        
        } 

        /*empleado editar*/

        #imgFotografiaEmpleado_e {
        
            width:6rem;
            height:6rem;
            
        }

        /*producto detalles*/

        #imgProducto_d {
        
            width:6rem;
            height:6rem;
            border-radius: 100px;
        
        }

        /*producto editar*/

        #imgProducto_e {
        
            width:7rem;
            height:7rem;
            border-radius: 100px;
        }

        /*marca*/

         .btn-small-m, .btn-small-m:hover {
            background-color: rgb(119, 100, 228);
            font-size: 0.7rem;
            width: 15rem;
            color: white;
        }


        .btn-opc-m {
            width: 15rem;
            border: 1px solid rgb(217, 212, 212);
            border-radius: 4px;
            font-size: 1rem;
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

        var bForm = $("#btnCrear");
        var bFormE = $("#btnActualizar")


        var crearCategoria = [$("#inpNombreCategoria_c")]


        var updaCategoria = [$("#inpNombreCategoria_e"), $("#inpIdCategoria_e")]

        bForm.on("click", function (event) {

            checkInputs(crearCategoria);

            if (crearCategoria[0].hasClass("fail")) {

                event.preventDefault();

            }

        });


        bFormE.on("click", function (event) {

            checkInputs(updaCategoria);

            if (updaCategoria[0].hasClass("fail") || updaCategoria[1].hasClass("fail")) {

                event.preventDefault();

            }

        });


        function checkInputs(lista) {


            var nombre = lista[0];
            var id = lista[1];



            /*esto da problemas

            if (id.val().trim() === '') {
                setErrorFor(id, "campo obligatorio");
            }
            else {
                setSuccessFor(id);
            }*/


            //verificacion primer nombre

            if (nombre.val().trim() === '') {
                setErrorFor(nombre, "Categoria");
            }
            else {
                setSuccessFor(nombre);
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