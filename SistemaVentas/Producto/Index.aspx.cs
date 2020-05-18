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
using System.Web.UI.WebControls;
using SistemaVentas.Helpers;

namespace SistemaVentas.Producto
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
            var dataTable = new Crud().Seleccionar("SeleccionarProductos");
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

                int idProducto = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    sqlConnection.Open();
                    SqlCommand sqlCommand = new SqlCommand("SeleccionarProductoById_d", sqlConnection);
                    SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idProducto", idProducto);
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter.Fill(dataTable);

                    lblIdProducto.Text = dataTable.Rows[0][0].ToString();
                    lblCategoria.Text = dataTable.Rows[0][1].ToString();
                    lblMarca.Text = dataTable.Rows[0][2].ToString();
                    lblNombreProducto.Text = dataTable.Rows[0][3].ToString();
                    lblDescripciónProducto.Text = dataTable.Rows[0][4].ToString();

                    lblPrecioCompraUnidad.Text = dataTable.Rows[0][6].ToString();
                    lblPrecioVentaUnidad.Text = dataTable.Rows[0][7].ToString();
                    lblObservaciones.Text = dataTable.Rows[0][8].ToString();
                    lblStock.Text = dataTable.Rows[0][9].ToString();





                    byte[] img = (byte[])dataTable.Rows[0][5];
                    if (img != null && img.Length > 0)
                    {
                        imgProducto_d.ImageUrl = "data:image;base64," + Convert.ToBase64String(img);
                    }

                }

                ModalDetalles(true);
            }
            else if (e.CommandName == "editar")
            {
                ddlCategoriaBind_e();
                ddlMarcaBind_e();

                LinkButton btnEditar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEditar.NamingContainer;

                int idProducto = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    SqlCommand sqlCommand = new SqlCommand("SeleccionarProductoById_e", sqlConnection);
                    SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idProducto", idProducto);
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter.Fill(dataTable);

                    inpIdProducto_e.Value = dataTable.Rows[0][0].ToString();

                    string categoriaDB = dataTable.Rows[0][1].ToString();
                    ddlCategoria_e.SelectedIndex = ddlCategoria_e.Items.IndexOf(ddlCategoria_e.Items.FindByValue(categoriaDB));

                    string marcaDB = dataTable.Rows[0][2].ToString();
                    ddlMarca_e.SelectedIndex = ddlMarca_e.Items.IndexOf(ddlMarca_e.Items.FindByValue(marcaDB));

                    inpNombreProducto_e.Value = dataTable.Rows[0][3].ToString();

                    byte[] img = (byte[])dataTable.Rows[0][5];
                    if (img != null && img.Length > 0)
                    {
                        imgProducto_e.Src = "data:image;base64," + Convert.ToBase64String(img);
                    }

                    txtDescripcionProducto_e.Value = dataTable.Rows[0][4].ToString();
                }
                ModalEditar(true);

            }
            else if (e.CommandName == "eliminar")
            {
                LinkButton btnEliminar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEliminar.NamingContainer;

                int idProducto = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);
                lblIdProductoEliminar.Text = HttpUtility.HtmlDecode(gvrow.Cells[0].Text);
                ModalEliminar(true);
            }
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
                using (var sqlCommand = new SqlCommand("InsertarProducto", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idCategoria", ddlCategoria_c.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@idMarca", ddlMarca_c.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@nombreProducto", inpNombreProducto_c.Value);
                    sqlCommand.Parameters.AddWithValue("@descripcionProducto", inpDescripcionProducto_c.Value);
                    sqlCommand.Parameters.AddWithValue("@imagenProducto", SqlDbType.Image).Value = ImagenOriginal;

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

                var dataTable = new Crud().Seleccionar("SeleccionarProductos");
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
                using (var sqlCommand = new SqlCommand("ActualizarProducto", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idProducto", inpIdProducto_e.Value);
                    sqlCommand.Parameters.AddWithValue("@idCategoria", ddlCategoria_e.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@idMarca", ddlMarca_e.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@nombreProducto", inpNombreProducto_e.Value);
                    sqlCommand.Parameters.AddWithValue("@descripcionProducto", txtDescripcionProducto_e.Value);
                    sqlCommand.Parameters.AddWithValue("@imagenProducto", ImagenOriginal);

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
                using (var sqlCommand = new SqlCommand("EliminarProducto", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idProducto", Convert.ToInt32(lblIdProductoEliminar.Text));
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

        protected void btnCrearProducto_OnClick(object sender, EventArgs e)
        {
            //Bind Dropdownlist
            ddlCategoriaBind_c();
            ddlMarcaBind_c();
            //Limpiar Formulario

            ModalCrear(true);
        }

        protected void cerrar(object sender, EventArgs e)
        {
            ModalDetalles(false);
        }


        /*Dropdownlists*/
        protected void ddlMarcaBind_c()
        {
            var dataTable = new Crud().Seleccionar("MarcaList");
            ddlMarca_c.DataSource = dataTable;
            ddlMarca_c.DataTextField = "nombreMarca";
            ddlMarca_c.DataValueField = "idMarca";
            ddlMarca_c.DataBind();
        }

        protected void ddlMarcaBind_e()
        {
            var dataTable = new Crud().Seleccionar("MarcaList");
            ddlMarca_e.DataSource = dataTable;
            ddlMarca_e.DataTextField = "nombreMarca";
            ddlMarca_e.DataValueField = "idMarca";
            ddlMarca_e.DataBind();
        }

        protected void ddlCategoriaBind_c()
        {
            var dataTable = new Crud().Seleccionar("CategoriaList");
            ddlCategoria_c.DataSource = dataTable;
            ddlCategoria_c.DataTextField = "nombreCategoria";
            ddlCategoria_c.DataValueField = "idCategoria";
            ddlCategoria_c.DataBind();
        }

        protected void ddlCategoriaBind_e()
        {
            var dataTable = new Crud().Seleccionar("CategoriaList");
            ddlCategoria_e.DataSource = dataTable;
            ddlCategoria_e.DataTextField = "nombreCategoria";
            ddlCategoria_e.DataValueField = "idCategoria";
            ddlCategoria_e.DataBind();
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


    }
}