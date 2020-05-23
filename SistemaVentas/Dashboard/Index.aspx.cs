using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using SistemaVentas.Helpers;


namespace SistemaVentas.Dashboard
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var crud = new Crud();
            DataTable dataTable = crud.Seleccionar("dashboardSP");
            lblCantidadVentaDinero.InnerText = dataTable.Rows[0][0].ToString();
            lblVentaMayor.InnerText = dataTable.Rows[0][1].ToString();
            lblCantidadVentas.InnerText = dataTable.Rows[0][2].ToString();
            lblProductoMasVendido.InnerText = dataTable.Rows[0][3].ToString();
            lblCantidadEmpleado.InnerText = dataTable.Rows[0][4].ToString();
            lblCantidadCategorias.InnerText = dataTable.Rows[0][5].ToString();
        }
    }
}