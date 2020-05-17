using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Ajax.Utilities;
using SistemaVentas.Helpers;

namespace SistemaVentas.Empleado
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
            var dataTable = new Crud().Seleccionar("SeleccionarEmpleados");
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

                int idEmpleado = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    sqlConnection.Open();
                    SqlCommand sqlCommand = new SqlCommand("SeleccionarEmpleadoById", sqlConnection);
                    SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idEmpleado", idEmpleado);
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter.Fill(dataTable);

                    lblIdEmpleado.Text = dataTable.Rows[0][0].ToString();
                    lblNombreEmpleado.Text = dataTable.Rows[0][1].ToString();
                    lblDuiEmpleado.Text = dataTable.Rows[0][2].ToString();
                    lblNitEmpleado.Text = dataTable.Rows[0][3].ToString();

                    byte[] img = (byte[])dataTable.Rows[0][4];
                    if (img != null && img.Length > 0)
                    {
                        imgFotografiaEmpleado.ImageUrl = "data:image;base64," + Convert.ToBase64String(img);
                    }

                    lblSexoEmpleado.Text = dataTable.Rows[0][5].ToString();
                    lblFechaNacimientoEmpleado.Text = dataTable.Rows[0][6].ToString();
                    lblFechaContrato.Text = dataTable.Rows[0][7].ToString();
                    lblTelefonoEmpleado.Text = dataTable.Rows[0][8].ToString();
                    lblCorreoEmpleado.Text = dataTable.Rows[0][9].ToString();
                    lblDireccionEmpleado.Text = dataTable.Rows[0][10].ToString();
                    lblNombreCargo.Text = dataTable.Rows[0][11].ToString();
                }

                ModalDetalles(true);
            }

            else if (e.CommandName == "editar")
            {
                ddlCargoBind_e();
                LinkButton btnEditar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEditar.NamingContainer;

                int idEmpleado = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    SqlCommand sqlCommand = new SqlCommand("SeleccionarEmpleadoById_e", sqlConnection);
                    SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idEmpleado", idEmpleado);
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter.Fill(dataTable);

                    inpIdEmpleado_e.Value = dataTable.Rows[0][0].ToString();

                    string cargoDB = dataTable.Rows[0][1].ToString();
                    ddlCargo_e.SelectedIndex = ddlCargo_e.Items.IndexOf(ddlCargo_e.Items.FindByValue(cargoDB));

                    inpPrimerNombreEmpleado_e.Value = dataTable.Rows[0][2].ToString();
                    inpSegundoNombreEmpleado_e.Value = dataTable.Rows[0][3].ToString();
                    inpPrimerApellidoEmpleado_e.Value = dataTable.Rows[0][4].ToString();
                    inpSegundoApellidoEmpleado_e.Value = dataTable.Rows[0][5].ToString();
                    inpDuiEmpleado_e.Value = dataTable.Rows[0][6].ToString();
                    inpNitEmpleado_e.Value = dataTable.Rows[0][7].ToString();


                    byte[] img = (byte[])dataTable.Rows[0][8];
                    if (img != null && img.Length > 0)
                    {
                        imgFotografiaEmpleado_e.Src = "data:image;base64," + Convert.ToBase64String(img);
                    }


                    DateTime dateTime1_e = (DateTime)dataTable.Rows[0][9];
                    inpFechaNacimientoEmpleado_e.Value = dateTime1_e.ToShortDateString();

                    DateTime dateTime2_e = (DateTime)dataTable.Rows[0][10];
                    inpFechaContrato_e.Value = dateTime2_e.ToShortDateString();

                    inpTelefonoEmpleado_e.Value = dataTable.Rows[0][11].ToString();
                    inpCorreoEmpleado_e.Value = dataTable.Rows[0][12].ToString();

                    string sexoDB = dataTable.Rows[0][13].ToString();
                    ddlSexo_e.SelectedIndex = ddlSexo_e.Items.IndexOf(ddlSexo_e.Items.FindByValue(sexoDB));

                    string departamentoDB = dataTable.Rows[0][14].ToString();
                    ddlDepartamento_e.SelectedIndex = ddlDepartamento_e.Items.IndexOf(ddlDepartamento_e.Items.FindByValue(departamentoDB));

                    inpMunicipioEmpleado_e.Value = dataTable.Rows[0][15].ToString();
                    txtDetallesDireccionEmpleado_e.Value = dataTable.Rows[0][16].ToString();

                    ModalEditar(true);
                }
            }

            else if (e.CommandName == "eliminar")
            {
                LinkButton btnEliminar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEliminar.NamingContainer;

                int idCliente = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);
                lblIdEmpleadoEliminar.Text = HttpUtility.HtmlDecode(gvrow.Cells[0].Text);
                ModalEliminar(true);
            }
        }

        //DropDownlists
        protected void ddlCargoBind_c()
        {
            var dataTable = new Crud().Seleccionar("CargoList");
            ddlCargo_c.DataSource = dataTable;
            ddlCargo_c.DataTextField = "nombreCargo";
            ddlCargo_c.DataValueField = "idCargo";
            ddlCargo_c.DataBind();
        }
        protected void ddlCargoBind_e()
        {
            var dataTable = new Crud().Seleccionar("CargoList");
            ddlCargo_e.DataSource = dataTable;
            ddlCargo_e.DataTextField = "nombreCargo";
            ddlCargo_e.DataValueField = "idCargo";
            ddlCargo_e.DataBind();
        }

        protected void btnCrear_OnClick(object sender, EventArgs e)
        {
            //TODO: Validar que los campos esten llenos


            //Obtener datos de la imagen
            int tamanio = FileUpload1_c.PostedFile.ContentLength;
            byte[] ImagenOriginal = new byte[tamanio];
            FileUpload1_c.PostedFile.InputStream.Read(ImagenOriginal, 0, tamanio);
            Bitmap ImagenOriginalBinaria = new Bitmap(FileUpload1_c.PostedFile.InputStream);

            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("InsertarEmpleado", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idCargo", ddlCargo_c.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@primerNombreEmpleado", inpPrimerNombreEmpleado_c.Value);
                    sqlCommand.Parameters.AddWithValue("@segundoNombreEmpleado", inpSegundoNombreEmpleado_c.Value);
                    sqlCommand.Parameters.AddWithValue("@primerApellidoEmpleado", inpPrimerApellidoEmpleado_c.Value);
                    sqlCommand.Parameters.AddWithValue("@segundoApellidoEmpleado", inpSegundoApellidoEmpleado_c.Value);
                    sqlCommand.Parameters.AddWithValue("@duiEmpleado", inpDuiEmpleado_c.Value);
                    sqlCommand.Parameters.AddWithValue("@nitEmpleado", inpNitEmpleado_c.Value);
                    sqlCommand.Parameters.AddWithValue("@fotografiaEmpleado", ImagenOriginal);
                    //sqlCommand.Parameters.Add("@fotografiaEmpleado", SqlDbType.Image).Value = ImagenOriginal;
                    sqlCommand.Parameters.AddWithValue("@fechaNacimientoEmpleado", inpFechaNacimientoEmpleado_c.Value);
                    sqlCommand.Parameters.AddWithValue("@fechaContrato", inpFechaContratoEmpleado_c.Value);
                    sqlCommand.Parameters.AddWithValue("@telefonoEmpleado", inpTelefonoEmpleado_c.Value);
                    sqlCommand.Parameters.AddWithValue("@correoEmpleado", inpCorreoEmpleado_c.Value);
                    sqlCommand.Parameters.AddWithValue("@sexoEmpleado", ddlSexo_c.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@departamentoEmpleado", ddlDepartamento_c.Text);
                    sqlCommand.Parameters.AddWithValue("@municipioEmpleado", inpMunicipioEmpleado_c.Value);
                    sqlCommand.Parameters.AddWithValue("@detallesDireccionEmpleado", txtDetallesDireccionEmpleado_c.Value);

                    sqlCommand.ExecuteNonQuery();
                }

                if (filasAfectadas != 0)
                {
                    //TODO: Mensaje exitoso
                }
                else
                {
                    //TODO: Mensaje de fracaso
                }

                var dataTable = new Crud().Seleccionar("SeleccionarEmpleados");
                GridView1.DataSource = dataTable;
                GridView1.DataBind();
            }
            Bind();
            ModalCrear(false);
        }




        protected void btnBuscar_OnClick(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }



        protected void btnActualizar_OnClick(object sender, EventArgs e)
        {
            //TODO: Validar que los campos esten llenos

            //Obtener datos de la imagen
            int tamanio = FileUpload1_e.PostedFile.ContentLength;
            byte[] ImagenOriginal = new byte[tamanio];
            FileUpload1_e.PostedFile.InputStream.Read(ImagenOriginal, 0, tamanio);
            Bitmap ImagenOriginalBinaria = new Bitmap(FileUpload1_e.PostedFile.InputStream);

            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("ActualizarEmpleado", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idEmpleado", inpIdEmpleado_e.Value);
                    sqlCommand.Parameters.AddWithValue("@idCargo", ddlCargo_e.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@primerNombreEmpleado", inpPrimerNombreEmpleado_e.Value);
                    sqlCommand.Parameters.AddWithValue("@segundoNombreEmpleado", inpSegundoNombreEmpleado_e.Value);
                    sqlCommand.Parameters.AddWithValue("@primerApellidoEmpleado", inpPrimerApellidoEmpleado_e.Value);
                    sqlCommand.Parameters.AddWithValue("@segundoApellidoEmpleado", inpSegundoApellidoEmpleado_e.Value);
                    sqlCommand.Parameters.AddWithValue("@duiEmpleado", inpDuiEmpleado_e.Value);
                    sqlCommand.Parameters.AddWithValue("@nitEmpleado", inpNitEmpleado_e.Value);
                    sqlCommand.Parameters.AddWithValue("@fotografiaEmpleado", ImagenOriginal);
                    sqlCommand.Parameters.AddWithValue("@fechaNacimientoEmpleado", inpFechaNacimientoEmpleado_e.Value);
                    sqlCommand.Parameters.AddWithValue("@fechaContrato", inpFechaContrato_e.Value);
                    sqlCommand.Parameters.AddWithValue("@telefonoEmpleado", inpTelefonoEmpleado_e.Value);
                    sqlCommand.Parameters.AddWithValue("@correoEmpleado", inpCorreoEmpleado_e.Value);
                    sqlCommand.Parameters.AddWithValue("@sexoEmpleado", ddlSexo_e.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@departamentoEmpleado", ddlDepartamento_e.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@municipioEmpleado", inpMunicipioEmpleado_e.Value);
                    sqlCommand.Parameters.AddWithValue("@detallesDireccionEmpleado", txtDetallesDireccionEmpleado_e.Value);
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
                using (var sqlCommand = new SqlCommand("EliminarEmpleado", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idEmpleado", Convert.ToInt32(lblIdEmpleadoEliminar.Text));
                    int filasAfectadas = sqlCommand.ExecuteNonQuery();
                }

                if (filasAfectadas != 0)
                {
                    Bind();
                    //TODO: Mensaje exitoso
                }
                else
                {
                    //TODO: Mensaje de fracaso
                }
            }
        }

        protected void btnCrearEmpleado_OnClick(object sender, EventArgs e)
        {
            ddlCargoBind_c();
            //Limpiando el formulario 
            inpPrimerNombreEmpleado_c.Value = String.Empty;
            inpSegundoNombreEmpleado_c.Value = String.Empty;
            inpPrimerApellidoEmpleado_c.Value = String.Empty;
            inpSegundoApellidoEmpleado_c.Value = String.Empty;
            inpDuiEmpleado_c.Value = String.Empty;
            inpNitEmpleado_c.Value = String.Empty;
            inpFechaNacimientoEmpleado_c.Value = String.Empty;
            inpFechaContratoEmpleado_c.Value = String.Empty;
            inpTelefonoEmpleado_c.Value = String.Empty;
            inpMunicipioEmpleado_c.Value = String.Empty;
            txtDetallesDireccionEmpleado_c.Value = String.Empty;

            ModalCrear(true);
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


    }
}