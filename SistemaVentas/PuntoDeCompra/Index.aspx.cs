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

namespace SistemaVentas.PuntoDeCompra
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
                ddlProductoBind_dc();
            }
            BindUltimaCompra();
            ModalCrear(false);
            BindDetalleCompra();
        }

        protected void BindUltimaCompra()
        {
            var dataTable = new Crud().Seleccionar("SeleccionarUltimaCompra");
            inpIdCompra.Value = dataTable.Rows[0][0].ToString();
            inpNombreProveedor.Value = dataTable.Rows[0][1].ToString();
            inpNombreEmpleado.Value = dataTable.Rows[0][2].ToString();
            inpFechaCompra.Value = dataTable.Rows[0][3].ToString();
            inpHoraCompra.Value = dataTable.Rows[0][4].ToString();
        }


        protected void BindDetalleCompra()
        {
            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                SqlCommand sqlCommand = new SqlCommand("SeleccionarDetalleCompra", sqlConnection);
                SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.AddWithValue("@idCompra", inpIdCompra.Value);
                DataTable dataTable = new DataTable();
                SqlDataAdapter.Fill(dataTable);
                GridView1.DataSource = dataTable;
                GridView1.DataBind();
            }
        }

        /*DropDownlist Producto*/
        protected void ddlProductoBind_dc()
        {
            var dataTable = new Crud().Seleccionar("ProductoList");
            ddlProducto_dc.DataSource = dataTable;
            ddlProducto_dc.DataTextField = "nombreProducto";
            ddlProducto_dc.DataValueField = "idProducto";
            ddlProducto_dc.DataBind();
        }

        protected void ddlProductoBind_e()
        {
            var dataTable = new Crud().Seleccionar("ProductoList");
            ddlProducto_e.DataSource = dataTable;
            ddlProducto_e.DataTextField = "nombreProducto";
            ddlProducto_e.DataValueField = "idProducto";
            ddlProducto_e.DataBind();
        }



        protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "editar")
            {
                ddlProductoBind_e();

                LinkButton btnEditar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEditar.NamingContainer;

                int idDetalleCompra = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {


                    SqlCommand sqlCommand = new SqlCommand("SeleccionarDetalleCompra_e", sqlConnection);
                    SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idDetalleCompra", idDetalleCompra);
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter.Fill(dataTable);

                    inpIdDetalleCompra_e.Value = dataTable.Rows[0][0].ToString();

                    string productoDB = dataTable.Rows[0][1].ToString();
                    ddlProducto_e.SelectedIndex = ddlProducto_e.Items.IndexOf(ddlProducto_e.Items.FindByValue(productoDB));

                    inpCantidadProductoComprado_e.Value = dataTable.Rows[0][2].ToString();
                    inpPrecioCompraUnidad_e.Value = dataTable.Rows[0][3].ToString();
                    inpPrecioVentaUnidad_e.Value = dataTable.Rows[0][4].ToString();
                    inpObservaciones_e.Value = dataTable.Rows[0][5].ToString();

                    ModalEditar(true);
                }
            }

            else if (e.CommandName == "eliminar")
            {
                LinkButton btnEliminar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEliminar.NamingContainer;

                int idCompra = Convert.ToInt32(inpIdCompra.Value);
                lblIdDetalleCompraEliminar.Text = HttpUtility.HtmlDecode(gvrow.Cells[0].Text);
                ModalEliminar(true);
            }
        }








        /*Modal para llenar la tabla "Compra"*/
        protected void ddlProveedorBind()
        {
            var dataTable = new Crud().Seleccionar("ProveedorList");
            ddlProveedor_c.DataSource = dataTable;
            ddlProveedor_c.DataTextField = "nombreProveedor";
            ddlProveedor_c.DataValueField = "idProveedor";
            ddlProveedor_c.DataBind();
        }

        protected void ddlUsuarioBind()
        {
            var dataTable = new Crud().Seleccionar("UsuarioList");
            ddlUsuario_c.DataSource = dataTable;
            ddlUsuario_c.DataTextField = "nombreUsuario";
            ddlUsuario_c.DataValueField = "idUsuario";
            ddlUsuario_c.DataBind();
        }

        protected void btnCrearCompra_OnClick(object sender, EventArgs e)
        {
            //Limpiando el formulario 
            ddlProveedorBind();
            ddlUsuarioBind();
            ModalCrear(true);
        }

        protected void btnCrear_OnClick(object sender, EventArgs e)
        {
            //TODO: Validar que los campos esten llenos

            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("InsertarCompra", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;

                    sqlCommand.Parameters.AddWithValue("@idProveedor", ddlProveedor_c.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@idUsuario", ddlUsuario_c.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@fechaCompra", inpFechaCompra.Value);
                    sqlCommand.Parameters.AddWithValue("@horaCompra", inpHoraCompra.Value);

                    Response.Redirect(Request.Url.ToString(), false);
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
                BindUltimaCompra();
            }
            ModalCrear(false);
        }

        /*Actualizar detalle compra*/
        protected void btnActualizar_OnClick(object sender, EventArgs e)
        {
            //TODO: Validar que los campos esten llenos

            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("ActualizarDetalleCompra", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idDetalleCompra", Convert.ToInt32(inpIdDetalleCompra_e.Value));
                    sqlCommand.Parameters.AddWithValue("@idProducto", ddlProducto_e.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@cantidadProductoComprado", Convert.ToInt32(inpCantidadProductoComprado_e.Value));
                    sqlCommand.Parameters.AddWithValue("@precioCompraUnidad", Convert.ToInt32(inpPrecioCompraUnidad_e.Value));
                    sqlCommand.Parameters.AddWithValue("@precioVentaUnidad", Convert.ToInt32(inpPrecioVentaUnidad_e.Value));
                    sqlCommand.Parameters.AddWithValue("@observaciones", inpObservaciones_e.Value);

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

            }

            ModalEditar(false);
        }

        /*Eliminar detalle compra*/
        protected void btnEliminar_OnClick(object sender, EventArgs e)
        {
            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("EliminarDetalleCompra", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idDetalleCompra", Convert.ToInt32(lblIdDetalleCompraEliminar.Text));
                    int filasAfectadas = sqlCommand.ExecuteNonQuery();
                }
                BindUltimaCompra();

                if (filasAfectadas != 0)
                {
                    //TODO: Mensaje exitoso
                }
                else
                {
                    //TODO: Mensaje de fracaso
                }
            }
            BindDetalleCompra();
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




        protected void btnAgregarProducto_OnClick(object sender, EventArgs e)
        {

            //TODO: Validar que los campos esten llenos
            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("InsertarDetalleCompra", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idCompra", inpIdCompra.Value);
                    sqlCommand.Parameters.AddWithValue("@idProducto", ddlProducto_dc.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@cantidadProductoComprado", inpCantidadProductoComprado.Value);
                    sqlCommand.Parameters.AddWithValue("@precioCompraUnidad", inpPrecioCompraUnidad.Value);
                    sqlCommand.Parameters.AddWithValue("@precioVentaUnidad", inpPrecioVentaUnidad.Value);
                    sqlCommand.Parameters.AddWithValue("@observaciones", inpObservaciones.Value);
                    Response.Redirect(Request.Url.ToString(), false);
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
            }
            BindUltimaCompra();
            ModalCrear(false);
        }
    }
}