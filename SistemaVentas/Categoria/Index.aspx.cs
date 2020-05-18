using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SistemaVentas.Helpers;

namespace SistemaVentas.Categoria
{
    public partial class Categoria : System.Web.UI.Page
    {
        //CONEXION
        string cadenaConexion = ConfigurationManager.ConnectionStrings["conexion"].ToString();
        private int filasAfectadas { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            //Validando el tipo de usuario para permitir o restrigir el acceso 1 = admin || 2 = basico
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

        //Obteniendo el listado de categorias para el GridView principal
        protected void Bind()
        {
            var dataTable = new Crud().Seleccionar("SeleccionarCategorias");
            GridView1.DataSource = dataTable;
            GridView1.DataBind();
            var cantidad = dataTable.Rows.Count;
            cantidadCategorias.InnerText = cantidad.ToString();
            
        }

        //Obteniendo el listado de cateorias para el GridView principal en el cambio de paginacion
        protected void GridView1_OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            Bind();
        }

        //Acciones para boton detalles, editar y eliminar que se encuentran en el GridView Principal
        protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "detalles")
            {
                LinkButton btnDetalles = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnDetalles.NamingContainer;

                int idCategoria = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    SqlCommand sqlCommand = new SqlCommand("SeleccionarCategoriaById", sqlConnection);
                    SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idCategoria", idCategoria);
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter.Fill(dataTable);

                    lblIdCategoria.Text = dataTable.Rows[0][0].ToString();
                    lblNombreCategoria.Text = dataTable.Rows[0][1].ToString();
                }

                ModalDetalles(true);
            }
            else if (e.CommandName == "editar")
            {
                LinkButton btnEditar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEditar.NamingContainer;

                int idCategoria = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    SqlCommand sqlCommand = new SqlCommand("SeleccionarCategoriaById", sqlConnection);
                    SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idCategoria", idCategoria);
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter.Fill(dataTable);

                    inpIdCategoria_e.Value = dataTable.Rows[0][0].ToString();
                    inpNombreCategoria_e.Value = dataTable.Rows[0][1].ToString();

                }
                ModalEditar(true);
            }
            else if (e.CommandName == "eliminar")
            {
                LinkButton btnEliminar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEliminar.NamingContainer;

                int idCategoria = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);
                lblIdCategoriaEliminar.Text = HttpUtility.HtmlDecode(gvrow.Cells[0].Text);
                ModalEliminar(true);
            }
        }

        //Insertando el valor del input correspondiente al presionar el boton crear
        protected void btnCrear_OnClick(object sender, EventArgs e)
        {
            //TODO: Validar que los campos esten llenos

            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("InsertarCategoria", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@nombreCategoria", inpNombreCategoria_c.Value);
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

                //Limpiando el campo despues de haber usado su valor
                inpNombreCategoria_c.Value = String.Empty;
                Bind();
            }
        }

        //Actualizando los datos del modal Actualizar
        protected void btnActualizar_OnClick(object sender, EventArgs e)
        {
            //TODO: Validar que los campos esten llenos

            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("ActualizarCategoria", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idCategoria", inpIdCategoria_e.Value);
                    sqlCommand.Parameters.AddWithValue("@nombreCategoria", inpNombreCategoria_e.Value);

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

        //Eliminando la fila con el id indicado
        protected void btnEliminar_OnClick(object sender, EventArgs e)
        {
            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("EliminarCategoria", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idCategoria", Convert.ToInt32(lblIdCategoriaEliminar.Text));
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

        //Metodos para Mostrar y Ocultar los Modals
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


        //TODO: programar el filtro
        protected void btnBuscar_OnClick(object sender, EventArgs e)
        {
            /*
            try
            {
                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter("select * from cliente where primerNombreCliente like '" + txtBuscar.Text + "%'", cadenaConexion);
                var dataTable = new DataTable();
                sqlDataAdapter.Fill(dataTable);
                this.GridView1.DataSource = dataTable;
                txtBuscar.Text = dataTable.Rows[0][3].ToString();
            }
            catch (Exception exception)
            {
                throw exception;
            }*/
        }

    }
}