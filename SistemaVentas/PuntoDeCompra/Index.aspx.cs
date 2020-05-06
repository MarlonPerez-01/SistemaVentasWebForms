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
            ddlUsuarioBind();
        }


        protected void ddlProveedorBind()
        {
            var dataTable = new Crud().Seleccionar("ProveedorList");
            ddlProveedor.DataSource = dataTable;
            ddlProveedor.DataTextField = "nombreProveedor";
            ddlProveedor.DataValueField = "idProveedor";
            ddlProveedor.DataBind();
        }

        protected void ddlUsuarioBind()
        {
            var dataTable = new Crud().Seleccionar("UsuarioList");
            ddlUsuario.DataSource = dataTable;
            ddlUsuario.DataTextField = "nombreUsuario";
            ddlUsuario.DataValueField = "idUsuario";
            ddlUsuario.DataBind();
        }


        protected void btnFactura_OnClick(object sender, EventArgs e)
        {            
            //TODO: Validar que los campos esten llenos

            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("InsertarCompra", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;

                    sqlCommand.Parameters.AddWithValue("@idProveedor", ddlProveedor.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@idUsuario", ddlUsuario.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@fechaCompra", inpFechaCompra.Value);
                    sqlCommand.Parameters.AddWithValue("@horaCompra", inpHoraCompra.Value);

                    /*SqlParameter outPutVal = new SqlParameter("@idFactura", SqlDbType.Int);
                    outPutVal.Direction = ParameterDirection.InputOutput;

                    if (outPutVal.Value != DBNull.Value) new_MEM_BASIC_ID = Convert.ToInt32(outPutVal.Value);
                    return new_MEM_BASIC_ID;*/

                    //filasAfectadas = sqlCommand.ExecuteNonQuery();
                    string id = sqlCommand.ExecuteScalar().ToString();
                    inpIdCompra.Value = id;


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