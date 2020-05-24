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

namespace SistemaVentas.Cliente
{
    public partial class Index : System.Web.UI.Page
    {

        //CONEXION
        string cadenaConexion = ConfigurationManager.ConnectionStrings["conexion"].ToString();
        private int filasAfectadas { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            //Validando el tipo de usuario para permitir o restrigir el acceso 1 = admin || 2 = basico

            string idTipoUsuario = Session["idTipoUsuario"] as string;
            if (idTipoUsuario == null)
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

        //Obteniendo el listado de Cargos para el GridView principal
        protected void Bind()
        {
            try
            {
                var dataTable = new Crud().Seleccionar("SeleccionarClientes");
                GridView1.DataSource = dataTable;
                GridView1.DataBind();
                var cantidad = dataTable.Rows.Count;
                cantidadClientes.InnerText = cantidad.ToString();

            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }

        //Obteniendo el listado de Cargos para el GridView principal en el cambio de paginacion
        protected void GridView1_OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                GridView1.PageIndex = e.NewPageIndex;
                Bind();
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception);
                throw;
            }
        }

        //Acciones para boton detalles, editar y eliminar que se encuentran en el GridView Principal
        protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "detalles")
            {
                LinkButton btnDetalles = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnDetalles.NamingContainer;

                int idCliente = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

                try
                {
                    using (var sqlConnection = new SqlConnection(cadenaConexion))
                    {
                        SqlCommand sqlCommand = new SqlCommand("SeleccionarClientesById", sqlConnection);
                        SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@idCliente", idCliente);
                        DataTable dataTable = new DataTable();
                        SqlDataAdapter.Fill(dataTable);

                        lblIdCliente.Text = dataTable.Rows[0][0].ToString();
                        lblPrimerNombreCliente.Text = dataTable.Rows[0][1].ToString();
                        lblSegundoNombreCliente.Text = dataTable.Rows[0][2].ToString();
                        lblPrimerApellidoCliente.Text = dataTable.Rows[0][3].ToString();
                        lblSegundoApellidoCliente.Text = dataTable.Rows[0][4].ToString();
                        lblDuiCliente.Text = dataTable.Rows[0][5].ToString();
                        lblNitCliente.Text = dataTable.Rows[0][6].ToString();
                        lblTelefonoCliente.Text = dataTable.Rows[0][7].ToString();
                    }

                    ModalDetalles(true);

                }
                catch (Exception exception)
                {
                    Console.WriteLine(exception);
                    throw;
                }
            }
            else if (e.CommandName == "editar")
            {
                LinkButton btnEditar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEditar.NamingContainer;

                int idCliente = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

                try
                {
                    using (var sqlConnection = new SqlConnection(cadenaConexion))
                    {
                        SqlCommand sqlCommand = new SqlCommand("SeleccionarClientesById", sqlConnection);
                        SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@idCliente", idCliente);
                        DataTable dataTable = new DataTable();
                        SqlDataAdapter.Fill(dataTable);

                        inpIdCliente_e.Value = dataTable.Rows[0][0].ToString();
                        inpPrimerNombreCliente_e.Value = dataTable.Rows[0][1].ToString();
                        inpSegundoNombreCliente_e.Value = dataTable.Rows[0][2].ToString();
                        inpPrimerApellidoCliente_e.Value = dataTable.Rows[0][3].ToString();
                        inpSegundoApellidoCliente_e.Value = dataTable.Rows[0][4].ToString();
                        inpDuiCliente_e.Value = dataTable.Rows[0][5].ToString();
                        inpNitCliente_e.Value = dataTable.Rows[0][6].ToString();
                        inpTelefonoCliente_e.Value = dataTable.Rows[0][7].ToString();
                    }
                    ModalEditar(true);

                }
                catch (Exception exception)
                {
                    Console.WriteLine(exception);
                    throw;
                }
            }
            else if (e.CommandName == "eliminar")
            {
                LinkButton btnEliminar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEliminar.NamingContainer;

                int idCliente = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);
                lblIdClienteEliminar.Text = HttpUtility.HtmlDecode(gvrow.Cells[0].Text);
                ModalEliminar(true);
            }
        }

        //Mostrando Modal Crear cuando el boton CrearCliente sea presionado
        protected void btnCrearCliente_OnClick(object sender, EventArgs e)
        {
            ModalCrear(true);
        }

        //Insertar el nuevo cliente al presionar el boton "Crear" del modal CrearCliente
        protected void btnCrear_OnClick(object sender, EventArgs e)
        {
            //TODO: Validar que los campos esten llenos

            try
            {
                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    using (var sqlCommand = new SqlCommand("InsertarCliente", sqlConnection))
                    {
                        sqlConnection.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@primerNombreCliente", inpPrimerNombreCliente_c.Value);
                        sqlCommand.Parameters.AddWithValue("@segundoNombreCliente", inpSegundoNombreCliente_c.Value);
                        sqlCommand.Parameters.AddWithValue("@primerApellidoCliente", inpPrimerApellidoCliente_c.Value);
                        sqlCommand.Parameters.AddWithValue("@segundoApellidoCliente", inpSegundoApellidoCliente_c.Value);
                        sqlCommand.Parameters.AddWithValue("@duiCliente", inpDuiCliente_c.Value);
                        sqlCommand.Parameters.AddWithValue("@nitCliente", inpNitCliente_c.Value);
                        sqlCommand.Parameters.AddWithValue("@telefonoCliente", inpTelefonoCliente_c.Value);

                        Response.Redirect(Request.Url.ToString(), false);
                        filasAfectadas = sqlCommand.ExecuteNonQuery();
                    }

                    if (filasAfectadas != 0)
                    {
                        //TODO: Mensaje exitoso

                        //Limpiando el modal despues de la insercion
                        inpPrimerNombreCliente_e.Value = String.Empty;
                        inpSegundoNombreCliente_e.Value = String.Empty;
                        inpPrimerApellidoCliente_e.Value = String.Empty;
                        inpSegundoApellidoCliente_e.Value = String.Empty;
                        inpDuiCliente_e.Value = String.Empty;
                        inpNitCliente_e.Value = String.Empty;
                        inpTelefonoCliente_e.Value = String.Empty;
                    }
                    else
                    {
                        //TODO: Mensaje de fracaso
                    }
                    Bind();
                }
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception);
                throw;
            }
            ModalCrear(false);
        }

        //Actualizando Cliente
        protected void btnActualizar_OnClick(object sender, EventArgs e)
        {
            //TODO: Validar que los campos esten llenos
            try
            {
                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    using (var sqlCommand = new SqlCommand("ActualizarCliente", sqlConnection))
                    {
                        sqlConnection.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@idCliente", inpIdCliente_e.Value);
                        sqlCommand.Parameters.AddWithValue("@primerNombreCliente", inpPrimerNombreCliente_e.Value);
                        sqlCommand.Parameters.AddWithValue("@segundoNombreCliente", inpSegundoNombreCliente_e.Value);
                        sqlCommand.Parameters.AddWithValue("@primerApellidoCliente", inpPrimerApellidoCliente_e.Value);
                        sqlCommand.Parameters.AddWithValue("@segundoApellidoCliente", inpSegundoApellidoCliente_e.Value);
                        sqlCommand.Parameters.AddWithValue("@duiCliente", inpDuiCliente_e.Value);
                        sqlCommand.Parameters.AddWithValue("@nitCliente", inpNitCliente_e.Value);
                        sqlCommand.Parameters.AddWithValue("@telefonoCliente", inpTelefonoCliente_e.Value);

                        filasAfectadas = sqlCommand.ExecuteNonQuery();
                    }

                    Bind();
                }
                ModalEditar(false);
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception);
                throw;
            }
        }

        //Eliminando la fila con el id indicado
        protected void btnEliminar_OnClick(object sender, EventArgs e)
        {
            try
            {
                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    using (var sqlCommand = new SqlCommand("EliminarCliente", sqlConnection))
                    {
                        sqlConnection.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@idCliente", Convert.ToInt32(lblIdClienteEliminar.Text));
                        int filasAfectadas = sqlCommand.ExecuteNonQuery();
                    }
                    Bind();
                }
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception);
                throw;
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
        }

    }
}