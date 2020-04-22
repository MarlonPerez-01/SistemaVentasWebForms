<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Cliente.Index" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <h1>Listado de Clientes</h1>
    
    <div class="w-100"></div>

    <asp:TextBox ID="txtBuscar" runat="server"></asp:TextBox>
    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_OnClick"/>

    <asp:LinkButton ID="btnCrearCliente" runat="server" CommandName="crear" CommandArgument='<%#Eval("idCliente") %>' OnClick="btnCrearCliente_OnClick"><i class="fas fa-search-plus"></i>Crear Cliente</asp:LinkButton>

    <div class="w-100"></div>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="idCliente" OnRowCommand="GridView1_OnRowCommand" AllowPaging="True" PageSize="10" OnPageIndexChanging="GridView1_OnPageIndexChanging">
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

    <div id="fondoModal"></div>
    <!--Inicia Modal Crear-->
    <asp:Panel ID="modalCrear" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio">
                <label>Crear Cliente</label>
                <a id="closebtn" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="inpPrimerNombreCliente_c" class="col-form-label">Primer Nombre:</label>
                    <input type="text" class="form-control" id="inpPrimerNombreCliente_c" runat="server" />
                </div>
                <div>
                    <label for="inpSegundoNombreCliente_c" class="col-form-label">Segundo Nombre:</label>
                    <input type="text" class="form-control" id="inpSegundoNombreCliente_c" runat="server" />
                </div>
                <div>
                    <label for="inpPrimerApellidoCliente_c" class="col-form-label">Primer Apellido:</label>
                    <input type="text" class="form-control" id="inpPrimerApellidoCliente_c" runat="server" />
                </div>
                <div>
                    <label for="inpSegundoApellidoCliente_c" class="col-form-label">Segundo Apellido:</label>
                    <input type="text" class="form-control" id="inpSegundoApellidoCliente_c" runat="server" />
                </div>
                <div>
                    <label for="inpDuiCliente_c" class="col-form-label">DUI:</label>
                    <input type="text" class="form-control" id="inpDuiCliente_c" runat="server" />
                </div>
                <div>
                    <label for="inpNitCliente_c" class="col-form-label">NIT:</label>
                    <input type="text" class="form-control" id="inpNitCliente_c" runat="server" />
                </div>
                <div>
                    <label for="inpTelefonoCliente_c" class="col-form-label">Teléfono:</label>
                    <input type="text" class="form-control" id="inpTelefonoCliente_c" runat="server" />
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
                <label>Detalles Clientes</label>
                <a id="closebtn" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
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
                <label>Editar Cliente</label>
                <a id="closebtn" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="inpIdCliente_e" class="col-form-label">ID:</label>
                    <input type="text" class="form-control" id="inpIdCliente_e" runat="server" />
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
                    <label for="inpTelefonoCliente_e" class="col-form-label">Telefono:</label>
                    <input type="text" class="form-control" id="inpTelefonoCliente_e" runat="server" />
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
                <label>Eliminar Cliente</label>
                <a id="closebtn" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="lblIdClienteEliminar" class="col-form-label">Está a punto de eliminar el cliente con el identificador:</label>
                    <asp:Label ID="lblIdClienteEliminar" runat="server" Text=""></asp:Label>
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
