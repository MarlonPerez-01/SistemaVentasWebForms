using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaVentas.Cliente
{
    public partial class Create : System.Web.UI.Page
    {
        //CONEXION
        private SqlConnection sqlConnection;
        private void connection()
        {
            string constr = ConfigurationManager.ConnectionStrings["conexion"].ToString();
            sqlConnection = new SqlConnection(constr);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnCrearCliente_OnClick(object sender, EventArgs e)
        {
            try
            {
                connection();
                var sqlCommand = new SqlCommand("InsertarCliente", sqlConnection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                sqlCommand.Parameters.AddWithValue("@primerNombreCliente", inpPrimerNombreCliente.Value);
                sqlCommand.Parameters.AddWithValue("@segundoNombreCliente", inpSegundoNombreCliente.Value);
                sqlCommand.Parameters.AddWithValue("@primerApellidoCliente", inpPrimerApellidoCliente.Value);
                sqlCommand.Parameters.AddWithValue("@segundoApellidoCliente", inpSegundoApellidoCliente.Value);
                sqlCommand.Parameters.AddWithValue("@duiCliente", inpDuiCliente.Value);
                sqlCommand.Parameters.AddWithValue("@nitCliente", inpNitCliente.Value);
                sqlCommand.Parameters.AddWithValue("@telefonoCliente", inpTelefonoCliente.Value);

                sqlConnection.Open();
                int i = sqlCommand.ExecuteNonQuery();


                Label1.Text = i != 0 ? "Record Inserted Succesfully into the Database" : "Record NOT Inserted Succesfully into the Database";
                sqlConnection.Close();

                //Limpiando campos cuando se inserta un cliente
                inpPrimerNombreCliente.Value = inpSegundoNombreCliente.Value = inpPrimerApellidoCliente.Value = inpSegundoApellidoCliente.Value = inpDuiCliente.Value = inpNitCliente.Value = inpTelefonoCliente.Value = String.Empty;
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception.Message);
                Label1.Text = "catch";
            }

        }

        protected void btnRegresar_OnClick(object sender, EventArgs e)
        {
            Response.Redirect("Index.aspx");
        }
    }
}