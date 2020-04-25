<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Usuario.Index" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <h1>Listado de Usuarios</h1>
    
    <div class="w-100"></div>

    <asp:TextBox ID="txtBuscar" runat="server"></asp:TextBox>
    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_OnClick"/>

    <asp:LinkButton ID="btnCrearUsuario" runat="server" CommandName="crear" CommandArgument='<%#Eval("idUsuario") %>' OnClick="btnCrearUsuario_Click"><i class="fas fa-search-plus"></i>Crear Usuario</asp:LinkButton>

    <div class="w-100"></div>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="idUsuario" OnRowCommand="GridView1_OnRowCommand" AllowPaging="True" PageSize="10" OnPageIndexChanging="GridView1_OnPageIndexChanging">
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

    <div id="fondoModal"></div>
    
    <!--Inicia Modal Detalles-->
    <asp:Panel ID="modalDetalles" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio">
                <label>Detalles Usuarios</label>
                <a id="" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
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
                <label>Editar Usuario</label>
                <a id="" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="inpIdUsuario_e">ID:</label>
                    <input type="text" class="form-control" id="inpIdUsuario_e" runat="server" readonly="readonly"/>
                </div>
                <div>
                    <label for="inpEmpleado_e">Empleado:</label>
                    <input type="text" class="form-control" id="inpEmpleado_e" runat="server" readonly="readonly"/>
                </div>
                <div>
                    <label for="ddlTipoUsuario_e">Tipo Usuario:</label>
                    <asp:DropDownList ID="ddlTipoUsuario_e" runat="server"></asp:DropDownList>
                </div>
                <div>
                    <label for="inpNombreUsuario_e">Nombre Usuario:</label>
                    <input type="text" class="form-control" id="inpNombreUsuario_e" runat="server" />
                </div>
                <div>
                    <label for="inpContraseniaUsuario_e" class="col-form-label">Contraseña:</label>
                    <input type="text" class="form-control" id="inpContraseniaUsuario_e" runat="server" />
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
                <label>Eliminar Usuario</label>
                <a style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="lblIdUsuarioEliminar" class="col-form-label">Está a punto de eliminar el usuario con el identificador:</label>
                    <asp:Label ID="lblIdUsuarioEliminar" runat="server"></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio">
                <asp:Button ID="btnEliminar" CommandName="" runat="server" Text="Eliminar" OnClick="btnEliminar_OnClick" />
                <button type="button" class="cerrar">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Eliminar-->

    <!--Inicia Modal Crear-->
    <asp:Panel ID="modalCrear" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio">
                <label>Crear Usuario</label>
                <a style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label>Empleado:</label>
                    <asp:DropDownList ID="ddlEmpleado_c" runat="server"></asp:DropDownList>
                </div>
                <div>
                    <label>Tipo Usuario:</label>
                    <asp:DropDownList ID="ddlTipoUsuario_c" runat="server"></asp:DropDownList>
                </div>
                <div>
                    <label for="inpNombreUsuario_c" class="col-form-label">Nombre Usuario:</label>
                    <input type="text" class="form-control" id="inpNombreUsuario_c" runat="server" />
                </div>
                <div>
                    <label for="inpContraseniaUsuario_c" class="col-form-label">Contraseña:</label>
                    <input type="text" class="form-control" id="inpContraseniaUsuario_c" runat="server" />
                </div>
            </div>
            <div class="modal-footer-mio">
                <asp:Button ID="btnCrear" CommandName="Crear" runat="server" Text="Crear" OnClick="btnCrear_OnClick" />
                <button type="button" class="cerrar">Cancelar</button>
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
