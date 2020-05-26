<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SistemaVentas.PuntoDeVenta.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

  
    <h1 >Factura</h1><br />

   

    <div class="container">

        <!--  Nombres  -->
        <div class="elemento1"><i class="fas fa-user"></i>
             <asp:TextBox ID="txtNombres" runat="server" placeholder="Nombres" CssClass="texto">
             </asp:TextBox>
        </div>

        <!--  Apellidos  -->
         <div class="elemento2"><i class="fas fa-user"></i>
            <asp:TextBox ID="txtApellidos" runat="server" placeholder="Apellidos" CssClass="texto">
            </asp:TextBox>
         </div>


        <!--  DUI  -->
         <div class="elemento1"><i class="fas fa-user"></i>
            <asp:TextBox ID="txtDui" runat="server" placeholder="DUI" CssClass="texto">
            </asp:TextBox>
         </div>

        <!--  NIT  -->
         <div class="elemento2"><i class="fas fa-user"></i>
            <asp:TextBox ID="txtNit" runat="server" placeholder="NIT" CssClass="texto">
            </asp:TextBox>
         </div>
        
        
        <!-- Numero de telefono   -->
        <div class="elemento1">
        <i class="fas fa-user"></i>
        <asp:TextBox ID="txtNumerTelefono" AutoCompleteType="Cellular"  runat="server" CssClass="texto" placeholder="Número de teléfono" ></asp:TextBox>
        </div>
                
        <!--  Boton crear nuevo  -->
        <div class="elemento2">
        <asp:Button ID="btncrear" runat="server" Text="Crear Nuevo" CssClass="btnCrear" OnClick="btncrear_Click" /><asp:Label ID="crearcliente" runat="server" Text="" ForeColor="Red"></asp:Label><asp:Label ID="crearexito" runat="server" Text="" ForeColor="Green"></asp:Label>
        </div>

    </div>

    <br />
    <!--  Esta es la seccion de los tres dropsownlist  -->
   <div class="container">
             <div class="bp">
                <p><strong>Buscar producto:</strong></p>
             </div>           
             <div class="ddl">

                     <div class="buscar1"> <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                     <asp:DropDownList ID="ddlbuscar" runat="server" CssClass="drooop" AutoPostBack="true" OnSelectedIndexChanged="CategoriaSeleccionada"></asp:DropDownList></div>
                    </div>
                     <div class="buscar1"><asp:Label ID="Label2" runat="server" Text=""></asp:Label>
                         <asp:DropDownList ID="ddlbuscar2" runat="server" CssClass="drooop" AutoPostBack="True" OnSelectedIndexChanged="MarcaSelecionada"></asp:DropDownList>
                     </div>
             
                     <div class="buscar1"><asp:Label ID="Label3" runat="server" Text=""></asp:Label>
                     <asp:DropDownList ID="ddlbuscar3" runat="server" CssClass="drooop"  AutoPostBack="true" OnSelectedIndexChanged="ProductoSeleccionado"></asp:DropDownList></div>
                    
                    <div class="buscar1">
                        <asp:TextBox ID="cantidad" runat="server" placeholder="Numero de productos" CssClass="texto"></asp:TextBox>
                    </div>
       <br />
                     <div class="btn"><asp:Button ID="BtnAgregar" runat="server" Text="Agregar Producto" CssClass="btnAgregar" OnClick="BtnAgregar_Click" /></div>
       <asp:Label ID="msg" runat="server" Text=""></asp:Label>
            </div>
       
  <br />




    <!--Esto es la tabla los th son los encabezados de la tabla --> 

                    <div class="container">
                        <asp:GridView ID="gvproductos" runat="server" AutoGenerateColumns="false" DataKeyNames="id" OnRowDeleting="gvproductos_RowDeleting"
                             CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="container">
                            <AlternatingRowStyle BackColor="White" />
                            
                            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                            <SortedAscendingCellStyle BackColor="#FDF5AC" />
                            <SortedAscendingHeaderStyle BackColor="#4D0000" />
                            <SortedDescendingCellStyle BackColor="#FCF6C0" />
                            <SortedDescendingHeaderStyle BackColor="#820000" />

                            <Columns>
                                
                                <asp:TemplateField HeaderText="ID">
                                    <ItemTemplate>
                                        <asp:Label Text='<%# Eval("id") %>' runat="server" />
                                    </ItemTemplate>

                                    <EditItemTemplate>
                                        <asp:TextBox ID="tbid" Text='<%# Eval("id") %>'  runat="server" />
                                    </EditItemTemplate>

                                    <FooterTemplate>
                                        <asp:TextBox ID="tbidfooter" runat="server" />
                                    </FooterTemplate>

                                </asp:TemplateField>

                                

                                <asp:TemplateField HeaderText="Producto">
                                    <ItemTemplate>
                                        <asp:Label Text='<%# Eval("producto") %>' runat="server" />
                                    </ItemTemplate>

                                    <EditItemTemplate>
                                        <asp:TextBox ID="tbproducto" Text='<%# Eval("producto") %>'  runat="server" />
                                    </EditItemTemplate>

                                    <FooterTemplate>
                                        <asp:TextBox ID="tbproductofooter" runat="server" />
                                    </FooterTemplate>

                                </asp:TemplateField>

                                
                                <asp:TemplateField HeaderText="Cantidad">
                                    <ItemTemplate>
                                        <asp:Label Text='<%# Eval("cantidad") %>' runat="server" />
                                    </ItemTemplate>

                                    <EditItemTemplate>
                                        <asp:TextBox ID="tbcantidad" Text='<%# Eval("cantidad") %>'  runat="server" />
                                    </EditItemTemplate>

                                    <FooterTemplate>
                                        <asp:TextBox ID="tbcantidadfooter" runat="server" />
                                    </FooterTemplate>

                                </asp:TemplateField>

                                
                                <asp:TemplateField HeaderText="Precio(c/u)">
                                    <ItemTemplate>
                                        <asp:Label Text='<%# Eval("precio") %>' runat="server" />
                                    </ItemTemplate>

                                    <EditItemTemplate>
                                        <asp:TextBox ID="tbprecio" Text='<%# Eval("precio") %>'  runat="server" />
                                    </EditItemTemplate>

                                    <FooterTemplate>
                                        <asp:TextBox ID="tbpreciofooter" runat="server" />
                                    </FooterTemplate>

                                </asp:TemplateField>

                                
                                <asp:TemplateField HeaderText="Descuento(c/u)">
                                    <ItemTemplate>
                                        <asp:Label Text='<%# Eval("descuent") %>' runat="server" />
                                    </ItemTemplate>

                                    <EditItemTemplate>
                                        <asp:TextBox ID="tbdescuento" Text='<%# Eval("descuent") %>'  runat="server" />
                                    </EditItemTemplate>

                                    <FooterTemplate>
                                        <asp:TextBox ID="tbdescuentofooter" runat="server" />
                                    </FooterTemplate>

                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Descuento(total)">
                                    <ItemTemplate>
                                        <asp:Label Text='<%# Eval("descuento") %>' runat="server" />
                                    </ItemTemplate>

                                    <EditItemTemplate>
                                        <asp:TextBox ID="tbdescuento" Text='<%# Eval("descuento") %>'  runat="server" />
                                    </EditItemTemplate>

                                    <FooterTemplate>
                                        <asp:TextBox ID="tbdescuentotfooter" runat="server" />
                                    </FooterTemplate>

                                </asp:TemplateField>

                                <asp:CommandField ButtonType="Link" ShowDeleteButton="true" />

                               
                            </Columns>
                        </asp:GridView>

                        <br />
                        <asp:Label ID="lblexito" Text="" runat="server" ForeColor="Green"/>
                        <br />
                        <asp:Label ID="lblerroe" Text="" runat="server" ForeColor="Red"/>
                    </div>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <!--Esta es otra tabla lo ultimo --> 
                <div class="container">
                     <table class="table table-striped">
                        <thead>
                          <tr>
                             <th>Efectivo</th>
                             <th> <asp:TextBox ID="txtEfectivo"  runat="server" CssClass="text"> </asp:TextBox></th>
                             <th>SubTotal</th>
                             <th> <asp:TextBox ID="txtSubtotal"  runat="server" ReadOnly="true" CssClass="text"> </asp:TextBox></th>                                            
                           </tr>
                        </thead>
                      <tr>
                         <th>Cambio</th>
                         <th> <asp:TextBox ID="txtCmbio"  runat="server" ReadOnly="true" CssClass="text"> </asp:TextBox></th>              
                         <th>Ahorro</th>
                         <th> <asp:TextBox ID="txtAhorro"  runat="server" ReadOnly="true" CssClass="text"> </asp:TextBox></th>            
                      </tr>
                     <tr>
                         <th><asp:Button ID="Button1" runat="server" Text="GenerarVenta"  CssClass="btnCrear" OnClick="Button1_Click" /><asp:Label ID="exitoventa" runat="server" Text="" ForeColor="Green"></asp:Label></th>
                         <!--Esto th va en blanco --> 
                         <th></th>                
                         <th>Total General</th>
                         <th> <asp:TextBox ID="txtGeneral"  runat="server" ReadOnly="true" CssClass="text"> </asp:TextBox></th>              
                     </tr>
                
        </table>
    </div>

    <!--Esto es todo amigos --> 
     





