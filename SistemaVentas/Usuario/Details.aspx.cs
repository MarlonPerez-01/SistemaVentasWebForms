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

namespace SistemaVentas.Usuario
{
    public partial class Details : System.Web.UI.Page
    {
        DataTable dt = new DataTable();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings ["NorthwindConnectionString"].ToString());
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Bind();
            }
        }

        protected void Bind()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT [CustomerID], [CompanyName], [ContactName], [Address], [City] FROM [Customers] ", con);
            cmd.CommandType = CommandType.Text;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            GridViewData.DataSource = dt;
            GridViewData.DataBind();
        }

        protected void GridViewData_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ShowPopup")
            {
                LinkButton btndetails = (LinkButton)e.CommandSource;
                GridViewRow gvrow = (GridViewRow)btndetails.NamingContainer;
                lblID.Text = GridViewData.DataKeys[gvrow.RowIndex].Value.ToString();
                // DataRow dr = dt.Select("CustomerID=" + GridViewData.DataKeys[gvrow.RowIndex].Value.ToString())[0];
                lblContactName.Text = HttpUtility.HtmlDecode(gvrow.Cells[2].Text);
                txtAddress.Text = HttpUtility.HtmlDecode(gvrow.Cells[3].Text);
                txtCity.Text = HttpUtility.HtmlDecode(gvrow.Cells[4].Text);
                Popup(true);
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (txtAddress.Text == "")
            {
                LabelValidate.Text = "Please enter the address.";
                LabelValidate.ForeColor = Color.Red;
            }
            else
            {

                con.Open();
                SqlCommand cmd = new SqlCommand("update Customers set Address=@Address,City=@City where CustomerID=@CustomerID", con);
                cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
                cmd.Parameters.AddWithValue("@City", txtCity.Text);
                cmd.Parameters.AddWithValue("@CustomerID", lblID.Text);
                cmd.ExecuteNonQuery();
                con.Close();
                lblresult.Text = lblContactName.Text + " Details Updated Successfully";
                lblresult.ForeColor = Color.Green;
                Bind();
                Popup(false);
            }
        }

        protected void cerrar(object sender, EventArgs e)
        {
            Popup(false);
        }

        //To show message after performing operations
        void Popup(bool isDisplay)
        {
            StringBuilder builder = new StringBuilder();
            if (isDisplay)
            {
                builder.Append("<script language=JavaScript> ShowPopup(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowPopup", builder.ToString());
            }
            else
            {
                builder.Append("<script language=JavaScript> HidePopup(); </script>\n");
                Page.ClientScript.RegisterStartupScript(this.GetType(), "HidePopup", builder.ToString());
            }
        }
    }
}