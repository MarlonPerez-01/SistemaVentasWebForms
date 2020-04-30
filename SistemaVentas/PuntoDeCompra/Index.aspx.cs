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

namespace SistemaVentas.PuntoDeCompra
{
    public partial class Index : System.Web.UI.Page
    {
       

        string cadenaConexion = ConfigurationManager.ConnectionStrings["conexion"].ToString();
        protected void Page_Load(object sender, EventArgs e)
        { 
            ddlProveedorBind();
        }


        protected void ddlProveedorBind()
        {
            var dataTable = new Crud().Seleccionar("ProveedorList");
            ddlProveedor.DataSource = dataTable;
            ddlProveedor.DataTextField = "nombreProveedor";
            ddlProveedor.DataValueField = "idProveedor";
            ddlProveedor.DataBind();
        }

    
        protected void btnFactura_OnClick(object sender, EventArgs e)
        {            //TODO: Validar que los campos esten llenos

            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("InsertarCliente", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;



                    sqlCommand.Parameters.AddWithValue("@primerNombreCliente", ddlProveedor.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@segundoNombreCliente", ddlUsuario.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@primerApellidoCliente", inpFechaCompra.Value);
                    sqlCommand.Parameters.AddWithValue("@primerApellidoCliente", inpHoraCompra.Value);

                    int iNewRowIdentity = Convert.ToInt32(sqlCommand.ExecuteScalar());

                    inpIdCompra.Value = iNewRowIdentity.ToString();
                    //filasAfectadas = sqlCommand.ExecuteNonQuery();
                }

                /*
                if (filasAfectadas != 0)
                {
                    //TODO: Mensaje exitoso
                }
                else
                {
                    //TODO: Mensaje de fracaso
                }*/
            }
        }
    }
}