<!----Esta es la parte de los estilos------------------------------------------------------------------------------------>

    <!-- Central conteiner -->
    <style type="text/css">
        .container{
            justify-content:center;
        }

        .ddl{
            justify-content:flex-start;
        }

        .text{
            border: none;
                        border-bottom: 1px solid #ff0000;
                        outline: none;
                        height: 25px;
                        width: 250px;
                        font-size: 12px;
                        
                        opacity: 1; 
        }
    </style>
    <!--Estos elemenos son de la parte de arriba donde estan los 5 texbox y el boton crea nuevo -->
                        <style type="text/css">
                            .elemento1{
                                margin-left:100px;
                                float:left;
                                padding-right:50px;  
                                 }
                        </style>
                            
                        <style type="text/css">
                            .elemento2{
                                float: left;
                                margin-right: 200px; 
                                }
                        </style>

  
    <!-- Esto es el estilo de los tres dropdowlist   -->
         <style type="text/css">
                 .marco{
                  margin-left:120px;
                 float:left;
                  }
          </style>
    
    <!-- Esto es el estilo de todos los textbox de form   -->
            <style type="text/css">
                 .texto {
                        border: none;
                        border-bottom: 1px solid #ff0000;
                        outline: none;
                        height: 25px;
                        width: 300px;
                        font-size: 12px;
                        outline: none;
                        margin-bottom: 20px;
                        opacity: 1;           
                         }
            </style>


    <!-- Esto es el estilo de la ubicacion de los labels en en la parte de Buscar Producto (con los tres dropdowlist)   -->
                           <style type="text/css">
                               .buscar1 {
                                    float:left;
                                    border: none;
                                    border-bottom: 1px solid #ff0000;
                                    outline: none;
                                    height: 25px;
                                    width: 225px;
                                    font-size: 14px;
                                    outline: none;
                                    margin-bottom: 20px;
                                    margin-right:10px;
                                    }
                           </style>
                            

    <!-- Esto es el estilo de todos los dropdownlist   -->
                    <style type="text/css">
                            .drop{
                                border: none;
                                border-bottom: 1px solid #ff0000;
                                outline: none;
                                height: 25px;
                                width: 250px;
                                font-size: 14px;
                                outline: none;
                                margin-bottom: 20px;
                                margin-right:10px;
                                 }
                     </style>
 
 
