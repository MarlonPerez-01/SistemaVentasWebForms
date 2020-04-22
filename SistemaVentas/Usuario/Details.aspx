<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="SistemaVentas.Usuario.Details" ClientIDMode="Static"%>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:GridView ID="GridViewData" runat="server" AutoGenerateColumns="False" DataKeyNames="CustomerID" OnRowCommand="GridViewData_RowCommand">
        <Columns>
            <asp:BoundField DataField="CustomerID" HeaderText="Customer ID" />
            <asp:BoundField DataField="CompanyName" HeaderText="Company Name" />
            <asp:BoundField DataField="ContactName" HeaderText="Contact Name" />
            <asp:BoundField DataField="Address" HeaderText="Address" />
            <asp:BoundField DataField="City" HeaderText="City" />
            <asp:TemplateField HeaderText="" SortExpression="">
                <ItemTemplate>
                    <asp:LinkButton ID="btnDetalles" runat="server" CommandName="ShowPopup" CommandArgument='<%#Eval("CustomerID") %>' >Detalles</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="" SortExpression="">
                <ItemTemplate>
                    <asp:LinkButton ID="btnEditar" runat="server" CommandName="ShowPopup" CommandArgument='<%#Eval("CustomerID") %>'>Editar</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="" SortExpression="">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButtonEdit" runat="server" CommandName="ShowPopup" CommandArgument='<%#Eval("CustomerID") %>'>Eliminar</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <asp:Label ID="lblresult" runat="server" Text=""></asp:Label>
    
    <style type="text/css">
        #mask {
            position: fixed;
            left: 0px;
            top: 0px;
            z-index: 4;
            opacity: 0.4;
            -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=40)"; /* first!*/
            filter: alpha(opacity=40); /* second!*/
            background-color: gray;
            display: none;
            width: 100%;
            height: 100%;
        }
    </style>
    
    <script src="Scripts/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        function ShowPopup() {
            $('#mask').show();
            $('#<%=pnlpopup.ClientID %>').show();
        }
        function HidePopup() {
            $('#mask').hide();
            $('#<%=pnlpopup.ClientID %>').hide();
        }
        $(".btnClose").live('click', function () {
            HidePopup();
        });

    </script>
    <div id="mask">
    </div>
    
    <style>

    </style>
    

    <asp:Panel ID="pnlpopup" runat="server" BackColor="White" Height="175px" Width="300px" Style="z-index: 111; background-color: White; position: absolute; left: 35%; top: 12%; border: outset 2px gray; padding: 5px; display: none">
        <div class="modal-mio">
            <div class="modal-header-mio">
                <label>
                    Customer Details
                </label>
                <a id="closebtn" style="float: right; text-decoration: none" class="btnClose" href="#">X</a>
                    <asp:Label ID="LabelValidate" runat="server" />
            </div>
            <div class="modal-body-mio">
                <div>
                    CustomerID:
                    <asp:Label ID="lblID" runat="server"></asp:Label>
                </div>
                <div>
                    Contact Name:
                    <asp:Label ID="lblContactName" runat="server"></asp:Label>
                </div>
                <div>
                    Address:
                    <asp:TextBox ID="txtAddress" runat="server" />
                </div>
                <div>
                    City:
                    <asp:TextBox ID="txtCity" runat="server" />
                </div>
            </div>
            <div class="modal-footer-mio">
                <asp:Button ID="btnUpdate" CommandName="Update" runat="server" Text="Update" OnClick="btnUpdate_Click" />
                <asp:Button ID="Button1" CommandName="Update" runat="server" Text="Cancel" OnClick="cerrar" />
            </div>
        </div>
    </asp:Panel>


</asp:Content>
