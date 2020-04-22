using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SistemaVentas.Helpers;

namespace SistemaVentas.Empleado
{
    public partial class Create : System.Web.UI.Page
    {
        //CONEXION
        private SqlConnection sqlConnection;
        private void connection()
        {
            string constr = ConfigurationManager.ConnectionStrings["conexion"].ToString();
            sqlConnection = new SqlConnection(constr);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            obtenerCargoList();
        }

        public void obtenerCargoList()
        {
            var dataTable = new Crud().Seleccionar("CargoList");
            ddlIdCargo.DataSource = dataTable;
            ddlIdCargo.DataTextField = "nombreCargo";
            ddlIdCargo.DataValueField = "idCargo";
            ddlIdCargo.DataBind();
        }






        protected void btnCrearEmpleado_OnClick(object sender, EventArgs e)
        {
            connection();
            var sqlCommand = new SqlCommand("InsertarEmpleado", sqlConnection)
            {
                CommandType = CommandType.StoredProcedure
            };

            sqlCommand.Parameters.AddWithValue("@idCargo", ddlIdCargo.SelectedValue);
            sqlCommand.Parameters.AddWithValue("@primerNombreEmpleado", inpPrimerNombreEmpleado.Value);
            sqlCommand.Parameters.AddWithValue("@segundoNombreEmpleado", inpSegundoNombreEmpleado.Value);
            sqlCommand.Parameters.AddWithValue("@primerApellidoEmpleado", inpPrimerApellidoEmpleado.Value);
            sqlCommand.Parameters.AddWithValue("@segundoApellidoEmpleado", inpSegundoApellidoEmpleado.Value);
            sqlCommand.Parameters.AddWithValue("@duiEmpleado", inpDuiEmpleado.Value);
            sqlCommand.Parameters.AddWithValue("@nitEmpleado", inpNitEmpleado.Value);
            //sqlCommand.Parameters.AddWithValue("@fotografiaEmpleado", "foto");
            sqlCommand.Parameters.Add("@fotografiaEmpleado", SqlDbType.Binary).Value = algo();
            sqlCommand.Parameters.AddWithValue("@fechaNacimientoEmpleado", inpFechaNacimientoEmpleado.Value);
            sqlCommand.Parameters.AddWithValue("@fechaContrato", inpFechaContrato.Value);
            sqlCommand.Parameters.AddWithValue("@telefonoEmpleado", inpTelefonoEmpleado.Value);
            sqlCommand.Parameters.AddWithValue("@correoEmpleado", inpCorreoEmpleado.Value);
            sqlCommand.Parameters.AddWithValue("@sexoEmpleado", ddlSexo.Value);
            sqlCommand.Parameters.AddWithValue("@departamentoEmpleado", inpDepartamentoEmpleado.Value);
            sqlCommand.Parameters.AddWithValue("@municipioEmpleado", inpMunicipioEmpleado.Value);
            sqlCommand.Parameters.AddWithValue("@detallesDireccionEmpleado", inpDetallesDireccionEmpleado.Value);

            sqlConnection.Open();
            int i = sqlCommand.ExecuteNonQuery();


            lblMensaje.Text = i != 0 ? "Record Inserted Succesfully into the Database" : "Record NOT Inserted Succesfully into the Database";
            sqlConnection.Close();

            //Limpiando campos cuando se inserta un cliente
            //= String.Empty;
        }


        protected void btnRegresar_OnClicksar_OnClick(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }


        public Byte[] algo()
        {
            Stream fs = fuFotografiaEmpleado.PostedFile.InputStream;

            BinaryReader br = new BinaryReader(fs);

            Byte[] bytes = br.ReadBytes((Int32)fs.Length);

            return bytes;
        }


        protected void btnCargarFotografia_OnClick(object sender, EventArgs e)
        {/*
            HttpPostedFile httpPostedFile = fuFotografiaEmpleado.PostedFile;
            string nombreArchivo = Path.GetFileName(httpPostedFile.FileName);
            string extencionArchivo = Path.GetExtension(nombreArchivo);
            int pesoArchivo = httpPostedFile.ContentLength;

            if (extencionArchivo.ToLower() == ".jpg" || extencionArchivo.ToLower() == ".bmp" || extencionArchivo.ToLower() == ".png")
            {
                Stream stream = httpPostedFile.InputStream;
                BinaryReader binaryReader = new BinaryReader(stream);
                bytes = binaryReader.ReadBytes((int)stream.Length);
            }
            else
            {
                lblFotografiaEmpleado.Visible = true;
                lblFotografiaEmpleado.Text = "Extencion incorrecta";
            }*/

            algo();


        }
    }
}