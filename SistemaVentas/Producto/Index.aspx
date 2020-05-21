<%@ Page Title="Producto" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Producto.Index" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="col">

        <h5 class="mt-3 d-block titulo">Listado de Productos</h5>

        <div class="row mt-2">

            <div class="col text-left">
                <asp:TextBox ID="txtBuscar" CssClass="b-inline-block form-size ml-2 btn-opc down pl-2" runat="server"></asp:TextBox>
                <asp:Button ID="btnBuscar" CssClass="btn b-inline-block btn-small ml-2" runat="server" runat="server" Text="Buscar" OnClick="btnBuscar_OnClick" />
            </div>

            <div class="col text-right">
                <asp:LinkButton ID="btnCrearProducto" CssClass="btn btn-small btn-primary b-inline-block mr-3" runat="server" CommandName="crear" CommandArgument='<%#Eval("idProducto") %>' OnClick="btnCrearProducto_OnClick">Crear Producto</asp:LinkButton>
            </div>

        </div>

        <div class="round-border mt-3">

            <asp:GridView ID="GridView1" CssClass="table table-sm  table-striped text-center" runat="server" AutoGenerateColumns="False" DataKeyNames="idProducto" OnRowCommand="GridView1_OnRowCommand" AllowPaging="True" PageSize="5" OnPageIndexChanging="GridView1_OnPageIndexChanging">
                <Columns>
                    <asp:BoundField DataField="idProducto" HeaderText="ID" />
                    <asp:TemplateField HeaderText="Imagen" SortExpression="">
                        <ItemTemplate>
                            <asp:Image ID="Image1" CssClass="img-fix" runat="server" ImageUrl='<%#"data:Image/jpg;jpg;base64," + Convert.ToBase64String((byte[])Eval("imagenProducto"))%>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="nombreProducto" HeaderText="Nombre" />
                    <asp:BoundField DataField="nombreMarca" HeaderText="Marca" />
                    <asp:BoundField DataField="nombreCategoria" HeaderText="Categoria" />

                    <asp:TemplateField HeaderText="Detalles" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnDetalles" runat="server" CommandName="detalles" CommandArgument='<%#Eval("idProducto") %>'><i class="fas fa-search-plus"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Editar" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditar" runat="server" CommandName="editar" CommandArgument='<%#Eval("idProducto") %>'><i class="fas fa-pencil-alt"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Eliminar" SortExpression="">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEliminar" runat="server" CommandName="eliminar" CommandArgument='<%#Eval("idProducto") %>'><i class="fas fa-trash-alt"></i></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                
            </asp:GridView>
        </div>

        <style>

            /*.prueba {
                background: #2ecc71 !important;
            }

                .prueba span {
                    color: white;
                }

                .prueba > tr td{
                    background-color: blue !important;
                }

            .prueba > tr {
                background-color: red !important;
            }*/

        </style>

        <!--contador de botones para cambiar de index-->

        <div class="mt-3">

            <p class="d-inline-block ml-3 font-weight-light p-size">
                Han sido encontrados
                <label id="cantidadProductos" runat="server"></label>
                registros en la base de datos
            </p>

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
                <label>Crear Producto</label>
                <a style="float: right; text-decoration: none" runat="server" onserverclick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <div>
                        <label for="FileUpload1_c" class="col-form-label mr-2">Imagen:</label>
                        <asp:FileUpload runat="server" ID="FileUpload1_c" />
                    </div>
                </div>

                <div class="mt-4">
                    <div class="d-inline">
                        <label for="nombreProducto" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" placeholder="Nombre" class="form-control d-inline" id="inpNombreProducto_c" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="ddlCategoria_c" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <asp:DropDownList ID="ddlCategoria_c" CssClass="d-inline drop" runat="server" />
                    </div>
                </div>

                <div class="mt-4">
                    <div class="d-inline">
                        <label for="ddlMarca_c" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <asp:DropDownList ID="ddlMarca_c" CssClass="d-inline drop" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpDescripcionProducto_c" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" placeholder="Descripcion" id="inpDescripcionProducto_c" runat="server" />
                    </div>
                </div>

                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpPrecioProducto_c" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" placeholder="Precio" id="inpPrecioProducto_c" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpDescuentoProducto_c" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" placeholder="Descuento" id="inpDescuentoProducto_c" runat="server" />
                    </div>
                </div>


            </div>
            <div class="modal-footer-mio text-center mt-4">
                <asp:Button ID="btnCrear" CssClass="mod" CommandName="Crear" runat="server" Text="Crear" OnClick="btnCrear_OnClick" />
                <button type="button" class="mod" id="cerrarCrear" runat="server" onserverclick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Crear-->


    <!--Inicia Modal Detalles-->
    <asp:Panel ID="modalDetalles" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Detalles Productos</label>
                <a style="float: right; text-decoration: none" runat="server" onserverclick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <asp:Image ID="imgProducto_d" CssClass="m-auto" runat="server" />
                </div>

                <div>
                    <label for="lblIdProducto" class="mt-2">ID:</label>
                    <asp:Label ID="lblIdProducto" runat="server"></asp:Label>
                </div>
                <div>
                    <label for="lblCategoria">Categoría:</label>
                    <asp:Label ID="lblCategoria" runat="server"></asp:Label>
                </div>
                <div>
                    <label for="lblMarca">Marca:</label>
                    <asp:Label ID="lblMarca" runat="server"></asp:Label>
                </div>
                <div>
                    <label for="lblNombreProducto">Nombre:</label>
                    <asp:Label ID="lblNombreProducto" runat="server"></asp:Label>
                </div>
                <div>
                    <label for="lblDescripciónProducto">Descripción:</label>
                    <asp:Label ID="lblDescripciónProducto" runat="server"></asp:Label>
                </div>

                <div>
                    <label for="lblPrecio">Precio Venta:</label>
                    <asp:Label ID="lblPrecio" runat="server"></asp:Label>
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
                <label>Editar Producto</label>
                <a style="float: right; text-decoration: none" runat="server" onserverclick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">

                <div class="">
                    <div>
                        <img src="" alt="" id="imgProducto_e" class="col-form-label m-auto d-block" runat="server" />
                        <asp:FileUpload ID="FileUpload1_e" CssClass="mt-2" runat="server" />
                    </div>
                </div>

                <div class="mt-3">
                    <div class="d-inline">
                        <label for="inpIdProducto_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpIdProducto_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="ddlCategoria_e" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <asp:DropDownList ID="ddlCategoria_e" CssClass="d-inline drop" runat="server"></asp:DropDownList>
                    </div>
                </div>

                <div class="mt-3">
                    <div class="d-inline">
                        <label for="ddlMarca_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <asp:DropDownList ID="ddlMarca_e" CssClass="d-inline drop" runat="server"></asp:DropDownList>
                    </div>
                    <div class="d-inline">
                        <label for="inpNombreProducto_e" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpNombreProducto_e" runat="server" />
                    </div>
                </div>

                <div class="mt-3">
                    <div class="d-inline">
                        <label for="inpPrecioProducto_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpPrecioProducto_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpDescuentoProducto_e" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpDescuentoProducto_e" runat="server" />
                    </div>
                </div>


                <div class="mt-3">
                    <div class="d-inline">
                        <label for="txtDescripcionProducto_e" class="col-form-label"><i class="far fa-user d-inline mr-2 mb-2"></i></label>
                        <textarea id="txtDescripcionProducto_e" class="drop pt-2" cols="20" rows="2" runat="server"></textarea>
                    </div>
                </div>

            </div>
            <div class="modal-footer-mio text-center">
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
                <label>Eliminar Producto</label>
                <a style="float: right; text-decoration: none" runat="server" onserverclick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <label for="lblIdProductoEliminar" class="col-form-label">Está a punto de eliminar el Producto con el identificador:</label>
                    <asp:Label ID="lblIdProductoEliminar" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio text-center mt-3">
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



        /*empleado*/

        .img-fix {
            width: 4rem;
            height: 4rem;
            border-radius: 100px;
        }

        #GridView1 td {
            line-height: 4rem;
        }

        /*empleado crear*/


        #vistaPreviaImagen {
            background-color: darkgray;
            width: 6rem;
            height: 6rem;
        }


            #vistaPreviaImagen img {
                width: 6rem;
                height: 6rem;
            }

        /*dropdowns*/

        .drop {
            border-radius: 5px;
            width: 18rem;
            height: 2.4rem !important;
            border-color: #ced4da;
            color: #495057;
        }

        /*empleado detalles detalles*/

        #imgFotografiaEmpleado {
            width: 6rem;
            height: 6rem;
            border-radius: 100px;
        }

        /*empleado editar*/

        #imgFotografiaEmpleado_e {
            width: 6rem;
            height: 6rem;
        }

        /*producto detalles*/

        #imgProducto_d {
            width: 6rem;
            height: 6rem;
            border-radius: 100px;
        }

        /*producto editar*/

        #imgProducto_e {
            width: 7rem;
            height: 7rem;
            border-radius: 100px;
        }


        .success {
            border-color: #2ecc71;
        }

        .fail {
            border-color: #e74c3c;
        }
    </style>

    <script>
        document.getElementById("FileUpload1_c").onchange = function (e) {
            // Creamos el objeto de la clase FileReader
            let reader = new FileReader();

            // Leemos el archivo subido y se lo pasamos a nuestro fileReader
            reader.readAsDataURL(e.target.files[0]);

            // Le decimos que cuando este listo ejecute el código interno
            reader.onload = function () {
                let preview = document.getElementById('vistaPreviaImagen'),
                    image = document.createElement('img');

                image.src = reader.result;

                preview.innerHTML = '';
                preview.append(image);
            };
        }
    </script>



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



    </script>
</asp:Content>
