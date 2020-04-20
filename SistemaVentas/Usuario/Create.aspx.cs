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

namespace SistemaVentas.Usuario
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
            obtenerEmpleadoList();
            obtenerTipoUsuarioList();
        }

        public void obtenerEmpleadoList()
        {
            var dataTable = new Crud().ObtenerDataTable("EmpleadoList");
            ddlIdEmpleado.DataSource = dataTable;
            ddlIdEmpleado.DataTextField = "nombreEmpleado";
            ddlIdEmpleado.DataValueField = "idEmpleado";
            ddlIdEmpleado.DataBind();
        }


        public void obtenerTipoUsuarioList()
        {
            var dataTable = new Crud().ObtenerDataTable("TipoUsuarioList");
            ddlIdTipoUsuario.DataSource = dataTable;
            ddlIdTipoUsuario.DataTextField = "nombreTipoUsuario";
            ddlIdTipoUsuario.DataValueField = "idTipoUsuario";
            ddlIdTipoUsuario.DataBind();
        }


        protected void btnCrearUsuario_OnClick(object sender, EventArgs e)
        {
            try
            {
                connection();
                var sqlCommand = new SqlCommand("InsertarUsuario", sqlConnection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                sqlCommand.Parameters.AddWithValue("@idEmpleado", ddlIdEmpleado.SelectedValue);
                sqlCommand.Parameters.AddWithValue("@idTipoUsuario", ddlIdTipoUsuario.SelectedValue);
                sqlCommand.Parameters.AddWithValue("@nombreUsuario", inpNombreUsuario.Value);
                sqlCommand.Parameters.AddWithValue("@contraseniaUsuario", inpContraseniaUsuario.Value);

                sqlConnection.Open();
                int i = sqlCommand.ExecuteNonQuery();
                sqlConnection.Close();

                lblMensaje.Text = i != 0
                    ? "Datos Insertados Correctamente"
                    : "Ha ocurrido un error";
                sqlConnection.Close();
            }

            catch (Exception exception)
            {
                lblMensaje.Text = exception.Message;
            }
        }

        protected void btnRegresar_OnClick(object sender, EventArgs e)
        {
            Response.Redirect("Index.aspx");
        }

    }
}