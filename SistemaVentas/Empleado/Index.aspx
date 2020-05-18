<%@ Page Title="Empleado" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.Empleado.Index" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="col">
    
        <h5 class="mt-3 d-block titulo">Listado de Empleados</h5>

    
        <div class="row mt-2"> 
        
            <div class="col text-left">
                <asp:TextBox ID="txtBuscar" CssClass="b-inline-block form-size ml-2 btn-opc down pl-2" runat="server"></asp:TextBox>
                <asp:Button ID="btnBuscar" CssClass="btn b-inline-block btn-small ml-2" runat="server" Text="Buscar" OnClick="btnBuscar_OnClick" />
            </div>

            <div class="col text-right">
                <asp:LinkButton ID="btnCrearEmpleado" CssClass="btn btn-small btn-primary b-inline-block mr-3" runat="server" CommandName="crear" CommandArgument='<%#Eval("idEmpleado") %>' OnClick="btnCrearEmpleado_OnClick">Crear Empleado</asp:LinkButton>
            </div>
    
        </div>

        <div class="round-border mt-3">

            <asp:GridView ID="GridView1" CssClass="table table-sm  table-striped text-center" runat="server" AutoGenerateColumns="False" DataKeyNames="idEmpleado" OnRowCommand="GridView1_OnRowCommand" AllowPaging="True" PageSize="10" OnPageIndexChanging="GridView1_OnPageIndexChanging">
                <Columns>
                    <asp:BoundField DataField="idEmpleado" HeaderText="ID" />
                    <asp:TemplateField HeaderText="Fotografía" SortExpression="">
                        <ItemTemplate>
                            <asp:Image ID="Image1" CssClass="img-fix" runat="server" ImageUrl='<%#"data:Image/jpg;jpg;base64," + Convert.ToBase64String((byte[])Eval("fotografiaEmpleado"))%>'/>
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

        </div>


        <!--contador de botones para cambiar de index-->

        <div class="mt-3">

            <p class="d-inline-block ml-3 font-weight-light p-size">Mostrando del 1 al 10 de 100 clientes</p>

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
    <asp:Panel ID="modalCrear" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 1vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,1vw); -moz-transform: translate(-50%,1vw); -ms-transform: translate(-50%,1vw); -o-transform: translate(-50%,1vw); transform: translate(-50%,1vw); width: 80%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Crear Empleado</label>
                <a style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div class="">
                    <div id="vistaPreviaImagen" class="m-auto"></div>
                    <asp:FileUpload ID="FileUpload1_c" CssClass="mt-2" accept=".jpg" runat="server" />
                </div>

                <div class="mt-3">
                    <div class="d-inline">
                        <label for="inpFechaContratoEmpleado_c" class="col-form-label mr-2">Contrato:</label>
                        <input type="date" class="form-control d-inline" id="inpFechaContratoEmpleado_c" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpFechaNacimientoEmpleado_c" class="col-form-label mx-2">Nacimiento:</label>
                        <input type="date" class="form-control d-inline" id="inpFechaNacimientoEmpleado_c" runat="server" />
                    </div>
                </div>
                
                <div class="mt-3">
                    <div class="d-inline">
                        <label for="inpPrimerNombreEmpleado_c" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" placeholder="Primer nombre" class="form-control d-inline" id="inpPrimerNombreEmpleado_c" runat="server" />
                    </div>
                     <div class="d-inline">
                        <label for="inpSegundoNombreEmpleado_c" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" placeholder="Segundo nombre" class="form-control d-inline" id="inpSegundoNombreEmpleado_c" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpPrimerApellidoEmpleado_c" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" placeholder="Primer apellido" class="form-control d-inline" id="inpPrimerApellidoEmpleado_c" runat="server" />
                    </div>
                </div>
                
                               
                <div class="mt-3">
                    <div class="d-inline">
                        <label for="inpSegundoApellidoEmpleado_c" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" placeholder="Segundo apellido" class="form-control d-inline" id="inpSegundoApellidoEmpleado_c" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpDuiEmpleado_c" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" placeholder="DUI" class="form-control d-inline" id="inpDuiEmpleado_c" runat="server" />
                    </div>
                     <div class="d-inline">
                        <label for="inpTelefonoEmpleado_c" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="tel" placeholder="Telefono" class="form-control d-inline" id="inpTelefonoEmpleado_c" runat="server" />
                    </div>
                </div>
                
                <div class="mt-3">
                    <div class="d-inline">
                        <label for="inpNitEmpleado_c" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" placeholder="NIT" class="form-control d-inline" id="inpNitEmpleado_c" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="ddlSexo_c"><i class="far fa-user d-inline mx-2"></i></label>
                        <asp:DropDownList runat="server" CssClass="d-inline drop" AppendDataBoundItems="true"  ID="ddlSexo_c">
                            <Items>
                                <asp:ListItem Text="Masculino" Value="M" />
                                <asp:ListItem Text="Femenino" Value="F" />
                            </Items>
                        </asp:DropDownList>
                    </div>
                    <div class="d-inline">
                        <label for="inpCorreoEmpleado_c" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="email" placeholder="Correo" class="form-control d-inline" id="inpCorreoEmpleado_c" runat="server" />
                    </div>
                </div>
                
                
                <div class="mt-3">
                    <div class="d-inline">
                        <label for="ddlDepartamento_c"><i class="far fa-user d-inline mr-2"></i></label>
                        <asp:DropDownList runat="server" CssClass="d-inline drop" AppendDataBoundItems="true" ID="ddlDepartamento_c">
                            <Items>
                                <asp:ListItem Text="Ahuachapán" Value="Ahuachapán"/>
                                <asp:ListItem Text="Cabañas" Value="Cabañas"/>
                                <asp:ListItem Text="Chalatenango" Value="Chalatenango"/>
                                <asp:ListItem Text="La Libertad" Value="La Libertad"/>
                                <asp:ListItem Text="La Paz" Value="La Paz"/>
                                <asp:ListItem Text="La Unión" Value="La Union"/>
                                <asp:ListItem Text="Morazán" Value="Morazan"/>
                                <asp:ListItem Text="San Miguel" Value="San Miguel"/>
                                <asp:ListItem Text="San Salvador" Value="San Salvador"/>
                                <asp:ListItem Text="San Vicente" Value="San Vicente"/>
                                <asp:ListItem Text="Santa Ana" Value="Santa Ana"/>
                                <asp:ListItem Text="Sonsonate" Value="Sonsonate"/>
                                <asp:ListItem Text="Usulután" Value="Usulutan"/>
                            </Items>
                        </asp:DropDownList>
                    </div>
                    <div class="d-inline">
                        <label for="inpMunicipioEmpleado_c"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" placeholder="Municipio" class="form-control d-inline" id="inpMunicipioEmpleado_c" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="ddlCargo_c"><i class="far fa-user d-inline mx-2"></i></label>
                        <asp:DropDownList ID="ddlCargo_c" CssClass="d-inline drop" runat="server"></asp:DropDownList>
                    </div>
                </div>

                <div class="mt-3">
                    <div class="d-inline">
                        <label for="txtDetallesDireccionEmpleado_c" class="col-form-label"><i class="far fa-user d-inline mx-2 mb-3"></i></label>
                        <textarea  runat="server" placeholder="Detalles direcccion" class="form-control d-inline drop" id="txtDetallesDireccionEmpleado_c" cols="20" rows="2"></textarea>
                    </div>
                </div>

            </div>
            <div class="modal-footer-mio text-center">
                
                <asp:Button ID="btnCrear" CssClass="mod" CommandName="Crear" runat="server" Text="Crear" OnClick="btnCrear_OnClick" />
                <button type="button" class="mod" runat="server" OnServerClick="cerrarTodo">Cancelar</button>
            </div>

        </div>
    </asp:Panel>
    <!--Termina Modal Crear-->


    <!--Inicia Modal Detalles-->
    <asp:Panel ID="modalDetalles" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 1vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,1vw); -moz-transform: translate(-50%,1vw); -ms-transform: translate(-50%,1vw); -o-transform: translate(-50%,1vw); transform: translate(-50%,1vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Detalles Empleados</label>
                <a style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                 <div>
                    <asp:Image ID="imgFotografiaEmpleado" CssClass="m-auto" runat="server" />
                </div>
                <div>
                    <label for="lblIdEmpleado" class="mt-2">ID:</label>
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
            <div class="modal-footer-mio text-center">
                <asp:Button ID="btnImprimir" CssClass="mod" runat="server" Text="Imprimir" />
                <button type="button" class="mod" runat="server" OnServerClick="cerrarTodo">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Detalles-->


    <!--Inicia Modal Editar-->
    <asp:Panel ID="modalEditar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 1vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,1vw); -moz-transform: translate(-50%,1vw); -ms-transform: translate(-50%,1vw); -o-transform: translate(-50%,1vw); transform: translate(-50%,1vw); width: 80%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Editar Empleado</label>
                <a style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">

                <div class="">
                    <div>
                        <img runat="server" id="imgFotografiaEmpleado_e" class="m-auto d-block" alt="fotografia" />
                        <asp:FileUpload ID="FileUpload1_e" CssClass="mt-2" runat="server" />
                    </div>
                </div>
                
                <div class="mt-3">
                    <div class="d-inline">
                        <label for="inpFechaNacimientoEmpleado_e" class="col-form-label mr-2">Nacimiento:</label>
                        <input type="text" class="form-control d-inline" id="inpFechaNacimientoEmpleado_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpFechaContrato_e" class="col-form-label mx-2">Contrato:</label>
                        <input type="text" class="form-control d-inline" id="inpFechaContrato_e" runat="server" />
                    </div>
                </div>
                
                
                <div class="mt-3">
                    <div class="d-inline">
                        <label for="inpIdEmpleado_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpIdEmpleado_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="ddlCargo_e" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <asp:DropDownList ID="ddlCargo_e" CssClass="d-inline drop" runat="server"></asp:DropDownList>
                    </div>
                    <div class="d-inline">
                        <label for="inpPrimerNombreEmpleado_e" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpPrimerNombreEmpleado_e" runat="server" />
                    </div>
                </div>
                
                <div class="mt-3">
                    <div class="d-inline">
                        <label for="inpSegundoNombreEmpleado_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpSegundoNombreEmpleado_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpPrimerApellidoEmpleado_e" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpPrimerApellidoEmpleado_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpSegundoApellidoEmpleado_e" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpSegundoApellidoEmpleado_e" runat="server" />
                    </div>
                </div>
                
                <div class="mt-3">
                    <div class="d-inline">
                        <label for="inpDuiEmpleado_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpDuiEmpleado_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpNitEmpleado_e" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpNitEmpleado_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="ddlDepartamento_e"><i class="far fa-user d-inline mx-2"></i></label>
                        <asp:DropDownList runat="server" CssClass="d-inline drop" AppendDataBoundItems="true" ID="ddlDepartamento_e">
                            <Items>
                                <asp:ListItem Text="Ahuachapán" Value="Ahuachapán"/>
                                <asp:ListItem Text="Cabañas" Value="Cabañas"/>
                                <asp:ListItem Text="Chalatenango" Value="Chalatenango"/>
                                <asp:ListItem Text="La Libertad" Value="La Libertad"/>
                                <asp:ListItem Text="La Paz" Value="La Paz"/>
                                <asp:ListItem Text="La Unión" Value="La Union"/>
                                <asp:ListItem Text="Morazán" Value="Morazan"/>
                                <asp:ListItem Text="San Miguel" Value="San Miguel"/>
                                <asp:ListItem Text="San Salvador" Value="San Salvador"/>
                                <asp:ListItem Text="San Vicente" Value="San Vicente"/>
                                <asp:ListItem Text="Santa Ana" Value="Santa Ana"/>
                                <asp:ListItem Text="Sonsonate" Value="Sonsonate"/>
                                <asp:ListItem Text="Usulután" Value="Usulutan"/>
                            </Items>
                        </asp:DropDownList>
                    </div>
                </div>
                
                <div class="mt-3">
                    <div class="d-inline">
                        <label for="inpMunicipioEmpleado_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="text" class="form-control d-inline" id="inpMunicipioEmpleado_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="inpTelefonoEmpleado_e" class="col-form-label"><i class="far fa-user d-inline mx-2"></i></label>
                        <input type="tel" class="form-control d-inline" id="inpTelefonoEmpleado_e" runat="server" />
                    </div>
                </div>
                
                <div class="mt-3">
                    <div class="d-inline">
                        <label for="inpCorreoEmpleado_e" class="col-form-label"><i class="far fa-user d-inline mr-2"></i></label>
                        <input type="email" class="form-control d-inline" id="inpCorreoEmpleado_e" runat="server" />
                    </div>
                    <div class="d-inline">
                        <label for="ddlSexo_e"><i class="far fa-user d-inline mx-2"></i></label>
                        <asp:DropDownList runat="server" CssClass="d-inline drop" AppendDataBoundItems="true"  ID="ddlSexo_e">
                            <Items>
                                <asp:ListItem Text="Masculino" Value="M" />
                                <asp:ListItem Text="Femenino" Value="F" />
                            </Items>
                        </asp:DropDownList>
                    </div>
                </div>
                
                <div class="mt-3">
                    <div>
                        <label for="txtDetallesDireccionEmpleado_e" class="col-form-label"><i class="far fa-user d-inline mr-2 mb-2"></i></label>
                        <textarea runat="server" id="txtDetallesDireccionEmpleado_e" cols="20" rows="2" class="form-control d-inline drop"></textarea>
                    </div>
                </div>


            </div>
            <div class="modal-footer-mio text-center">
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
                <label>Eliminar Empleado</label>
                <a style="float: right; text-decoration: none" runat="server" OnServerClick="cerrarTodo">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <label for="lblIdEmpleadoEliminar" class="col-form-label">Está a punto de eliminar el empleado con el identificador:</label>
                    <asp:Label ID="lblIdEmpleadoEliminar" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio text-center mt-3">
                <asp:Button ID="btnEliminar" CssClass="mod" CommandName="" runat="server" Text="Eliminar" OnClick="btnEliminar_OnClick" />
                <button type="button" class="mod" runat="server" OnServerClick="cerrarTodo">Cancelar</button>
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

        

        /*empleado*/

        .img-fix {

            width: 4rem;
            height: 4rem;
            border-radius: 100px;
        }

        #GridView1 td{
        
            line-height: 4rem;
        
        }

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

        var bForm = $("#btnCrear");
        var bFormE = $("#btnActualizar")


        var crearEmpleado = [$("#vistaPreviaImagen").attr("src"), $("#inpFechaContratoEmpleado_c"), $("#inpFechaNacimientoEmpleado_c"), $("#inpPrimerNombreEmpleado_c"),
        $("#inpSegundoNombreEmpleado_c"), $("#inpPrimerApellidoEmpleado_c"), $("#inpSegundoApellidoEmpleado_c"), $("#inpDuiEmpleado_c"), $("#inpTelefonoEmpleado_c"), $("#inpNitEmpleado_c"), $("#ddlSexo_c"), $("#inpCorreoEmpleado_c"), $("#ddlDepartamento_c"), $("#inpMunicipioEmpleado_c"), $("#ddlCargo_c"), $("#txtDetallesDireccionEmpleado_c"), $("#vistaPreviaImagen")]


        var updaEmpleado = [$("#imgFotografiaEmpleado_e").attr("src"), $("#inpFechaContrato_e"), $("#inpFechaNacimientoEmpleado_e"), $("#inpPrimerNombreEmpleado_e"),
        $("#inpSegundoNombreEmpleado_e"), $("#inpPrimerApellidoEmpleado_e"), $("#inpSegundoApellidoEmpleado_e"), $("#inpDuiEmpleado_e"), $("#inpTelefonoEmpleado_e"), $("#inpNitEmpleado_e"), $("#ddlSexo_e"), $("#inpCorreoEmpleado_e"), $("#ddlDepartamento_e"), $("#inpMunicipioEmpleado_e"), $("#ddlCargo_e"), $("#txtDetallesDireccionEmpleado_e"), $("#imgFotografiaEmpleado_e")]

        bForm.on("click", function (event) {

            checkInputs(crearEmpleado);

            //no estoy chequeando si el index 0 tiene la clase fail porque el fail se aplica a el index 16 que es el marco donde aparece

            if (crearEmpleado[1].hasClass("fail") || crearEmpleado[2].hasClass("fail") || crearEmpleado[3].hasClass("fail") || crearEmpleado[4].hasClass("fail") || crearEmpleado[5].hasClass("fail") || crearEmpleado[6].hasClass("fail") || crearEmpleado[7].hasClass("fail") || crearEmpleado[8].hasClass("fail") || crearEmpleado[9].hasClass("fail") || crearEmpleado[10].hasClass("fail") || crearEmpleado[11].hasClass("fail") || crearEmpleado[12].hasClass("fail") || crearEmpleado[13].hasClass("fail") || crearEmpleado[14].hasClass("fail") || crearEmpleado[15].hasClass("fail") || crearEmpleado[16].hasClass("fail")) {

                event.preventDefault();

            }

        });


        bFormE.on("click", function (event) {

            checkInputs(updaEmpleado);

            if (updaEmpleado[1].hasClass("fail") || updaEmpleado[2].hasClass("fail") || updaEmpleado[3].hasClass("fail") || updaEmpleado[4].hasClass("fail") || updaEmpleado[5].hasClass("fail") || updaEmpleado[6].hasClass("fail") || updaEmpleado[7].hasClass("fail") || updaEmpleado[8].hasClass("fail") || updaEmpleado[9].hasClass("fail") || updaEmpleado[10].hasClass("fail") || updaEmpleado[11].hasClass("fail") || updaEmpleado[12].hasClass("fail") || updaEmpleado[13].hasClass("fail") || updaEmpleado[14].hasClass("fail") || updaEmpleado[15].hasClass("fail") || updaEmpleado[16].hasClass("fail")) {

                event.preventDefault();

            }

        });


        function checkInputs(lista) {

            var img = lista[0];
            var fechaContrato = lista[1];
            var fechaNacimiento = lista[2];
            var pNombre = lista[3];
            var sNombre = lista[4];
            var pApell = lista[5];
            var sApell = lista[6];
            var dui = lista[7];
            var telefono = lista[8]
            var nit = lista[9];
            var sexo = lista[10];
            var correo = lista[11];
            var departamento = lista[12];
            var municipio = lista[13];
            var cargo = lista[14];
            var detalleDir = lista[15];
            var marco = lista[16];


            /*var pNombre = lista[0];
            var sNombre = lista[1];
            var pApell = lista[2];
            var sApell = lista[3];
            var dui = lista[4];
            var nit = lista[5];
            var telefono = lista[6];
            var id = lista[7];*/


            /*esto da problemas

            if (id.val().trim() === '') {
                setErrorFor(id, "campo obligatorio");
            }
            else {
                setSuccessFor(id);
            }*/


            //verificacion primer nombre

            if (pNombre.val().trim() === '') {
                setErrorFor(pNombre, "campo obligatorio");
            }
            else {
                setSuccessFor(pNombre);
            }

            //verificacion sexo

            if (sexo.val().trim() === '') {
                setErrorFor(sexo, "campo obligatorio");
            }
            else {
                setSuccessFor(sexo);
            }

            //verificacion departamento

            if (departamento.val().trim() === '') {
                setErrorFor(departamento, "campo obligatorio");
            }
            else {
                setSuccessFor(departamento);
            }

            //verificacion cargo

            if (cargo.val().trim() === '') {
                setErrorFor(cargo, "campo obligatorio");
            }
            else {
                setSuccessFor(cargo);
            }

            //verificacion fecha nacimiento

            if (fechaNacimiento.val().trim() === '') {
                setErrorFor(fechaNacimiento, "campo obligatorio");
            }
            else {
                setSuccessFor(fechaNacimiento);
            }

            //verificacion fecha contrato

            if (fechaContrato.val().trim() === '') {
                setErrorFor(fechaContrato, "campo obligatorio");
            }
            else {
                setSuccessFor(fechaContrato);
            }

            //verificacion detalles direccion

            if (detalleDir.val().trim() === '') {
                setErrorFor(detalleDir, "campo obligatorio");
            }
            else {
                setSuccessFor(detalleDir);
            }

            //verificacion municipio

            if (municipio.val().trim() === '') {
                setErrorFor(municipio, "campo obligatorio");
            }
            else {
                setSuccessFor(municipio);
            }

            //verificacion imagen

            if (img === '') {
                setErrorFor(marco, "campo obligatorio");
            }
            else {
                setSuccessFor(marco);
            }

            //verificacion segundo nombre

            if (sNombre.val().trim() === '') {
                setErrorFor(sNombre, "campo obligatorio");
            }
            else {
                setSuccessFor(sNombre);
            }

            //verificacion primer apellido

            if (pApell.val().trim() === '') {
                setErrorFor(pApell, "campo obligatorio");
            }
            else {
                setSuccessFor(pApell);
            }

            // segundo apellido

            if (sApell.val().trim() === '') {
                setErrorFor(sApell, "campo obligatorio");
            }
            else {
                setSuccessFor(sApell);
            }

            //dui

            if (isDui(dui.val().trim())) {

                setSuccessFor(dui);

            }

            else if (dui.val().trim() === '') {
                setErrorFor(dui, "campo obligatorio");
            }

            else {
                setErrorFor(dui, "dui invalido");
            }


            //correo

            if (isEmail(correo.val().trim())) {

                setSuccessFor(correo);

            }

            else if (correo.val().trim() === '') {
                setErrorFor(correo, "campo obligatorio");
            }

            else {
                setErrorFor(correo, "correo invalido");
            }


            //nit

            if (isNit(nit.val().trim())) {

                setSuccessFor(nit);

            }
            else if (nit.val().trim() === '') {
                setErrorFor(nit, "campo obligatorio");
            }

            else {
                setErrorFor(nit, "nit invalido");
            }

            //telefono

            if (isPho(telefono.val().trim())) {

                setSuccessFor(telefono);

            }
            else if (telefono.val().trim() === '') {
                setErrorFor(telefono, "campo obligatorio");
            }
            else {
                setErrorFor(telefono, "telefono invalido");
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

        function isDui(d) {
            //aqui va la regrex para dui
            return /^\d{8}-\d{1}$/.test(d)
        }

        function isNit(n) {
            //aqui va la regrex para nit
            return /^\d{8}$/.test(n)
        }

        function isPho(p) {
            //aqui va la regrex para nit
            return /^[2-7]-?\d{7}$/.test(p)
        }

        function isEmail(em) {
            return /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(em);
        }




    </script>
</asp:Content>
