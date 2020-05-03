<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Cargo.Index" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Listado de Cargos</h1>

    <div class="w-100"></div>

    <asp:TextBox ID="txtBuscar" runat="server"></asp:TextBox>
    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_OnClick" />

    <asp:LinkButton ID="btnCrearCargo" runat="server" CommandName="crear" CommandArgument='<%#Eval("idCargo") %>' OnClick="btnCrearCargo_OnClick"><i class="fas fa-search-plus"></i>Crear Cargo</asp:LinkButton>

    <div class="w-100"></div>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="idCargo" OnRowCommand="GridView1_OnRowCommand" AllowPaging="True" PageSize="10" OnPageIndexChanging="GridView1_OnPageIndexChanging">
        <Columns>

            <asp:BoundField DataField="idCargo" HeaderText="ID" />
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

    <div id="fondoModal"></div>
    <!--Inicia Modal Crear-->
    <asp:Panel ID="modalCrear" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio">
                <label>Crear Cargo</label>
                <a id="" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="inpNombreCargo_c" class="col-form-label">Nombre:</label>
                    <input type="text" class="form-control" id="inpNombreCargo_c" runat="server" />
                </div>
                <div>
                    <label for="inpSalarioCargo_c" class="col-form-label">Salario:</label>
                    <input type="text" class="form-control" id="inpSalarioCargo_c" runat="server" />
                </div>
            </div>
            <div>
                <div class="modal-footer-mio">
                    <asp:Button ID="btnCrear" CommandName="Crear" runat="server" Text="Crear" OnClick="btnCrear_OnClick" />
                    <button type="button" class="cerrar">Cancelar</button>
                </div>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Crear-->


    <!--Inicia Modal Detalles-->
    <asp:Panel ID="modalDetalles" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio">
                <label>Detalles Cargos</label>
                <a style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
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
                <label>Editar Cargo</label>
                <a id="" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="inpIdCargo_e" class="col-form-label">ID:</label>
                    <input type="text" class="form-control" id="inpIdCargo_e" runat="server" />
                </div>
                <div>
                    <label for="inpNombreCargo_e" class="col-form-label">Nombre:</label>
                    <input type="text" class="form-control" id="inpNombreCargo_e" runat="server" />
                </div>
                <div>
                    <label for="inpSalarioCargo_e" class="col-form-label">Salario:</label>
                    <input type="text" class="form-control" id="inpSalarioCargo_e" runat="server" />
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
                <label>Eliminar Cargo</label>
                <a id="" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="lblIdCargoEliminar" class="col-form-label">Está a punto de eliminar el cliente con el identificador:</label>
                    <asp:Label ID="lblIdCargoEliminar" runat="server" Text=""></asp:Label>
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
