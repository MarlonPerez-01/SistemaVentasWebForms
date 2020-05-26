<%@ Page Title="PuntoDeCompra" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.PuntoDeCompra.Index" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="col">
    
    
        <div class="row">
            <div class="col text-right">
                <h5 class="titulo d-inline title-fix">Listado de Compra</h5>
            </div>
            <div class="col">
                <asp:LinkButton ID="btnCrearCompra" CssClass="btn btn-small btn-primary mr-3" runat="server" CommandName="crear" CommandArgument='<%#Eval("idCompra") %>' OnClick="btnCrearCompra_OnClick">Crear Compra</asp:LinkButton>
            </div>
        </div>    

        <div class="row">

            <div class="datosCompra col">
            
                <div class="row">
                    <div class="col text-right mt-3">
                        <label for="inpIdCompra"><i class="fas fa-box-open d-inline mr-2"></i></label>
                        <input id="inpIdCompra" class="drop" runat="server" type="text" disabled="disabled"/>
                    </div>
                    <div class="col mt-3">
                        <label for="inpNombreProveedor"><i class="far fa-user d-inline mx-2"></i></label>
                        <input id="inpNombreProveedor" class="drop" runat="server" type="text" disabled="disabled"/>
                    </div>
                </div>
                
                <div class="row">       
                    <div class="col text-right mt-3">
                        <label for="inpNombreEmpleado"><i class="far fa-user d-inline mr-2"></i></label>
                        <input id="inpNombreEmpleado" class="drop" runat="server" type="text" disabled="disabled"/>
                    </div>
                    <div class="col mt-3">
                        <label for="inpFechaCompra"><i class="far fa-calendar-alt d-inline mx-2"></i></label>
                        <input id="inpFechaCompra" class="drop" runat="server" type="text" disabled="disabled"/>
                    </div>
                </div>
                
            
                <div class="row">
                    <div class="col text-center mt-3">
                        <label for="inpHoraCompra"><i class="far fa-clock d-inline mx-2"></i></label>
                        <input id="inpHoraCompra" class="drop" runat="server" type="text" disabled="disabled"/>
                    </div>
                </div>


            </div>

        </div>
    
        

        <div class="row">


            <div class="detalle-compra col">
                <h5 class="mt-3 d-block titulo">Agregar Productos a la Compra</h5>
                
                
                <div class="row">
                    <div class="col text-right">
                        <label for="ddlProducto_dc"><i class="fas fa-box-open d-inline mr-2"></i></label>
                        <asp:DropDownList ID="ddlProducto_dc" placeholder="Producto" class="drop" runat="server"></asp:DropDownList>
                    </div>
                    <div class="col">
                        <label for="inpCantidadProductoComprado"><i class="fas fa-box-open d-inline mx-2"></i></label>
                        <input id="inpCantidadProductoComprado" placeholder="Cantidad" class="drop" runat="server" type="text"/>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col text-center mt-3">
                        <label for="inpPrecioCompraUnidad"><i class="far fa-money-bill-alt d-inline mr-2"></i></label>
                        <input id="inpPrecioCompraUnidad" placeholder="Precio compra unidad" class="drop" runat="server" type="text"/>
                    </div>
                    
                </div>
                
                
                
                <div class="row">
                    <div class="col text-center mt-3">
                        <asp:Button ID="btnAgregarProducto" CssClass="btn btn-small btn-primary" CommandName="Agregar" runat="server" Text="Agregar" OnClick="btnAgregarProducto_OnClick" />
                    </div>
                </div>

            </div>

       </div>


       <h5 class="mt-3 d-block titulo">Detalle Compra</h5>

        
        <div class="round-border mt-3">

        <asp:GridView ID="GridView1" CssClass="table table-sm  table-striped text-center" runat="server" AutoGenerateColumns="False" DataKeyNames="idDetalleCompra" OnRowCommand="GridView1_OnRowCommand">
            <Columns>
                <asp:BoundField DataField="idDetalleCompra" HeaderText="ID" />
                <asp:BoundField DataField="nombreProducto" HeaderText="Producto" />
                <asp:BoundField DataField="cantidadProductoComprado" HeaderText="Cantidad" />
                <asp:BoundField DataField="precioCompraUnidad" HeaderText="Precio Compra Unidad" />
                

                <asp:TemplateField HeaderText="Editar" SortExpression="">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEditar" runat="server" CommandName="editar" CommandArgument='<%#Eval("idDetalleCompra") %>'><i class="fas fa-pencil-alt"></i></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Eliminar" SortExpression="">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEliminar" runat="server" CommandName="eliminar" CommandArgument='<%#Eval("idDetalleCompra") %>'><i class="fas fa-trash-alt"></i></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        </div>
    
        <div class="text-center mt-2">       
            <button class="btn btn-small btn-primary mb-3">Generar Factura</button>
        </div>

    </div>

    <div id="fondoModal"></div>

    <!--Inicia Modal Crear-->
    <asp:Panel ID="modalCrear" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 60%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Crear Compra</label>
                <a id="" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio text-center">
                
                
                <div class="row">
                    <div class="col text-right mt-3">
                        <label for="inpIdCompra_c"><i class="fas fa-box-open d-inline mr-2"></i></label>
                        <input id="inpIdCompra_c" class="drop" placeholder="ID" runat="server" type="text" disabled="disabled"/>
                    </div>
                    <div class="col mt-3">
                        <label for="ddlProveedor_c"><i class="far fa-user d-inline mx-2"></i></label>
                        <asp:DropDownList ID="ddlProveedor_c" CssClass="drop" runat="server"></asp:DropDownList>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col text-right mt-3">
                        <label for="ddlUsuario_c"><i class="far fa-user d-inline mr-2"></i></label>
                        <asp:DropDownList ID="ddlUsuario_c" CssClass="drop" runat="server"></asp:DropDownList>
                    </div>
                    <div class="col mt-3">
                        <label for="inpFechaCompra_c"><i class="far fa-calendar-alt d-inline mx-2"></i></label>
                        <input id="inpFechaCompra_c" class="drop" runat="server" type="date"/>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col text-center mt-3">
                        <label for="inpHoraCompra_c"><i class="far fa-user d-inline mx-2"></i></label>
                        <input id="inpHoraCompra_c" class="drop" runat="server" type="time" />
                    </div>
                </div>


            </div>
            <div class="modal-footer-mio text-center mt-3">
                <asp:Button ID="btnCrear" CssClass="mod btn" CommandName="Crear" runat="server" Text="Crear" OnClick="btnCrear_OnClick" />
                <button type="button" class="cerrar mod btn">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Crear-->
    

    <!--Inicia Modal Editar-->
    <asp:Panel ID="modalEditar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 65%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Editar Proveedor</label>
                <a id="" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio text-center">
                
                
                <div class="row">
                    <div class="col text-right mt-3">
                        <label for="inpIdDetalleCompra_e" class="col-form-label"><i class="fas fa-box-open d-inline mr-2"></i></label>
                        <input type="text" class="form-control drop" id="inpIdDetalleCompra_e" runat="server" />
                    </div>
                    <div class="col mt-3">
                        <label for="ddlProducto_e" class="col-form-label"><i class="fas fa-box-open d-inline mx-2"></i></label>
                        <asp:DropDownList ID="ddlProducto_e" CssClass="drop" runat="server"></asp:DropDownList>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col text-right mt-3">
                        <label for="inpCantidadProductoComprado_e" class="col-form-label"><i class="fas fa-box-open d-inline mr-2"></i></label>
                        <input type="text" class="form-control drop" placeholder="Cantidad" id="inpCantidadProductoComprado_e" runat="server" />
                    </div>
                    <div class="col mt-3">
                        <label for="inpPrecioCompraUnidad_e" class="col-form-label"><i class="far fa-money-bill-alt d-inline mx-2"></i></label>
                        <input type="text" class="form-control drop" placeholder="Precio compra unidad" id="inpPrecioCompraUnidad_e" runat="server" />
                    </div>
                </div>
                
                


            </div>

            <div class="modal-footer-mio text-center mt-3">
                <asp:Button ID="btnActualizar" CssClass="mod btn" CommandName="" runat="server" Text="Actualizar" OnClick="btnActualizar_OnClick" />
                <button type="button" class="cerrar mod btn">Cancelar</button>
            </div>
        </div>
    </asp:Panel>
    <!--Termina Modal Editar-->


    <!--Inicia Modal Eliminar-->
    <asp:Panel ID="modalEliminar" runat="server" BackColor="White" Style="z-index: 111; background-color: White; position: fixed; top: 2vw; left: 50%; width: auto; height: auto; -webkit-transform: translate(-50%,2vw); -moz-transform: translate(-50%,2vw); -ms-transform: translate(-50%,2vw); -o-transform: translate(-50%,2vw); transform: translate(-50%,2vw); width: 50%; border-radius: 1em; padding: 1em; display: none">
        <div class="modal-contenedor">
            <div class="modal-header-mio text-center">
                <label>Eliminar Proveedor</label>
                <a id="" style="float: right; text-decoration: none" class="cerrar">X</a>
            </div>
            <div class="modal-body-mio text-center">
                <div>
                    <label for="lblIdDetalleCompraEliminar" class="col-form-label">Está a punto de eliminar la compra con el identificador:</label>
                    <asp:Label ID="lblIdDetalleCompraEliminar" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <div class="modal-footer-mio text-center">
                <asp:Button ID="btnEliminar" CssClass="mod btn" CommandName="" runat="server" Text="Eliminar" OnClick="btnEliminar_OnClick" />
                <button type="button" class="cerrar mod btn">Cancelar</button>
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
            border-color: rgb(119, 100, 228);
            font-size: 0.7rem;
            width: 12rem;
            color: white;
            border-radius: 4px;
        }

        /*dropdown*/

        .btn-opc, .btn-opc:hover {
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

        .mod, .mod:hover {
            background-color: rgb(119, 100, 228);
            width: 15rem;
            color: white;
            border-radius: 4px;
            border: 1px solid rgb(119, 100, 228);
        }

        .drop {
       
           border-radius: 5px;
           width: 18rem;
           height: 2.4rem!important; 
           border: 0.5px solid #ced4da;
           color: #495057;
           display: inline;
       }

        .success {
        
            border-color: #2ecc71;
        
        }

        .fail {
            border-color: #e74c3c; 
        }

        .title-fix {
            line-height: 28px;
        }


    </style>

    <script type="text/javascript" language="javascript">

        $(".table").attr({
            border: "0",
            cellpadding: "0",
            cellspacing: "0"
        });

        function mostrarDetalles() {
            $('#fondoModal').show();

        }
        function esconderDetalles() {
            $('#fondoModal').hide();
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

            $('#<%=modalEliminar.ClientID %>').hide();
            $('#<%=modalEditar.ClientID %>').hide();
            $('#<%=modalCrear.ClientID%>').hide();
        });

        //verificacion

        var bForm = $("#btnCrear");
        var bFormE = $("#btnAgregarProducto")
        var bEditC = $("#btnActualizar");


        var crearCompra = [undefined, $("#ddlProveedor_c"), $("#ddlUsuario_c"), $("#inpFechaCompra_c"), $("#inpHoraCompra_c")]


        var agregarPro = [$("#ddlProducto_dc"), $("#inpCantidadProductoComprado"), $("#inpPrecioCompraUnidad")]

        var updaPro = [$("#inpIdDetalleCompra_e"), $("#ddlProducto_e"), $("#inpCantidadProductoComprado_e"), $("#inpPrecioCompraUnidad_e")]

        bForm.on("click", function (event) {

            checkInputs(crearCompra);

            if (crearCompra[1].hasClass("fail") || crearCompra[2].hasClass("fail") || crearCompra[3].hasClass("fail") || crearCompra[4].hasClass("fail")) {

                event.preventDefault();

            }

        });


        bFormE.on("click", function (event) {

            checkInputs(agregarPro);

            if (agregarPro[0].hasClass("fail") || agregarPro[1].hasClass("fail") || agregarPro[2].hasClass("fail")) {

                event.preventDefault();

            }

        });

        bEditC.on("click", function (event) {

            checkInputs(updaPro);

            if (updaPro[0].hasClass("fail") || updaPro[1].hasClass("fail") || updaPro[2].hasClass("fail") || updaPro[3].hasClass("fail")) {

                event.preventDefault();

            }

        });


        function checkInputs(lista) {


            var dato1 = lista[0];
            var dato2 = lista[1];
            var dato3 = lista[2];
            var dato4 = lista[3];
            var dato5 = lista[4];





            //verificacion primer nombre
            if (typeof dato1 != 'undefined') {
                if (dato1.val().trim() === '') {
                    setErrorFor(dato1, "campo obligatorio");
                }
                else {
                    setSuccessFor(dato1);
                }
            }

            //verificacion segundo nombre

            if (dato2.attr("placeholder") == "Cantidad" || dato2.attr("placeholder") == "Precio compra unidad") {

                if (isMoney(dato2.val().trim())) {

                    setSuccessFor(dato2);

                }

                else {
                    setErrorFor(dato2, "dato invalido");
                }

            }

            else if (dato2.val().trim() === '') {
                setErrorFor(dato2, "campo obligatorio");
            }
            else {
                setSuccessFor(dato2);
            }

            //verificacion primer apellido

            if (dato3.attr("placeholder") == "Cantidad" || dato3.attr("placeholder") == "Precio compra unidad") {

                if (isMoney(dato3.val().trim())) {

                    setSuccessFor(dato3);

                }

                else {
                    setErrorFor(dato3, "dato invalido");
                }

            }

            else if (dato3.val().trim() === '') {
                setErrorFor(dato3, "campo obligatorio");
            }
            else {
                setSuccessFor(dato3);
            }

            // segundo apellido
            if (typeof dato4 != 'undefined') {

                if (dato4.attr("placeholder") == "Cantidad" || dato4.attr("placeholder") == "Precio compra unidad") {

                    if (isMoney(dato4.val().trim())) {

                        setSuccessFor(dato4);

                    }

                    else {
                        setErrorFor(dato4, "dato invalido");
                    }

                }

                else if (dato4.val().trim() === '') {
                    setErrorFor(dato4, "campo obligatorio");
                }
                else {
                    setSuccessFor(dato4);
                }
            }

            // segundo apellido

            if (typeof dato5 != 'undefined') {

                if (dato5.val().trim() === '') {
                    setErrorFor(dato5, "campo obligatorio");
                }
                else {
                    setSuccessFor(dato5);
                }
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
