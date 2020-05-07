using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaVentas.Login
{
    public partial class Index : System.Web.UI.Page
    {
        //CONEXION
        string cadenaConexion = ConfigurationManager.ConnectionStrings["conexion"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login_btn_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection conex = new SqlConnection(cadenaConexion);
                conex.Open();
                SqlCommand cmd = new SqlCommand("SP_LoginUser", conex);
                cmd.Parameters.Add("@nombreUsuario", SqlDbType.VarChar).Value = user_text.Text;
                cmd.Parameters.Add("@contraseniaUsuario", SqlDbType.VarChar).Value = password_text.Text;
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataReader rd = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                DataTable tb = new DataTable();
                tb.Load(rd);
                conex.Close();

                if (tb.Rows[0][0].ToString() == "1")
                {
                    Session["nombreTipoUsuario"] = tb.Rows[0][1].ToString();
                    Session["nombreUsuario"] = tb.Rows[0][2].ToString();
                    string result = Session["nombreUsuario"].ToString() + " " + Session["nombreTipoUsuario"].ToString();
                    test.Text = result.ToString();

                }
                else if (tb.Rows[0][0].ToString() == "0")
                {
                    test.Text = tb.Rows[0][1].ToString();
                }
            }
            catch (Exception ex)
            {

                test.Text = ex.ToString();
            }
        }
    }
}