<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Producto.Index" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Listado de Productos</h1>

    <div class="w-100"></div>

    <asp:TextBox ID="txtBuscar" runat="server"></asp:TextBox>
    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_OnClick" />

    <asp:LinkButton ID="btnCrearProducto" runat="server" CommandName="crear" CommandArgument='<%#Eval("idProducto") %>' OnClick="btnCrearProducto_OnClick"><i class="fas fa-search-plus"></i>Crear Producto</asp:LinkButton>

    <div class="w-100"></div>


    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="idProducto" OnRowCommand="GridView1_OnRowCommand" AllowPaging="True" PageSize="10" OnPageIndexChanging="GridView1_OnPageIndexChanging">
        <Columns>
            <asp:BoundField DataField="idProducto" HeaderText="ID" />
            <asp:TemplateField HeaderText="Imagen" SortExpression="">
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" Height="100px" Width="100px" ImageUrl='<%#"data:Image/jpg;jpg;base64," + Convert.ToBase64String((byte[])Eval("imagenProducto"))%>' />
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

    <div id="fondoModal"></div>
    <!--Inicia Modal Crear-->
    <asp:Panel ID="modalCrear" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio">
                <label>Crear Producto</label>
                <a style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="nombreProducto" class="col-form-label">Nombre:</label>
                    <input type="text" class="form-control" id="inpNombreProducto_c" runat="server" />
                </div>
                <div>
                    <label for="ddlCategoria_c" class="col-form-label">Categoría:</label>
                    <asp:DropDownList id="ddlCategoria_c" runat="server" />
                </div>
                <div>
                    <label for="ddlMarca_c" class="col-form-label">Marca:</label>
                    <asp:DropDownList ID="ddlMarca_c" runat="server" />
                </div>
                <div>
                    <div>
                        <label for="FileUpload1_c" class="col-form-label">Imagen:</label>
                        <asp:FileUpload runat="server" ID="FileUpload1_c" />
                    </div>
                </div>
                <div>
                    <label for="inpDescripcionProducto_c" class="col-form-label">Descripción:</label>
                    <input type="text" class="form-control" id="inpDescripcionProducto_c" runat="server" />
                </div>
            </div>
            <div class="modal-footer-mio">
                <asp:Button ID="btnCrear" CommandName="Crear" runat="server" Text="Crear" OnClick="btnCrear_OnClick" />
                <asp:Button ID="btnCerrar" CommandName="Cerrar" runat="server" Text="Cancelar" OnClick="cerrar" />
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Crear-->


    <!--Inicia Modal Detalles-->
    <asp:Panel ID="modalDetalles" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio">
                <label>Detalles Productos</label>
                <a style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="lblIdProducto">ID:</label>
                    <asp:Label ID="lblIdProducto" runat="server"></asp:Label>
                </div>
                <div>
                    <label for="lblNombreProducto">Nombre:</label>
                    <asp:Label ID="lblNombreProducto" runat="server"></asp:Label>
                </div>
                <div>
                    <label for="lblDuiProducto">DUI:</label>
                    <asp:Label ID="lblDuiProducto" runat="server"></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio">
                <asp:Button ID="btnImprimir" runat="server" Text="Imprimir" />
                <button type="button" class="cerrar">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Detalles-->


    <!--Inicia Modal Editar-->
    <asp:Panel ID="modalEditar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio">
                <label>Editar Producto</label>
                <a style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="inpidProducto_e" class="col-form-label">ID:</label>
                    <input type="text" class="form-control" id="inpidProducto_e" runat="server" />
                </div>
                <div>
                    <label for="inpPrimerNombreCliente_e" class="col-form-label">Primer Nombre:</label>
                    <input type="text" class="form-control" id="inpPrimerNombreCliente_e" runat="server" />
                </div>
                <div>
                    <label for="inpSegundoNombreCliente_e" class="col-form-label">Segundo Nombre:</label>
                    <input type="text" class="form-control" id="inpSegundoNombreCliente_e" runat="server" />
                </div>
                <div>
                    <label for="inpPrimerApellidoCliente_e" class="col-form-label">Primer Apellido:</label>
                    <input type="text" class="form-control" id="inpPrimerApellidoCliente_e" runat="server" />
                </div>
                <div>
                    <label for="inpSegundoApellidoCliente_e" class="col-form-label">Segundo Apellido:</label>
                    <input type="text" class="form-control" id="inpSegundoApellidoCliente_e" runat="server" />
                </div>
                <div>
                    <label for="inpDuiCliente_e" class="col-form-label">DUI:</label>
                    <input type="text" class="form-control" id="inpDuiCliente_e" runat="server" />
                </div>
                <div>
                    <label for="inpNitCliente_e" class="col-form-label">NIT:</label>
                    <input type="text" class="form-control" id="inpNitCliente_e" runat="server" />
                </div>
                <div>
                    <label for="inpTelefonoCliente_e" class="col-form-label">Fotografía:</label>
                    <input type="text" class="form-control" id="inpTelefonoCliente_e" runat="server" />
                </div>
                <div>
                    <label for="inpTelefonoCliente_e" class="col-form-label">Fecha de Nacimiento:</label>
                    <input type="text" class="form-control" id="Text1" runat="server" />
                </div>
                <div>
                    <label for="inpFechaContratoProducto_e" class="col-form-label">Fecha de Contrato:</label>
                    <input type="text" class="form-control" id="inpFechaContratoProducto_e" runat="server" />
                </div>
                <div>
                    <label for="inpTelefonoProducto_e" class="col-form-label">Telefono:</label>
                    <input type="text" class="form-control" id="inpTelefonoProducto_e" runat="server" />
                </div>
                <div>
                    <label for="inpCorreoProducto_e" class="col-form-label">Correo:</label>
                    <input type="text" class="form-control" id="inpCorreoProducto_e" runat="server" />
                </div>
                <div>
                    <label for="inpTelefonoCliente_e" class="col-form-label">Departamento:</label>
                    <asp:DropDownList runat="server" />
                </div>
                <div>
                    <label for="inpMunicipioProducto_e" class="col-form-label">Municipio:</label>
                    <input type="text" class="form-control" id="inpMunicipioProducto_e" runat="server" />
                </div>
                <div>
                    <label for="inpDetallesDireccion_e" class="col-form-label">Detalles Dirección:</label>
                    <input type="text" class="form-control" id="inpDetallesDireccion_e" runat="server" />
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
            <div class="modal-header-mio">
                <label>Eliminar Producto</label>
                <a style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="lblIdProductoEliminar" class="col-form-label">Está a punto de eliminar el Producto con el identificador:</label>
                    <asp:Label ID="lblIdProductoEliminar" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio">
                <asp:Button ID="btnEliminar" CommandName="" runat="server" Text="Eliminar" OnClick="btnEliminar_OnClick" />
                <button type="button" class="cerrar">Cancelar</button>
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

    </script>
</asp:Content>
