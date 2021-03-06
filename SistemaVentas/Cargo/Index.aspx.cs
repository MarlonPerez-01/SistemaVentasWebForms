﻿using System;
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

namespace SistemaVentas.Cargo
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

        //Obteniendo el listado de Cargos para el GridView principal
        protected void Bind()
        {
            try
            {
                var dataTable = new Crud().Seleccionar("SeleccionarCargos");
                GridView1.DataSource = dataTable;
                GridView1.DataBind();
                var cantidad = dataTable.Rows.Count;
                cantidadCargos.InnerText = cantidad.ToString();
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception);
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

                int idCargo = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

                try
                {
                    using (var sqlConnection = new SqlConnection(cadenaConexion))
                    {
                        SqlCommand sqlCommand = new SqlCommand("SeleccionarCargoById", sqlConnection);
                        SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@idCargo", idCargo);
                        DataTable dataTable = new DataTable();
                        SqlDataAdapter.Fill(dataTable);

                        lblIdCargo.Text = dataTable.Rows[0][0].ToString();
                        lblNombreCargo.Text = dataTable.Rows[0][1].ToString();
                        lblSalarioCargo.Text = dataTable.Rows[0][2].ToString();
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

                int idCargo = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);

                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    SqlCommand sqlCommand = new SqlCommand("SeleccionarCargoById", sqlConnection);
                    SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idCargo", idCargo);
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter.Fill(dataTable);

                    inpIdCargo_e.Value = dataTable.Rows[0][0].ToString();
                    inpNombreCargo_e.Value = dataTable.Rows[0][1].ToString();
                    inpSalarioCargo_e.Value = dataTable.Rows[0][2].ToString();
                }
                ModalEditar(true);
            }
            else if (e.CommandName == "eliminar")
            {
                LinkButton btnEliminar = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btnEliminar.NamingContainer;

                int idCargo = Convert.ToInt32(GridView1.DataKeys[gvrow.RowIndex]?.Value);
                try
                {
                    lblIdCargoEliminar.Text = HttpUtility.HtmlDecode(gvrow.Cells[0].Text);
                    ModalEliminar(true);
                }
                catch (Exception exception)
                {
                    Console.WriteLine(exception);
                    throw;
                }
            }
        }

        //Mostrando Modal Crear cuando el boton CrearCargo sea presionado
        protected void btnCrearCargo_OnClick(object sender, EventArgs e)
        {
            ModalCrear(true);
        }


        //Insertar el nuevo cargo al presionar el boton "Crear" del modal CrearCargo
        protected void btnCrear_OnClick(object sender, EventArgs e)
        {
            //TODO: Validar que los campos esten llenos
            try
            {
                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    using (var sqlCommand = new SqlCommand("InsertarCargo", sqlConnection))
                    {
                        sqlConnection.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@nombreCargo", inpNombreCargo_c.Value);
                        sqlCommand.Parameters.AddWithValue("@salarioCargo", Convert.ToDecimal(inpSalarioCargo_c.Value));

                        Response.Redirect(Request.Url.ToString(), false);
                        filasAfectadas = sqlCommand.ExecuteNonQuery();
                    }

                    if (filasAfectadas != 0)
                    {
                        //TODO: Mensaje exitoso

                        //Limpiando el modal despues de la insercion
                        inpNombreCargo_c.Value = String.Empty;
                        inpSalarioCargo_c.Value = String.Empty;
                    }
                    else
                    {
                        //TODO: Mensaje de fracaso
                    }

                    Bind();
                }

                ModalCrear(false);
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception);
                throw;
            }
        }

        //Actualizando los datos del modal Actualizar
        protected void btnActualizar_OnClick(object sender, EventArgs e)
        {
            //TODO: Validar que los campos esten llenos

            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                using (var sqlCommand = new SqlCommand("ActualizarCargo", sqlConnection))
                {
                    sqlConnection.Open();
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@idCargo", inpIdCargo_e.Value);
                    sqlCommand.Parameters.AddWithValue("@nombreCargo", inpNombreCargo_e.Value);
                    sqlCommand.Parameters.AddWithValue("@salarioCargo", Convert.ToDecimal(inpSalarioCargo_e.Value));
                    
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
            try
            {
                using (var sqlConnection = new SqlConnection(cadenaConexion))
                {
                    using (var sqlCommand = new SqlCommand("EliminarCargo", sqlConnection))
                    {
                        sqlConnection.Open();
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@idCargo", Convert.ToInt32(lblIdCargoEliminar.Text));
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
            /*
            try
            {

                SqlDataAdapter sqlDataAdapter = new SqlDataAdapter("select * from cliente where primerNombreCargo like '" + txtBuscar.Text + "%'", cadenaConexion);
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