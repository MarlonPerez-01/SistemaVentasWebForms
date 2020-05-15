using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SistemaVentas.Helpers;

namespace SistemaVentas.Balance
{
    public partial class Index : System.Web.UI.Page
    {
        string cadenaConexion = ConfigurationManager.ConnectionStrings["conexion"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            { 
                ddlProductoBind_dc();
            }
        }
        
        protected void ddlProductoBind_dc()
        {
                var dataTable = new Crud().Seleccionar("ProductoList");
                ddlProducto_dc.DataSource = dataTable;
                ddlProducto_dc.DataTextField = "nombreProducto";
                ddlProducto_dc.DataValueField = "idProducto";
                ddlProducto_dc.DataBind();
            
        }

        protected void btnAgregarProducto_OnClick(object sender, EventArgs e)
        {

            //TODO: Validar que los campos esten llenos
            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("InsertarDetalleCompra", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    //sqlCommand.Parameters.AddWithValue("@idCompra", inpIdCompra.Value);
                    sqlCommand.Parameters.AddWithValue("@idCompra", 54);
                    sqlCommand.Parameters.AddWithValue("@idProducto", ddlProducto_dc.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@cantidadProductoComprado", inpCantidadProductoComprado.Value);
                    sqlCommand.Parameters.AddWithValue("@precioCompraUnidad", inpPrecioCompraUnidad.Value);
                    sqlCommand.Parameters.AddWithValue("@precioVentaUnidad", inpPrecioVentaUnidad.Value);
                    sqlCommand.Parameters.AddWithValue("@observaciones", inpObservaciones.Value);

                    sqlCommand.ExecuteNonQuery();
                }
            }
        }
    }
}