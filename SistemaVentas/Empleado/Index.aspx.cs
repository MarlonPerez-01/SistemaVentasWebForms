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

namespace SistemaVentas.Empleado
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









        protected void btnBuscar_OnClick(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }

        protected void btnCrearCliente_OnClick(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }

 

    
        protected void btnCrear_OnClick(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }


        protected void btnActualizar_OnClick(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }

        protected void btnEliminar_OnClick(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }

        protected void btnCrearEmpleado_OnClick(object sender, EventArgs e)
        {
            throw new NotImplementedException();
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