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
            if (!IsPostBack)
            {
                Bind();
            }
        }

        protected void Bind()
        {
            var dataTable = new Crud().Seleccionar("SeleccionarClientes");
            GridView1.DataSource = dataTable;
            GridView1.DataBind();
            var cantidad = dataTable.Rows.Count;
            txtBuscar.Text = cantidad.ToString();
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

                int idCliente = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

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
            else if (e.CommandName == "editar")
            {
                LinkButton btnEditar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEditar.NamingContainer;

                int idCliente = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

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
            else if (e.CommandName == "eliminar")
            {
                LinkButton btnEliminar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEliminar.NamingContainer;

                int idCliente = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);
                lblIdClienteEliminar.Text = HttpUtility.HtmlDecode(gvrow.Cells[0].Text);
                ModalEliminar(true);
            }
        }

        protected void btnCrearCliente_OnClick(object sender, EventArgs e)
        {
            //Limpiando el formulario 
            inpPrimerNombreCliente_c.Value = String.Empty;
            inpSegundoNombreCliente_c.Value = String.Empty;
            inpPrimerApellidoCliente_c.Value = String.Empty;
            inpSegundoApellidoCliente_c.Value = String.Empty;
            inpDuiCliente_c.Value = String.Empty;
            inpNitCliente_c.Value = String.Empty;
            inpTelefonoCliente_c.Value = String.Empty;

            ModalCrear(true);
        }

        protected void btnCrear_OnClick(object sender, EventArgs e)
        {
            //TODO: Validar que los campos esten llenos

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

                var dataTable = new Crud().Seleccionar("SeleccionarClientes");
                GridView1.DataSource = dataTable;
                GridView1.DataBind();
            }

            ModalDetalles(false);
        }

        protected void btnActualizar_OnClick(object sender, EventArgs e)
        {
            //TODO: Validar que los campos esten llenos

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

                if (filasAfectadas != 0)
                {
                    //TODO: Mensaje exitoso
                }
                else
                {
                    //TODO: Mensaje de fracaso
                }

                var dataTable = new Crud().Seleccionar("SeleccionarClientes");
                GridView1.DataSource = dataTable;
                GridView1.DataBind();
            }

            ModalDetalles(false);
        }

        protected void btnEliminar_OnClick(object sender, EventArgs e)
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


        protected void cerrar(object sender, EventArgs e)
        {
            ModalDetalles(false);
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


        protected void btnBuscar_OnClick(object sender, EventArgs e)
        {
            //TODO: programar el filtro
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