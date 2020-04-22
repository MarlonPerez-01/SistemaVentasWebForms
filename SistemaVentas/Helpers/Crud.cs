using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace SistemaVentas.Helpers
{
    public class Crud
    {
        //ctrl k d
        string cadenaConexion = ConfigurationManager.ConnectionStrings["conexion"].ToString();
        
        public DataTable Seleccionar(string comandoSql)
        {
            using (var sqlConnection = new SqlConnection(cadenaConexion))
            {
                sqlConnection.Open();
                DataTable dataTable = new DataTable();
                SqlCommand sqlCommand = new SqlCommand(comandoSql, sqlConnection);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
                SqlDataAdapter.Fill(dataTable);
                return dataTable;
            }
        }
    }
}