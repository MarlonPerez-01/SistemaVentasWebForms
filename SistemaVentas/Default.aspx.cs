using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaVentas
{
    public partial class Default : System.Web.UI.Page
    {
        //CONEXION
        string cadenaConexion = ConfigurationManager.ConnectionStrings["conexion"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            alerta.Visible = false;

            //Este codigo es para redireccionar sin loguearme, eliminar en la entrega
            Session["nombreUsuario"] = "Pedro1234";
            Session["idTipoUsuario"] = "1234";
            Response.Redirect("/Venta/Index.aspx");
        }

        protected void btnIngresar_OnClick(object sender, EventArgs e)
        {
            try
            {
                SqlConnection connection = new SqlConnection(cadenaConexion);
                connection.Open();
                SqlCommand cmd = new SqlCommand("ValidarUsuario", connection);
                cmd.Parameters.Add("@nombreUsuario", SqlDbType.VarChar).Value = txtNombreUsuario.Text;
                cmd.Parameters.Add("@contraseniaUsuario", SqlDbType.VarChar).Value = txtContraseniaUsuario.Text;
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                DataTable table = new DataTable();
                table.Load(reader);
                connection.Close();
                if (table.Rows[0][0].ToString() == "1")
                {
                    Session["nombreUsuario"] = table.Rows[0][1].ToString();
                    Session["idTipoUsuario"] = table.Rows[0][3].ToString();

                    Response.Redirect("/Dashboard/Index.aspx");
                }
                else
                {
                    alerta.Visible = true;
                }
            }
            catch (Exception)
            {
            }
        }
    }
}