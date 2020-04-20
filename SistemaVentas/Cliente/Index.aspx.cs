using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using SistemaVentas.Helpers;

namespace SistemaVentas.Cliente
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var dataTable = new Crud().ObtenerDataTable("SeleccionarClientes");
            gvClientes.DataSource = dataTable;
            gvClientes.DataBind();
        }
    }
}