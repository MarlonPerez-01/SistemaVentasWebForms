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

namespace SistemaVentas.Venta

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
            var dataTable = new Crud().Seleccionar("SeleccionarVentas");
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

                int idVenta = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    var dataTable = new DataTable();
                    SqlCommand sqlCommand = new SqlCommand("SeleccionarDetalleVenta", sqlConnection);
                    SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idVenta", idVenta);
                    SqlDataAdapter.Fill(dataTable);
                    GridView2.DataSource = dataTable;
                    GridView2.DataBind();
                }
                ModalDetalles(true);
            }
            else if (e.CommandName == "editar")
            {
                LinkButton btnEditar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEditar.NamingContainer;

                int idVenta = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);
                ddlProveedorBind_e();
                ddlUsuarioBind_e();
                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    SqlCommand sqlCommand = new SqlCommand("SeleccionarVentasById_e", sqlConnection);
                    SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idVenta", idVenta);
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter.Fill(dataTable);

                    inpIdVenta_e.Value = dataTable.Rows[0][0].ToString();
                    ddlProveedor_e.SelectedValue = dataTable.Rows[0][1].ToString();
                    ddlUsuario_e.SelectedValue = dataTable.Rows[0][2].ToString();
                    DateTime sdate = (DateTime)dataTable.Rows[0][3];
                    inpFechaVenta.Value = sdate.ToShortDateString();

                    inpHoraVenta.Value = dataTable.Rows[0][4].ToString();
                }
                ModalEditar(true);
            }
            else if (e.CommandName == "eliminar")
            {
                LinkButton btnEliminar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEliminar.NamingContainer;

                int idVenta = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);
                lblIdVentaEliminar.Text = HttpUtility.HtmlDecode(gvrow.Cells[0].Text);
                ModalEliminar(true);
            }
        }


        protected void ddlProveedorBind_e()
        {
            var dataTable = new Crud().Seleccionar("ProveedorList");
            ddlProveedor_e.DataSource = dataTable;
            ddlProveedor_e.DataTextField = "nombreProveedor";
            ddlProveedor_e.DataValueField = "idProveedor";
            ddlProveedor_e.DataBind();
        }


        protected void ddlUsuarioBind_e()
        {
            var dataTable = new Crud().Seleccionar("UsuarioList");
            ddlUsuario_e.DataSource = dataTable;
            ddlUsuario_e.DataTextField = "nombreUsuario";
            ddlUsuario_e.DataValueField = "idUsuario";
            ddlUsuario_e.DataBind();
        }

        protected void btnActualizar_OnClick(object sender, EventArgs e)
        {
            //TODO: Validar que los campos esten llenos

            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("ActualizarVenta", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idVenta", inpIdVenta_e.Value);
                    sqlCommand.Parameters.AddWithValue("@idProveedor", ddlProveedor_e.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@idUsuario", ddlUsuario_e.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@fechaVenta", inpFechaVenta.Value);
                    sqlCommand.Parameters.AddWithValue("@horaVenta", inpHoraVenta.Value);

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

                var dataTable = new Crud().Seleccionar("SeleccionarVentas");
                GridView1.DataSource = dataTable;
                GridView1.DataBind();
            }
            ModalEditar(false);
        }

        protected void btnEliminar_OnClick(object sender, EventArgs e)
        {
            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("EliminarVenta", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idVenta", Convert.ToInt32(lblIdVentaEliminar.Text));
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




        protected void btnBuscar_OnClick(object sender, EventArgs e)
        {
            //TODO: programar el filtro
            throw new NotImplementedException();
        }

        protected void btnImprimir_OnClick(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }
    }
}