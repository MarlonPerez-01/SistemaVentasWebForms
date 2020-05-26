<%@ Page Title="Producto" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Producto.Index" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="col">

        <h5 class="mt-3 d-block titulo">Listado de Productos</h5>

        <div class="row mt-2" >

            <div class="col text-left" style="display: none">
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
                <PagerStyle CssClass="GridPager prueba" />
            </asp:GridView>
        </div>

        

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
                    <li class="page-item ml-3">
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
    <asp:Panel ID="modalCrear" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 60%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <h5>Crear Producto</h5>
                <a style="float: right; text-decoration: none" runat="server" onserverclick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <div>
                        <label for="FileUpload1_c" class="col-form-label mr-2">Imagen:</label>
                        <asp:FileUpload runat="server" ID="FileUpload1_c" required="required" />
                    </div>
                </div>

                <div class="mt-4">
                    <div class="d-inline">
                        <label for="nombreProducto" class="col-form-label"><i class="fas fa-box-open d-inline mr-2"></i></label>
                        <input type="text" placeholder="Nombre" class="form-control d-inline" id="inpNombreProducto_c" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="ddlCategoria_c" class="col-form-label"><i class="far fa-bookmark d-inline mx-2"></i></label>
                        <asp:DropDownList ID="ddlCategoria_c" CssClass="d-inline drop" runat="server" />
                    </div>
                </div>

                <div class="mt-4">
                    <div class="d-inline">
                        <label for="ddlMarca_c" class="col-form-label"><i class="far fa-bookmark d-inline mr-2"></i></label>
                        <asp:DropDownList ID="ddlMarca_c" CssClass="d-inline drop" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpDescripcionProducto_c" class="col-form-label"><i class="fas fa-box-open d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" placeholder="Descripcion" id="inpDescripcionProducto_c" runat="server" />
                    </div>
                </div>

                <div class="mt-4">
                    <div class="d-inline">
                        <label for="inpPrecioProducto_c" class="col-form-label"><i class="far fa-money-bill-alt d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" placeholder="Precio" id="inpPrecioProducto_c" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpDescuentoProducto_c" class="col-form-label"><i class="far fa-money-bill-alt d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" placeholder="Descuento" id="inpDescuentoProducto_c" runat="server" />
                    </div>
                </div>


            </div>
            <div class="modal-footer-mio text-center mt-4">
                <asp:Button ID="btnCrear" CssClass="mod btn" CommandName="Crear" runat="server" Text="Crear" OnClick="btnCrear_OnClick" />
                <button type="button" class="mod btn" id="cerrarCrear" runat="server" onserverclick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Crear-->


    <!--Inicia Modal Detalles-->
    <asp:Panel ID="modalDetalles" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <h5>Detalles Productos</h5>
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

                <div>
                    <label for="lblStock">Stock:</label>
                    <asp:Label ID="lblStock" runat="server"></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio text-center">
                <asp:Button ID="btnImprimir" CssClass="mod btn" runat="server" Text="Imprimir" />
                <button type="button" class="mod btn" runat="server" onserverclick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Detalles-->


    <!--Inicia Modal Editar-->
    <asp:Panel ID="modalEditar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 60%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <h5>Editar Producto</h5>
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
                        <label for="inpIdProducto_e" class="col-form-label"><i class="fas fa-box-open d-inline mr-2"></i></label>
                        <input type="text" disabled="disabled" class="form-control d-inline" id="inpIdProducto_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="ddlCategoria_e" class="col-form-label"><i class="far fa-bookmark d-inline mx-2"></i></label>
                        <asp:DropDownList ID="ddlCategoria_e" CssClass="d-inline drop" runat="server"></asp:DropDownList>
                    </div>
                </div>

                <div class="mt-3">
                    <div class="d-inline">
                        <label for="ddlMarca_e" class="col-form-label"><i class="far fa-bookmark d-inline mr-2"></i></label>
                        <asp:DropDownList ID="ddlMarca_e" CssClass="d-inline drop" runat="server"></asp:DropDownList>
                    </div>
                    <div class="d-inline">
                        <label for="inpNombreProducto_e" class="col-form-label"><i class="fas fa-box-open d-inline mx-2"></i></label>
                        <input type="text" placeholder="Nombre producto" class="form-control d-inline" id="inpNombreProducto_e" runat="server" />
                    </div>
                </div>

                <div class="mt-3">
                    <div class="d-inline">
                        <label for="inpPrecioProducto_e" class="col-form-label"><i class="far fa-money-bill-alt d-inline mr-2"></i></label>
                        <input type="text" placeholder="Precio producto" class="form-control d-inline" id="inpPrecioProducto_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpDescuentoProducto_e" class="col-form-label"><i class="far fa-money-bill-alt d-inline mx-2"></i></label>
                        <input type="text" placeholder="Descuento" class="form-control d-inline" id="inpDescuentoProducto_e" runat="server" />
                    </div>
                </div>


                <div class="mt-3">
                    <div class="d-inline">
                        <label for="txtDescripcionProducto_e" class="col-form-label"><i class="fas fa-box-open d-inline mr-2 mb-2"></i></label>
                        <textarea id="txtDescripcionProducto_e" placeholder="Descripcion producto" class="drop pt-2" cols="20" rows="2" runat="server"></textarea>
                    </div>
                </div>

            </div>
            <div class="modal-footer-mio text-center">
                <asp:Button ID="btnActualizar" CssClass="mod btn" CommandName="" runat="server" Text="Actualizar" OnClick="btnActualizar_OnClick" />
                <button type="button" class="mod btn" runat="server" onserverclick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Editar-->


    <!--Inicia Modal Eliminar-->
    <asp:Panel ID="modalEliminar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <h5>Eliminar Producto</h5>
                <a style="float: right; text-decoration: none" runat="server" onserverclick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <label for="lblIdProductoEliminar" class="col-form-label">Está a punto de eliminar el Producto con el identificador:</label>
                    <asp:Label ID="lblIdProductoEliminar" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio text-center mt-3">
                <asp:Button ID="btnEliminar" CssClass="mod btn" CommandName="" runat="server" Text="Eliminar" OnClick="btnEliminar_OnClick" />
                <button type="button" class="mod btn" runat="server" onserverclick="cerrarTodo">Cancelar</button>
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

        document.addEventListener('DOMContentLoaded', function () {

            var myIndex = <%=GridView1.PageIndex %>;
            var next = myIndex + 2;
            var before = myIndex;
            //alert(before);

            $(".pagination li:nth-child(1)").on("click", function () {
                document.querySelector(".prueba td:nth-child(" + before + ") a").click();
            });

            $(".pagination li:nth-child(2)").on("click", function () {
                document.querySelector(".prueba td:nth-child(" + next + ") a").click();
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

        var imageE = $("#imgProducto_e").attr("src");


        var crearProducto = [undefined, $("#inpNombreProducto_c"), $("#ddlCategoria_c"), $("#ddlMarca_c"),
            $("#inpDescripcionProducto_c"), $("#FileUpload1_c"), $("#inpPrecioProducto_c"), $("#inpDescuentoProducto_c")]


        var updaProducto = [imageE, $("#inpNombreProducto_e"), $("#ddlCategoria_e"), $("#ddlMarca_e"),
            $("#txtDescripcionProducto_e"), $("#imgProducto_e"), $("#inpPrecioProducto_e"), $("#inpDescuentoProducto_e")]

        bForm.on("click", function (event) {


            checkInputs(crearProducto);

            if (crearProducto[1].hasClass("fail") || crearProducto[2].hasClass("fail") || crearProducto[3].hasClass("fail") || crearProducto[4].hasClass("fail") || crearProducto[5].hasClass("fail") || crearProducto[6].hasClass("fail"), crearProducto[7].hasClass("fail")) {

                event.preventDefault();

            }

        });


        bFormE.on("click", function (event) {

            checkInputs(updaProducto);

            if (updaProducto[5].hasClass("fail") || updaProducto[1].hasClass("fail") || updaProducto[2].hasClass("fail") || updaProducto[3].hasClass("fail") || updaProducto[4].hasClass("fail") || updaProducto[6].hasClass("fail") || updaProducto[7].hasClass("fail")) {

                event.preventDefault();

            }

        });


        function checkInputs(lista) {


            var imgVal = lista[0];
            var nombre = lista[1];
            var categoria = lista[2];
            var marca = lista[3];
            var descripcion = lista[4];
            var imgPos = lista[5];
            var precio = lista[6];
            var descuento = lista[7];



            /*esto da problemas

            if (id.val().trim() === '') {
                setErrorFor(id, "campo obligatorio");
            }
            else {
                setSuccessFor(id);
            }*/


            //verificacion img

            if (typeof dato6 != 'undefined') {
                if (imgVal == '') {
                    setErrorFor(imgPos, "campo obligatorio");
                }
                else {
                    setSuccessFor(imgPos);
                }
            }

            //verificacion nombre

            if (nombre.val().trim() == '') {
                setErrorFor(nombre, "Nombre producto");
            }
            else {
                setSuccessFor(nombre);
            }

            //verificacion categoria

            if (categoria.val().trim() === '') {
                setErrorFor(categoria, "Categoria");
            }
            else {
                setSuccessFor(categoria);
            }

            //verificacion marca

            if (marca.val().trim() === '') {
                setErrorFor(marca, "Marca");
            }
            else {
                setSuccessFor(marca);
            }

            //verificacion descripcion

            if (descripcion.val().trim() === '') {
                setErrorFor(descripcion, "Descripcion");
            }
            else {
                setSuccessFor(descripcion);
            }

            //verificacion descripcion

            if (isMoney(precio.val().trim())) {

                setSuccessFor(precio);

            }

            else if (precio.val().trim() === '') {
                setErrorFor(precio, "precio");
            }

            else {
                setErrorFor(precio, "precio invalido");
            }

            //verificacion descripcion

            if (isMoney(descuento.val().trim())) {

                setSuccessFor(descuento);

            }

            else if (descuento.val().trim() === '') {
                setErrorFor(descuento, "Si no aplica debe ser 0");
            }

            else {
                setErrorFor(descuento, "descuento invalido");
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

        function isMoney(m) {

            return /^\d+(\.\d{1,2})?$/.test(m)
        }



    </script>
</asp:Content>
