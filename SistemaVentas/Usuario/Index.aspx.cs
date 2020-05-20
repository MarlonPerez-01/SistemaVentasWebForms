using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using SistemaVentas.Helpers;
namespace SistemaVentas.Usuario
{
    public partial class Index : System.Web.UI.Page
    {

        //CONEXION
        string cadenaConexion = ConfigurationManager.ConnectionStrings["conexion"].ToString();
        private int filasAfectadas { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            //1 = admin || 2 = basico
            string idTipoUsuario = Session["idTipoUsuario"] as string;
            if (idTipoUsuario == null || idTipoUsuario == "2")
            {
                Response.Redirect("/Default.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    Bind();
                }
            }
        }

        protected void Bind()
        {
            var dataTable = new Crud().Seleccionar("SeleccionarUsuarios");
            GridView1.DataSource = dataTable;
            GridView1.DataBind();
            var cantidad = dataTable.Rows.Count;
            cantidadUsuarios.InnerText = cantidad.ToString();
        }

        protected void GridView1_OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            Bind();
        }



        protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "detalles")
            {
                LinkButton btnDetalles = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnDetalles.NamingContainer;

                int idUsuario = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    SqlCommand sqlCommand = new SqlCommand("SeleccionarUsuarioById", sqlConnection);
                    SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idUsuario", idUsuario);
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter.Fill(dataTable);

                    lblIdUsuario.Text = dataTable.Rows[0][0].ToString();
                    lblNombreUsuario.Text = dataTable.Rows[0][1].ToString();
                    lblNombreEmpleado.Text = dataTable.Rows[0][2].ToString();
                    lblTipoUsuario.Text = dataTable.Rows[0][3].ToString();
                }

                ModalDetalles(true);
            }
            else if (e.CommandName == "editar")
            {

                LinkButton btnEditar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEditar.NamingContainer;

                int idUsuario = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

                //Llenando los dropdownlists
                ddlTipoUsuarioBind_e();

                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    SqlCommand sqlCommand = new SqlCommand("SeleccionarUsuarioByIdEditar", sqlConnection);
                    SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idUsuario", idUsuario);
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter.Fill(dataTable);

                    inpIdUsuario_e.Value = dataTable.Rows[0][0].ToString();
                    inpEmpleado_e.Value = dataTable.Rows[0][1].ToString();

                    string tipoUsuarioDB = dataTable.Rows[0][2].ToString();
                    ddlTipoUsuario_e.SelectedIndex = ddlTipoUsuario_e.Items.IndexOf(ddlTipoUsuario_e.Items.FindByValue(tipoUsuarioDB));

                    inpNombreUsuario_e.Value = dataTable.Rows[0][3].ToString();
                    inpContraseniaUsuario_e.Value = dataTable.Rows[0][4].ToString();
                }
                ModalEditar(true);
            }
            else if (e.CommandName == "eliminar")
            {
                LinkButton btnEliminar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEliminar.NamingContainer;

                int idUsuario = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);
                lblIdUsuarioEliminar.Text = HttpUtility.HtmlDecode(gvrow.Cells[0].Text);
                ModalEliminar(true);
            }
        }

        //DropDownlist para el modal editar

        protected void ddlTipoUsuarioBind_e()
        {
            var dataTable = new Crud().Seleccionar("TipoUsuarioList");
            ddlTipoUsuario_e.DataSource = dataTable;
            ddlTipoUsuario_e.DataTextField = "nombreTipoUsuario";
            ddlTipoUsuario_e.DataValueField = "idTipoUsuario";
            ddlTipoUsuario_e.DataBind();
        }

        //DropDownlist para el modal crear
        protected void ddlEmpleadoBind_c()
        {
            var dataTable = new Crud().Seleccionar("EmpleadoList");
            ddlEmpleado_c.DataSource = dataTable;
            ddlEmpleado_c.DataTextField = "nombreEmpleado";
            ddlEmpleado_c.DataValueField = "idEmpleado";
            ddlEmpleado_c.DataBind();
        }
        protected void ddlTipoUsuarioBind_c()
        {
            var dataTable = new Crud().Seleccionar("TipoUsuarioList");
            ddlTipoUsuario_c.DataSource = dataTable;
            ddlTipoUsuario_c.DataTextField = "nombreTipoUsuario";
            ddlTipoUsuario_c.DataValueField = "idTipoUsuario";
            ddlTipoUsuario_c.DataBind();
        }


        protected void btnCrearUsuario_Click(object sender, EventArgs e)
        {
            ddlEmpleadoBind_c();
            ddlTipoUsuarioBind_c();
            //Limpiando el formulario 
            inpNombreUsuario_c.Value = String.Empty;
            inpContraseniaUsuario_c.Value = String.Empty;

            ModalCrear(true);
        }

        protected void btnCrear_OnClick(object sender, EventArgs e)
        {
            //TODO: Validar que los campos esten llenos

            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("InsertarUsuario", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idEmpleado", ddlEmpleado_c.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@idTipoUsuario", ddlTipoUsuario_c.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@nombreUsuario", inpNombreUsuario_c.Value);
                    sqlCommand.Parameters.AddWithValue("@contraseniaUsuario", inpContraseniaUsuario_c.Value);

                    Response.Redirect(Request.Url.ToString(), false);
                    filasAfectadas = sqlCommand.ExecuteNonQuery();
                }

                if (filasAfectadas != 0)
                {
                    //TODO: Mensaje exitoso
                }
                else
                {
                    //TODO: Mensaje de fracaso
                }

                Bind();
            }

            ModalCrear(false);
        }

        protected void btnActualizar_OnClick(object sender, EventArgs e)
        {
            //TODO: Validar que los campos esten llenos

            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("ActualizarUsuario", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idUsuario", inpIdUsuario_e.Value);
                    sqlCommand.Parameters.AddWithValue("@idTipoUsuario", ddlTipoUsuario_e.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@nombreUsuario", inpNombreUsuario_e.Value);
                    sqlCommand.Parameters.AddWithValue("@contraseniaUsuario", inpContraseniaUsuario_e.Value);

                    filasAfectadas = sqlCommand.ExecuteNonQuery();
                }

                if (filasAfectadas != 0)
                {
                    //TODO: Mensaje exitoso
                }
                else
                {
                    //TODO: Mensaje de fracaso
                }

                Bind();
            }
            ModalEditar(false);
        }

        protected void btnEliminar_OnClick(object sender, EventArgs e)
        {
            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("EliminarUsuario", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idUsuario", Convert.ToInt32(lblIdUsuarioEliminar.Text));
                    int filasAfectadas = sqlCommand.ExecuteNonQuery();
                }
                Bind();

                if (filasAfectadas != 0)
                {
                    //TODO: Mensaje exitoso
                }
                else
                {
                    //TODO: Mensaje de fracaso
                }
            }
        }



        void ModalDetalles(bool isDisplay)
        {
            StringBuilder builder = new StringBuilder();
            if (isDisplay)
            {
                builder.Append("<script language=JavaScript> mostrarDetalles(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "mostrarDetalles", builder.ToString());
            }
            else
            {
                builder.Append("<script language=JavaScript> esconderDetalles(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "esconderDetalles", builder.ToString());
            }

        }
        void ModalEditar(bool isDisplay)
        {
            StringBuilder builder = new StringBuilder();
            if (isDisplay)
            {
                builder.Append("<script language=JavaScript> mostrarEditar(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "mostrarEditar", builder.ToString());
            }
            else
            {
                builder.Append("<script language=JavaScript> esconderEditar(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "esconderEditar", builder.ToString());
            }
        }

        void ModalEliminar(bool isDisplay)
        {
            StringBuilder builder = new StringBuilder();
            if (isDisplay)
            {
                builder.Append("<script language=JavaScript> mostrarEliminar(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "mostrarEliminar", builder.ToString());
            }
            else
            {
                builder.Append("<script language=JavaScript> esconderEliminar(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "esconderEliminar", builder.ToString());
            }
        }

        void ModalCrear(bool isDisplay)
        {
            StringBuilder builder = new StringBuilder();
            if (isDisplay)
            {
                builder.Append("<script language=JavaScript> mostrarCrear(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "mostrarCrear", builder.ToString());
            }
            else
            {
                builder.Append("<script language=JavaScript> esconderCrear(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "esconderCrear", builder.ToString());
            }
        }

        protected void cerrarTodo(object sender, EventArgs e)
        {
            ModalCrear(false);
            ModalDetalles(false);
            ModalEliminar(false);
            ModalEditar(false);
        }


        protected void btnBuscar_OnClick(object sender, EventArgs e)
        {
            //TODO: programar el filtro
        }
    }
}