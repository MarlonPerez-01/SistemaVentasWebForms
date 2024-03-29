﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaVentas.PuntoDeVenta
{
    public partial class Index : System.Web.UI.Page
    {
        public string ConexString = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                try
                {
                    SqlConnection conex = new SqlConnection(ConexString);
                    conex.Open();
                    SqlCommand cmd = new SqlCommand("SeleccionarCategorias", conex);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataReader rd = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                    DataTable tb = new DataTable();
                    tb.Load(rd);
                    conex.Close();
                    ddlbuscar.DataSource = tb;
                    ddlbuscar.DataTextField = "nombreCategoria";
                    ddlbuscar.DataValueField = "idCategoria";
                    ddlbuscar.DataBind();
                    ddlbuscar.Items.Insert(0, new ListItem("Selecione Categoria", "0"));
                }

                catch (Exception ex)
                {

                    msg.Text = ex.ToString(); ;
                }
            }
        }


        void botar_tabla()
        {
            SqlConnection conex = new SqlConnection(ConexString);
            conex.Open();
            SqlCommand cmd = new SqlCommand("botar_table", conex);



            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader read = cmd.ExecuteReader(CommandBehavior.CloseConnection);

            conex.Close();
        }


        protected void btncrear_Click(object sender, EventArgs e)
        {
            //Validacion del los textbox txtnombre y txtapellidos

            if (string.IsNullOrEmpty(txtNombres.Text) && string.IsNullOrEmpty(txtApellidos.Text))
            {

                crearcliente.Text = " Ingrese nombres y apellidos";


            }
            else if (string.IsNullOrEmpty(txtNombres.Text) == false && string.IsNullOrEmpty(txtApellidos.Text) == false)
            {
                Ingresarcliente();
                crearcliente.Text = null;
                crearexito.Text = " Cliente guardado";
            }
            else if (string.IsNullOrEmpty(txtNombres.Text) == false)
            {
                crearcliente.Text = " Ingrese almenos un apellido";
            }
            else
            {

                crearcliente.Text = " Ingrese almenos un nombre";

            }








        }

        void Ingresarcliente()
        {
            String apellidos = txtApellidos.Text.Trim();

            String nombres = txtNombres.Text.Trim();
            if (apellidos.Contains(" ") && nombres.Contains(" "))
            {
                String[] split2 = apellidos.Split(' ');
                string apellido1 = split2[0];
                string apellido2 = split2[1];

                String[] split = nombres.Split(' ');
                string nombre1 = split[0];
                string nombre2 = split[1];

                SqlConnection conex = new SqlConnection(ConexString);
                conex.Open();


                SqlCommand cmd = new SqlCommand("InsertarCliente", conex);
                cmd.Parameters.Add("@primerNombreCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(nombre1);
                cmd.Parameters.Add("@segundoNombreCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(nombre2);
                cmd.Parameters.Add("@primerApellidoCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(apellido1);
                cmd.Parameters.Add("@segundoApellidoCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(apellido2);
                cmd.Parameters.Add("@duiCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(txtDui.Text);
                cmd.Parameters.Add("@nitCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(txtNit.Text);
                cmd.Parameters.Add("@telefonoCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(txtNumerTelefono.Text);


                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader read = cmd.ExecuteReader(CommandBehavior.CloseConnection);



                conex.Close();

            }
            else if (apellidos.Contains(" ") == false && nombres.Contains(" ") == false)
            {

                string apellido1 = apellidos;
                string apellido2 = "";


                string nombre1 = nombres;
                string nombre2 = "";

                SqlConnection conex = new SqlConnection(ConexString);
                conex.Open();


                SqlCommand cmd = new SqlCommand("InsertarCliente", conex);
                cmd.Parameters.Add("@primerNombreCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(nombre1);
                cmd.Parameters.Add("@segundoNombreCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(nombre2);
                cmd.Parameters.Add("@primerApellidoCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(apellido1);
                cmd.Parameters.Add("@segundoApellidoCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(apellido2);
                cmd.Parameters.Add("@duiCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(txtDui.Text);
                cmd.Parameters.Add("@nitCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(txtNit.Text);
                cmd.Parameters.Add("@telefonoCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(txtNumerTelefono.Text);


                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader read = cmd.ExecuteReader(CommandBehavior.CloseConnection);



                conex.Close();

            }
            else if (apellidos.Contains(" ") == false)
            {

                string apellido1 = apellidos;
                string apellido2 = "";


                string nombre1 = nombres;
                string nombre2 = "";

                SqlConnection conex = new SqlConnection(ConexString);
                conex.Open();


                SqlCommand cmd = new SqlCommand("InsertarCliente", conex);
                cmd.Parameters.Add("@primerNombreCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(nombre1);
                cmd.Parameters.Add("@segundoNombreCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(nombre2);
                cmd.Parameters.Add("@primerApellidoCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(apellido1);
                cmd.Parameters.Add("@segundoApellidoCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(apellido2);
                cmd.Parameters.Add("@duiCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(txtDui.Text);
                cmd.Parameters.Add("@nitCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(txtNit.Text);
                cmd.Parameters.Add("@telefonoCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(txtNumerTelefono.Text);


                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader read = cmd.ExecuteReader(CommandBehavior.CloseConnection);



                conex.Close();

            }
            else
            {
                string nombre1 = nombres;
                string nombre2 = "";

                String[] split2 = apellidos.Split(' ');
                string apellido1 = split2[0];
                string apellido2 = split2[1];

                SqlConnection conex = new SqlConnection(ConexString);
                conex.Open();


                SqlCommand cmd = new SqlCommand("InsertarCliente", conex);
                cmd.Parameters.Add("@primerNombreCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(nombre1);
                cmd.Parameters.Add("@segundoNombreCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(nombre2);
                cmd.Parameters.Add("@primerApellidoCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(apellido1);
                cmd.Parameters.Add("@segundoApellidoCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(apellido2);
                cmd.Parameters.Add("@duiCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(txtDui.Text);
                cmd.Parameters.Add("@nitCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(txtNit.Text);
                cmd.Parameters.Add("@telefonoCliente", System.Data.SqlDbType.VarChar).Value = Convert.ToString(txtNumerTelefono.Text);


                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader read = cmd.ExecuteReader(CommandBehavior.CloseConnection);



                conex.Close();
            }
        }


        protected void ddlbuscar2_SelectedIndexChanged(object sender, EventArgs e)
        {



        }

        protected void CategoriaSeleccionada(object sender, EventArgs e)
        {
            int marca = Convert.ToInt32(ddlbuscar.SelectedValue);
            SqlConnection conex = new SqlConnection(ConexString);
            conex.Open();
            SqlCommand cmd = new SqlCommand("nombremarca", conex);
            cmd.Parameters.Add("idcategoria", System.Data.SqlDbType.Int).Value = (marca);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader rd = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            DataTable tb = new DataTable();
            tb.Load(rd);
            conex.Close();
            ddlbuscar2.DataSource = tb;
            ddlbuscar2.DataTextField = "nombremarca";
            ddlbuscar2.DataValueField = "idProducto";
            ddlbuscar2.DataBind();
            ddlbuscar2.Items.Insert(0, new ListItem("seleccionar marca", "0"));

        }

        protected void MarcaSelecionada(object sender, EventArgs e)
        {
            int marca = Convert.ToInt32(ddlbuscar2.SelectedValue);
            SqlConnection conex = new SqlConnection(ConexString);
            conex.Open();
            SqlCommand cmd = new SqlCommand("nombreproducto", conex);
            cmd.Parameters.Add("idproducto", System.Data.SqlDbType.Int).Value = (marca);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader rd = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            DataTable tb = new DataTable();
            tb.Load(rd);
            conex.Close();
            ddlbuscar3.DataSource = tb;
            ddlbuscar3.DataTextField = "nombreProducto";
            ddlbuscar3.DataValueField = "idProducto";
            ddlbuscar3.DataBind();
            ddlbuscar3.Items.Insert(0, new ListItem("Selecionar producto", "0"));


        }

        protected void ProductoSeleccionado(object sender, EventArgs e)
        {

            SqlConnection conex = new SqlConnection(ConexString);
            conex.Open();
            SqlCommand cmd = new SqlCommand("if_tabla", conex);



            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader read = cmd.ExecuteReader(CommandBehavior.CloseConnection);

            conex.Close();
        }
        //Agregacion de productos a la tabla
        protected void BtnAgregar_Click(object sender, EventArgs e)
        {
            int idproducto = Convert.ToInt32(ddlbuscar2.SelectedValue);
            SqlConnection conex = new SqlConnection(ConexString);
            conex.Open();
            SqlCommand cmd = new SqlCommand("lista", conex);
            cmd.Parameters.Add("idproducto", System.Data.SqlDbType.Int).Value = (idproducto);
            cmd.Parameters.Add("cantidad", System.Data.SqlDbType.Int).Value = Convert.ToInt32(cantidad.Text);


            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader read = cmd.ExecuteReader(CommandBehavior.CloseConnection);

            conex.Close();

            mostrarProductos();

            ddlbuscar.SelectedIndex = 0;
            ddlbuscar2.SelectedIndex = 0;
            ddlbuscar3.SelectedIndex = 0;

            cantidad.Text = string.Empty;

        }

        //mostreo del gripview de los productos agregados
        void mostrarProductos()
        {


            DataTable dtbl = new DataTable();
            using (SqlConnection sqlConnection = new SqlConnection(ConexString))
            {
                sqlConnection.Open();
                SqlDataAdapter sqlDa = new SqlDataAdapter("Select id, producto,cantidad,precio,descuent,descuento from tabla", sqlConnection);
                sqlDa.Fill(dtbl);
            }
            gvproductos.DataSource = dtbl;
            gvproductos.DataBind();


        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            SqlConnection conex = new SqlConnection(ConexString);
            conex.Open();
            SqlCommand cmd = new SqlCommand("generarventa", conex);
            cmd.Parameters.Add("@efectivo", System.Data.SqlDbType.VarChar).Value = Convert.ToString(txtEfectivo.Text);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader read = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            DataTable tab = new DataTable();
            tab.Load(read);
            conex.Close();
            txtEfectivo.Text = Convert.ToString(tab.Rows[0][0]);
            txtSubtotal.Text = Convert.ToString(tab.Rows[0][1]);
            txtAhorro.Text = Convert.ToString(tab.Rows[0][2]);
            txtGeneral.Text = Convert.ToString(tab.Rows[0][3]);
            txtCmbio.Text = Convert.ToString(tab.Rows[0][4]);




            ingresar();
            ingresarventa();

            string prueba = "Dinero insuficiente";
            if (txtCmbio.Text != prueba)
            {
                botar_tabla();
            }


            ddlbuscar.SelectedIndex = 0;
            ddlbuscar2.SelectedIndex = 0;
            ddlbuscar3.SelectedIndex = 0;

            cantidad.Text = string.Empty;

            txtNombres.Text = string.Empty;
            txtApellidos.Text = string.Empty;
            txtDui.Text = string.Empty;
            txtNit.Text = string.Empty;
            txtNumerTelefono.Text = string.Empty;

        }

        void ingresar()
        {
            /*int idempleado;
            string id = Session["idTipoUsuario"] as string;
            Int32.TryParse(id, out idempleado);*/
            string idempleado = Session["idTipoUsuario"] as string;
            //int  = Convert.ToInt32(id.ToString());

            SqlConnection conex = new SqlConnection(ConexString);
            conex.Open();
            SqlCommand command = new SqlCommand("venta_", conex);
            command.Parameters.Add("@idempleado", System.Data.SqlDbType.Int).Value = idempleado;




            command.CommandType = CommandType.StoredProcedure;
            SqlDataReader rea = command.ExecuteReader(CommandBehavior.CloseConnection);


            conex.Close();

        }

        void ingresarventa()
        {

            SqlConnection conex = new SqlConnection(ConexString);
            conex.Open();
            SqlCommand command = new SqlCommand("detalleventa_", conex);




            command.CommandType = CommandType.StoredProcedure;
            SqlDataReader rea = command.ExecuteReader(CommandBehavior.CloseConnection);

            conex.Close();
            //exitoventa.Text = " Venta realizada";
            crearexito.Text = string.Empty;

        }

        protected void gvproductos_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvproductos.DataKeys[e.RowIndex].Values[0]);

            using (SqlConnection sqlcon = new SqlConnection(ConexString))
            {
                sqlcon.Open();
                string query = "delete from tabla where id=@id";
                SqlCommand sqlcmd = new SqlCommand(query, sqlcon);
                sqlcmd.Parameters.AddWithValue("@id", Convert.ToInt32(gvproductos.DataKeys[e.RowIndex].Value.ToString()));

                sqlcmd.ExecuteNonQuery();
                mostrarProductos();
            }
        }



        /*protected void gvproductos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if(e.CommandName.Equals("Eliminar"))
                {
                    using (SqlConnection sqlcon = new SqlConnection(ConexString))
                    {
                        sqlcon.Open();
                        string query = "delete from tabla where id=@id";
                        SqlCommand sqlcmd = new SqlCommand(query, sqlcon);
                        sqlcmd.Parameters.AddWithValue("id", Convert.ToInt32(gvproductos.DataKeys[e.RowIndex].Value.ToString()));
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
        }*/
    }
}