<!--Este es el estilo del boton crear nuevo en la parte de arriba y el de generar factura --> 

            <style type="text/css">
                .btnCrear{
                     height:20px;
                     display: inline-block;
                     background:#ff0000;
                     border-radius:10px;
                     border:none;
                     font-size:12px;
                     color:white;
                     }
             </style>

    <style type="text/css">
        .buscarcliente{
            height:20px;
            width:350px;
            background:#ff0000;
            border-radius:10px;
            border:none;
            font-size:12px;
            color:white;
            } 
        
    </style>

    <!--Este es el estilo de los 3 dropdowlist en la parte de buscar producto  --> 
    <!--De momento no esta en uso, el estilo de estos dropdownlist es el que esta abajo--> 
             <style type="text/css">
                .dropBuscar{
                    padding-left:105px;
                    border: none;
                    border-bottom: 1px solid #ff0000;
                    outline: none;
                    height: 25px;           
                    font-size: 12px;
                    outline: none;
                    margin-bottom: 20px;
                    }

                
            </style>

         <!-- Esto es el estilo de todos los dropdownlist   -->
                    <style type="text/css">
                            .drooop{
                                border: none;
                                
                                outline: none;
                                height: auto;
                                width: auto;
                                font-size: 14px;
                                outline: none;
                                margin-bottom: 20px;
                                margin-right:10px;
                                 }
                     </style>

     <!--Este es el estilo del boton agregar en la seleccion de producto --> 

            <style type="text/css">
                .btnAgregar{
                     height:20px;
                     
                     background:#ff0000;
                     border-radius:10px;
                     border:none;
                     font-size:12px;
                     color:white;
                     text-align:center;
                     
                     
                     }

            .bt{
                
                text-align:left;
            }
             </style>
</asp:Content>

