<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="SistemaVentas.Empleado.Create" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col">

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="ddlIdCargo" class="col-form-label">Cargo:</label>
                <asp:DropDownList ID="ddlIdCargo" runat="server">
                </asp:DropDownList>
            </div>
            <div class="form-group col-md-6">
                <label for="inpPrimerNombreEmpleado" class="col-form-label">Primer Nombre:</label>
                <input type="text" class="form-control" id="inpPrimerNombreEmpleado" runat="server" />
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="inpSegundoNombreEmpleado" class="col-form-label">Segundo Nombre:</label>
                <input type="text" class="form-control" id="inpSegundoNombreEmpleado" runat="server" />
            </div>
            <div class="form-group col-md-6">
                <label for="inpPrimerApellidoEmpleado" class="col-form-label">Primer Apellido:</label>
                <input type="text" class="form-control" id="inpPrimerApellidoEmpleado" runat="server" />
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="inpSegundoApellidoEmpleado" class="col-form-label">Segundo Apellido:</label>
                <input type="text" class="form-control" id="inpSegundoApellidoEmpleado" runat="server" />
            </div>

            <div class="form-group col-md-6">
                <label for="inpDuiEmpleado" class="col-form-label">DUI:</label>
                <input type="text" class="form-control" id="inpDuiEmpleado" runat="server" />
            </div>
        </div>


        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="inpNitEmpleado" class="col-form-label">NIT:</label>
                <input type="text" class="form-control" id="inpNitEmpleado" runat="server" />
            </div>

            <div class="form-group col-md-6">
                <label for="fuFotografiaEmpleado" class="col-form-label">Fotografía:</label>
                <asp:FileUpload ID="fuFotografiaEmpleado" runat="server" />
                <asp:Label ID="lblFotografiaEmpleado" runat="server"></asp:Label>
                <asp:Button ID="btnCargarFotografia" runat="server" Text="Button" OnClick="btnCargarFotografia_OnClick" />
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="inpFechaNacimientoEmpleado" class="col-form-label">Fecha de Nacimiento:</label>
                <input type="date" class="form-control" id="inpFechaNacimientoEmpleado" runat="server" />
            </div>

            <div class="form-group col-md-6">
                <label for="inpFechaContrato" class="col-form-label">Fecha de Contrato:</label>
                <input type="date" class="form-control" id="inpFechaContrato" runat="server" />
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="inpTelefonoEmpleado" class="col-form-label">Teléfono:</label>
                <input type="tel" class="form-control" id="inpTelefonoEmpleado" runat="server" />
            </div>

            <div class="form-group col-md-6">
                <label for="inpCorreoEmpleado" class="col-form-label">Correo:</label>
                <input type="email" class="form-control" id="inpCorreoEmpleado" runat="server" />
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="ddlSexo" class="col-form-label">Sexo:</label>
                <select name="select" id="ddlSexo" runat="server">
                    <option value="M">Masculino</option>
                    <option value="F">Femenino</option>
                </select>
            </div>

            <div class="form-group col-md-6">
                <label for="inpDepartamentoEmpleado" class="col-form-label">Departamento:</label>
                <input type="text" class="form-control" id="inpDepartamentoEmpleado" runat="server" />
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="inpMunicipioEmpleado" class="col-form-label">Municipio:</label>
                <input type="text" class="form-control" id="inpMunicipioEmpleado" runat="server" />
            </div>

            <div class="form-group col-md-6">
                <label for="inpDetallesDireccionEmpleado" class="col-form-label">Detalles:</label>
                <input type="text" class="form-control" id="inpDetallesDireccionEmpleado" runat="server" />
            </div>
        </div>

        <div class="row">
            <div class="col">
                <asp:Button ID="btnRegresar" runat="server" CssClass="btn btn-secondary" Text="Regresar" OnClick="btnRegresar_OnClicksar_OnClick" />
            </div>
            <div class="col">
                <asp:Button ID="btnCrearEmpleado" runat="server" CssClass="btn btn-primary" Text="Agregar Cliente" OnClick="btnCrearEmpleado_OnClick" />
            </div>
        </div>
        <asp:Label ID="lblMensaje" runat="server" Text=""></asp:Label>
    </div>
</asp:Content>
