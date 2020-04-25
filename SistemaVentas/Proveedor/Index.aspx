<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Proveedor.Index" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Listado de Proveedor</h1>

    <div class="w-100"></div>

    <asp:TextBox ID="txtBuscar" runat="server"></asp:TextBox>
    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_OnClick" />

    <asp:LinkButton ID="btnCrearProveedor" runat="server" CommandName="crear" CommandArgument='<%#Eval("idProveedor") %>' OnClick="btnCrearProveedor_OnClick"><i class="fas fa-search-plus"></i>Crear Proveedor</asp:LinkButton>

    <div class="w-100"></div>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="idProveedor" OnRowCommand="GridView1_OnRowCommand" AllowPaging="True" PageSize="20" OnPageIndexChanging="GridView1_OnPageIndexChanging">
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

    <div id="fondoModal"></div>

    <!--Inicia Modal Crear-->
    <asp:Panel ID="modalCrear" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio">
                <label>Crear Proveedor</label>
                <a id="" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="inpPrimerNombreProveedor_c" class="col-form-label">Primer Nombre:</label>
                    <input type="text" class="form-control" id="inpPrimerNombreProveedor_c" runat="server" />
                </div>
                <div>
                    <label for="inpSegundoNombreProveedor_c" class="col-form-label">Segundo Nombre:</label>
                    <input type="text" class="form-control" id="inpSegundoNombreProveedor_c" runat="server" />
                </div>
                <div>
                    <label for="inpPrimerApellidoProveedor_c" class="col-form-label">Primer Apellido:</label>
                    <input type="text" class="form-control" id="inpPrimerApellidoProveedor_c" runat="server" />
                </div>
                <div>
                    <label for="inpSegundoApellidoProveedor_c" class="col-form-label">Segundo Apellido:</label>
                    <input type="text" class="form-control" id="inpSegundoApellidoProveedor_c" runat="server" />
                </div>
                <div>
                    <label for="inpEmpresaProveedor_c" class="col-form-label">Empresa:</label>
                    <input type="text" class="form-control" id="inpEmpresaProveedor_c" runat="server" />
                </div>
                <div>
                    <label for="inpTelefonoProveedor_c" class="col-form-label">Telefono:</label>
                    <input type="text" class="form-control" id="inpTelefonoProveedor_c" runat="server" />
                </div>
            </div>
            <div class="modal-footer-mio">
                <asp:Button ID="btnCrear" CommandName="Crear" runat="server" Text="Crear" OnClick="btnCrear_OnClick" />
                <button type="button" class="cerrar">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Crear-->


    <!--Inicia Modal Detalles-->
    <asp:Panel ID="modalDetalles" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio">
                <label>Detalles Proveedor</label>
                <a id="" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
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
            <div class="modal-footer-mio">
                <asp:Button ID="btnImprimir" runat="server" Text="Imprimir" />
                <button type="button" class="cerrar">Cerrar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Detalles-->


    <!--Inicia Modal Editar-->
    <asp:Panel ID="modalEditar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio">
                <label>Editar Proveedor</label>
                <a id="" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="inpIdProveedor_e" class="col-form-label">Id:</label>
                    <input type="text" class="form-control" id="inpIdProveedor_e" runat="server" />
                </div>
                <div>
                    <label for="inpPrimerNombreProveedor_e" class="col-form-label">Primer Nombre:</label>
                    <input type="text" class="form-control" id="inpPrimerNombreProveedor_e" runat="server" />
                </div>
                <div>
                    <label for="inpSegundoNombreProveedor_e" class="col-form-label">Segundo Nombre:</label>
                    <input type="text" class="form-control" id="inpSegundoNombreProveedor_e" runat="server" />
                </div>
                <div>
                    <label for="inpPrimerApellidoProveedor_e" class="col-form-label">Primer Apellido:</label>
                    <input type="text" class="form-control" id="inpPrimerApellidoProveedor_e" runat="server" />
                </div>
                <div>
                    <label for="inpSegundoApellidoProveedor_e" class="col-form-label">Segundo Apellido:</label>
                    <input type="text" class="form-control" id="inpSegundoApellidoProveedor_e" runat="server" />
                </div>
                <div>
                    <label for="inpTelefonoProveedor_e" class="col-form-label">Telefono:</label>
                    <input type="text" class="form-control" id="inpTelefonoProveedor_e" runat="server" />
                </div>
                <div>
                    <label for="inpEmpresaProveedor_e" class="col-form-label">Empresa:</label>
                    <input type="text" class="form-control" id="inpEmpresaProveedor_e" runat="server" />
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
                <label>Eliminar Proveedor</label>
                <a id="" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="lblIdProveedorEliminar" class="col-form-label">Está a punto de eliminar el proveedor con el identificador:</label>
                    <asp:Label ID="lblIdProveedorEliminar" runat="server" Text=""></asp:Label>
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
