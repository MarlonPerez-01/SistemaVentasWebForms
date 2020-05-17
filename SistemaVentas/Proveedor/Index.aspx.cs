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

namespace SistemaVentas.Proveedor
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
            var dataTable = new Crud().Seleccionar("SeleccionarProveedores");
            GridView1.DataSource = dataTable;
            GridView1.DataBind();
            var cantidad = dataTable.Rows.Count;
            txtBuscar.Text = cantidad.ToString();
        }


        protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "detalles")
            {
                LinkButton btnDetalles = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnDetalles.NamingContainer;

                int idProveedor = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    SqlCommand sqlCommand = new SqlCommand("SeleccionarProveedorById", sqlConnection);
                    SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idProveedor", idProveedor);
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter.Fill(dataTable);

                    lblIdProveedor.Text = dataTable.Rows[0][0].ToString();
                    lblPrimerNombreProveedor.Text = dataTable.Rows[0][1].ToString();
                    lblSegundoNombreProveedor.Text = dataTable.Rows[0][2].ToString();
                    lblPrimerApellidoProveedor.Text = dataTable.Rows[0][3].ToString();
                    lblSegundoApellidoProveedor.Text = dataTable.Rows[0][4].ToString();
                    lblTelefonoProveedor.Text = dataTable.Rows[0][5].ToString();
                    lblEmpresaProveedor.Text = dataTable.Rows[0][6].ToString();
                }
                ModalDetalles(true);
            }
            else if (e.CommandName == "editar")
            {
                LinkButton btnEditar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEditar.NamingContainer;

                int idProveedor = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    SqlCommand sqlCommand = new SqlCommand("SeleccionarProveedorById", sqlConnection);
                    SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idProveedor", idProveedor);
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter.Fill(dataTable);

                    inpIdProveedor_e.Value = dataTable.Rows[0][0].ToString();
                    inpPrimerNombreProveedor_e.Value = dataTable.Rows[0][1].ToString();
                    inpSegundoNombreProveedor_e.Value = dataTable.Rows[0][2].ToString();
                    inpPrimerApellidoProveedor_e.Value = dataTable.Rows[0][3].ToString();
                    inpSegundoApellidoProveedor_e.Value = dataTable.Rows[0][4].ToString();
                    inpTelefonoProveedor_e.Value = dataTable.Rows[0][5].ToString();
                    inpEmpresaProveedor_e.Value = dataTable.Rows[0][6].ToString();
                }
                ModalEditar(true);
            }
            else if (e.CommandName == "eliminar")
            {
                LinkButton btnEliminar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEliminar.NamingContainer;

                int idProveedor = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);
                lblIdProveedorEliminar.Text = HttpUtility.HtmlDecode(gvrow.Cells[0].Text);
                ModalEliminar(true);
            }
        }



        protected void GridView1_OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            Bind();
        }


        protected void btnCrear_OnClick(object sender, EventArgs e)
        {
            //TODO: Validar que los campos esten llenos

            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("InsertarProveedor", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@primerNombreProveedor", inpPrimerNombreProveedor_c.Value);
                    sqlCommand.Parameters.AddWithValue("@segundoNombreProveedor", inpSegundoNombreProveedor_c.Value);
                    sqlCommand.Parameters.AddWithValue("@primerApellidoProveedor", inpPrimerApellidoProveedor_c.Value);
                    sqlCommand.Parameters.AddWithValue("@segundoApellidoProveedor", inpSegundoApellidoProveedor_c.Value);
                    sqlCommand.Parameters.AddWithValue("@empresaProveedor", inpEmpresaProveedor_c.Value);
                    sqlCommand.Parameters.AddWithValue("@telefonoProveedor", inpTelefonoProveedor_c.Value);

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

                var dataTable = new Crud().Seleccionar("SeleccionarProveedores");
                GridView1.DataSource = dataTable;
                GridView1.DataBind();
            }
            ModalCrear(false);
        }

        protected void btnActualizar_OnClick(object sender, EventArgs e)
        {
            //TODO: Validar que los campos esten llenos

            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("ActualizarProveedor", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idProveedor", inpIdProveedor_e.Value);
                    sqlCommand.Parameters.AddWithValue("@primerNombreProveedor", inpPrimerNombreProveedor_e.Value);
                    sqlCommand.Parameters.AddWithValue("@segundoNombreProveedor", inpSegundoNombreProveedor_e.Value);
                    sqlCommand.Parameters.AddWithValue("@primerApellidoProveedor", inpPrimerApellidoProveedor_e.Value);
                    sqlCommand.Parameters.AddWithValue("@segundoApellidoProveedor", inpSegundoApellidoProveedor_e.Value);
                    sqlCommand.Parameters.AddWithValue("@telefonoProveedor", inpTelefonoProveedor_e.Value);
                    sqlCommand.Parameters.AddWithValue("@empresaProveedor", inpEmpresaProveedor_e.Value);

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

                var dataTable = new Crud().Seleccionar("SeleccionarProveedores");
                GridView1.DataSource = dataTable;
                GridView1.DataBind();
            }

            ModalEditar(false);
        }

        protected void btnEliminar_OnClick(object sender, EventArgs e)
        {
            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("EliminarProveedor", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idProveedor", Convert.ToInt32(lblIdProveedorEliminar.Text));
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
        }

        protected void btnCrearProveedor_OnClick(object sender, EventArgs e)
        {
            //Limpiando el formulario 
            inpPrimerNombreProveedor_c.Value = String.Empty;
            inpSegundoNombreProveedor_c.Value = String.Empty;
            inpPrimerApellidoProveedor_c.Value = String.Empty;
            inpSegundoApellidoProveedor_c.Value = String.Empty;
            inpTelefonoProveedor_c.Value = String.Empty;
            inpEmpresaProveedor_c.Value = String.Empty;

            ModalCrear(true);
        }

        protected void btnCerrar_OnClick(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }
    }
}