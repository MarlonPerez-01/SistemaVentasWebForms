﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaVentas
{
    public partial class Default : System.Web.UI.Page
    {
        //CONEXION
        string cadenaConexion = ConfigurationManager.ConnectionStrings["conexion"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            alerta.Visible = false;

            //Este codigo es para redireccionar sin loguearme, eliminar en la entrega
            //Session["nombreUsuario"] = "Pedro1234";
            //Session["idTipoUsuario"] = "1234";
            //Response.Redirect("/Dashboard/Index.aspx");
        }

        protected void btnIngresar_OnClick(object sender, EventArgs e)
        {
            try
            {
                SqlConnection connection = new SqlConnection(cadenaConexion);
                connection.Open();
                SqlCommand cmd = new SqlCommand("ValidarUsuario", connection);
                cmd.Parameters.Add("@nombreUsuario", SqlDbType.VarChar).Value = txtNombreUsuario.Text;
                cmd.Parameters.Add("@contraseniaUsuario", SqlDbType.VarChar).Value = txtContraseniaUsuario.Text;
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                DataTable table = new DataTable();
                table.Load(reader);
                connection.Close();
                if (table.Rows[0][0].ToString() == "1")
                {
                    Session["resultado"] = table.Rows[0][0].ToString();
                    Session["nombreUsuario"] = table.Rows[0][1].ToString();
                    Session["contraseniaUsuario"] = table.Rows[0][2].ToString();
                    Session["idTipoUsuario"] = table.Rows[0][3].ToString();
                    Session["idEmpleado"] = table.Rows[0][4].ToString();
                    Session["fotografiaEmpleado"] = table.Rows[0][5].ToString();

                    if (table.Rows[0][3].ToString() == "1")
                    {
                        Response.Redirect("/Dashboard/Index.aspx");
                    }
                    else
                    {
                        Response.Redirect("/PuntoDeVenta/Index.aspx");
                    }
                  
                }
                else
                {
                    alerta.Visible = true;
                }
            }
            catch (Exception)
            {
            }
        }
    }
}