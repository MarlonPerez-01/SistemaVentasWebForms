<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Empleado.Index" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Listado de Empleados</h1>

    <div class="w-100"></div>

    <asp:TextBox ID="txtBuscar" runat="server"></asp:TextBox>
    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_OnClick" />

    <asp:LinkButton ID="btnCrearEmpleado" runat="server" CommandName="crear" CommandArgument='<%#Eval("idEmpleado") %>' OnClick="btnCrearEmpleado_OnClick"><i class="fas fa-search-plus"></i>Crear Empleado</asp:LinkButton>

    <div class="w-100"></div>


    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="idEmpleado" OnRowCommand="GridView1_OnRowCommand" AllowPaging="True" PageSize="10" OnPageIndexChanging="GridView1_OnPageIndexChanging">
        <Columns>
            <asp:BoundField DataField="idEmpleado" HeaderText="ID" />
            <asp:TemplateField HeaderText="Fotografía" SortExpression="">
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" Height="100px" Width="100px" ImageUrl='<%#"data:Image/jpg;jpg;base64," + Convert.ToBase64String((byte[])Eval("fotografiaEmpleado"))%>'/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="primerNombreEmpleado" HeaderText="Nombre" />
            <asp:BoundField DataField="primerApellidoEmpleado" HeaderText="Apellido" />
            <asp:BoundField DataField="nombreCargo" HeaderText="Cargo" />
            <asp:BoundField DataField="telefonoEmpleado" HeaderText="Telefono" />
            <asp:BoundField DataField="correoEmpleado" HeaderText="Correo" />
            <asp:BoundField DataField="fechaContrato" HeaderText="Fecha de Contrato" />

            <asp:TemplateField HeaderText="Detalles" SortExpression="">
                <ItemTemplate>
                    <asp:LinkButton ID="btnDetalles" runat="server" CommandName="detalles" CommandArgument='<%#Eval("idEmpleado") %>'><i class="fas fa-search-plus"></i></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Editar" SortExpression="">
                <ItemTemplate>
                    <asp:LinkButton ID="btnEditar" runat="server" CommandName="editar" CommandArgument='<%#Eval("idEmpleado") %>'><i class="fas fa-pencil-alt"></i></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Eliminar" SortExpression="">
                <ItemTemplate>
                    <asp:LinkButton ID="btnEliminar" runat="server" CommandName="eliminar" CommandArgument='<%#Eval("idEmpleado") %>'><i class="fas fa-trash-alt"></i></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <div id="fondoModal"></div>
    <!--Inicia Modal Crear-->
    <asp:Panel ID="modalCrear" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio">
                <label>Crear Empleado</label>
                <a style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="ddlCargo_c">Cargo:</label>
                    <asp:DropDownList ID="ddlCargo_c" runat="server"></asp:DropDownList>
                </div>
                <div>
                    <label for="inpPrimerNombreEmpleado_c" class="col-form-label">Primer Nombre:</label>
                    <input type="text" class="form-control" id="inpPrimerNombreEmpleado_c" runat="server" />
                </div>
                <div>
                    <label for="inpSegundoNombreEmpleado_c" class="col-form-label">Segundo Nombre:</label>
                    <input type="text" class="form-control" id="inpSegundoNombreEmpleado_c" runat="server" />
                </div>
                <div>
                    <label for="inpPrimerApellidoEmpleado_c" class="col-form-label">Primer Apellido:</label>
                    <input type="text" class="form-control" id="inpPrimerApellidoEmpleado_c" runat="server" />
                </div>
                <div>
                    <label for="inpSegundoApellidoEmpleado_c" class="col-form-label">Segundo Apellido:</label>
                    <input type="text" class="form-control" id="inpSegundoApellidoEmpleado_c" runat="server" />
                </div>
                <div>
                    <label for="inpDuiEmpleado_c" class="col-form-label">DUI:</label>
                    <input type="text" class="form-control" id="inpDuiEmpleado_c" runat="server" />
                </div>
                <div>
                    <label for="inpNitEmpleado_c" class="col-form-label">NIT:</label>
                    <input type="text" class="form-control" id="inpNitEmpleado_c" runat="server" />
                </div>
                <div>
                    <asp:FileUpload ID="FileUpload1_c" accept=".jpg" runat="server" />
                    <div id="vistaPreviaImagen"></div>
                </div>
                <div>
                    <label for="inpFechaNacimientoEmpleado_c" class="col-form-label">Fecha de Nacimiento:</label>
                    <input type="date" class="form-control" id="inpFechaNacimientoEmpleado_c" runat="server" />
                </div>
                <div>
                    <label for="inpFechaContratoEmpleado_c" class="col-form-label">Fecha de Contrato:</label>
                    <input type="date" class="form-control" id="inpFechaContratoEmpleado_c" runat="server" />
                </div>
                <div>
                    <label for="inpTelefonoEmpleado_c" class="col-form-label">Teléfono:</label>
                    <input type="tel" class="form-control" id="inpTelefonoEmpleado_c" runat="server" />
                </div>
                <div>
                    <label for="inpCorreoEmpleado_c" class="col-form-label">Correo:</label>
                    <input type="email" class="form-control" id="inpCorreoEmpleado_c" runat="server" />
                </div>
                <div>
                    <label for="ddlSexo_c">Sexo:</label>
                    <asp:DropDownList runat="server" AppendDataBoundItems="true"  ID="ddlSexo_c">
                        <Items>
                            <asp:ListItem Text="Masculino" Value="M" />
                            <asp:ListItem Text="Femenino" Value="F" />
                        </Items>
                    </asp:DropDownList>
                </div>
                <div>
                    <label for="ddlDepartamento_c">Departamento:</label>
                    <asp:DropDownList runat="server" AppendDataBoundItems="true" ID="ddlDepartamento_c">
                        <Items>
                            <asp:ListItem Text="Ahuachapán" />
                            <asp:ListItem Text="Cabañas" />
                            <asp:ListItem Text="Chalatenango" />
                            <asp:ListItem Text="La Libertad" />
                            <asp:ListItem Text="La Paz" />
                            <asp:ListItem Text="La Unión" />
                            <asp:ListItem Text="Morazán" />
                            <asp:ListItem Text="San Miguel" />
                            <asp:ListItem Text="San Salvador" />
                            <asp:ListItem Text="San Vicente" />
                            <asp:ListItem Text="Santa Ana" />
                            <asp:ListItem Text="Sonsonate" />
                            <asp:ListItem Text="Usulután" />
                        </Items>
                    </asp:DropDownList>
                </div>
                <div>
                    <label for="inpMunicipioEmpleado_c">Municipio:</label>
                    <input type="text" class="form-control" id="inpMunicipioEmpleado_c" runat="server" />
                </div>
                <div>
                    <label for="txtDetallesDireccionEmpleado_c" class="col-form-label">Detalles de la Dirección:</label>
                    <textarea class="form-control" id="txtDetallesDireccionEmpleado_c" cols="20" rows="2" runat="server"></textarea>
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
                <label>Detalles Empleados</label>
                <a style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="lblIdEmpleado">ID:</label>
                    <asp:Label ID="lblIdEmpleado" runat="server"></asp:Label>
                </div>
                <div>
                    <label for="lblNombreEmpleado">Nombre:</label>
                    <asp:Label ID="lblNombreEmpleado" runat="server"></asp:Label>
                </div>
                <div>
                    <label for="lblDuiEmpleado">DUI:</label>
                    <asp:Label ID="lblDuiEmpleado" runat="server"></asp:Label>
                </div>
                <div>
                    <label for="lblNitEmpleado">NIT:</label>
                    <asp:Label ID="lblNitEmpleado" runat="server"></asp:Label>
                </div>
                <div>
                    <label for="lblFotografiaEmpleado">Fotografía:</label>
                    <asp:Image ID="imgFotografiaEmpleado" runat="server" />
                </div>
                <div>
                    <label for="lblSexoEmpleado">Sexo:</label>
                    <asp:Label ID="lblSexoEmpleado" runat="server"></asp:Label>
                </div>
                <div>
                    <label for="lblFechaNacimientoEmpleado">Fecha de Nacimiento:</label>
                    <asp:Label ID="lblFechaNacimientoEmpleado" runat="server"></asp:Label>
                </div>
                <div>
                    <label for="lblFechaContrato">Fecha de Contrato:</label>
                    <asp:Label ID="lblFechaContrato" runat="server"></asp:Label>
                </div>
                <div>
                    <label for="lblTelefonoEmpleado">Telefono:</label>
                    <asp:Label ID="lblTelefonoEmpleado" runat="server"></asp:Label>
                </div>
                <div>
                    <label for="lblCorreoEmpleado">Correo:</label>
                    <asp:Label ID="lblCorreoEmpleado" runat="server"></asp:Label>
                </div>
                <div>
                    <label for="lblDireccionEmpleado">Dirección:</label>
                    <asp:Label ID="lblDireccionEmpleado" runat="server"></asp:Label>
                <div>
                </div>
                    <label for="lblNombreCargo">Cargo:</label>
                    <asp:Label ID="lblNombreCargo" runat="server"></asp:Label>
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
                <label>Editar Empleado</label>
                <a style="float: right; text-decoration: none" class="cerrar">X</a>
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
                    <label for="inpTelefonoCliente_e" class="col-form-label">Fotografía:</label>
                    <input type="text" class="form-control" id="inpTelefonoCliente_e" runat="server" />
                </div>
                <div>
                    <label for="inpTelefonoCliente_e" class="col-form-label">Fecha de Nacimiento:</label>
                    <input type="text" class="form-control" id="Text1" runat="server" />
                </div>
                <div>
                    <label for="inpFechaContratoEmpleado_e" class="col-form-label">Fecha de Contrato:</label>
                    <input type="text" class="form-control" id="inpFechaContratoEmpleado_e" runat="server" />
                </div>
                <div>
                    <label for="inpTelefonoEmpleado_e" class="col-form-label">Telefono:</label>
                    <input type="text" class="form-control" id="inpTelefonoEmpleado_e" runat="server" />
                </div>
                <div>
                    <label for="inpCorreoEmpleado_e" class="col-form-label">Correo:</label>
                    <input type="text" class="form-control" id="inpCorreoEmpleado_e" runat="server" />
                </div>
                <div>
                    <label for="inpTelefonoCliente_e" class="col-form-label">Departamento:</label>
                    <asp:DropDownList runat="server"/>
                </div>
                <div>
                    <label for="inpMunicipioEmpleado_e" class="col-form-label">Municipio:</label>
                    <input type="text" class="form-control" id="inpMunicipioEmpleado_e" runat="server" />
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
                <label>Eliminar Empleado</label>
                <a style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio">
                <div>
                    <label for="lblIdEmpleadoEliminar" class="col-form-label">Está a punto de eliminar el empleado con el identificador:</label>
                    <asp:Label ID="lblIdEmpleadoEliminar" runat="server" Text=""></asp:Label>
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
