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
        public static SqlConnection conexion()
        {
            string cadenaConexion = ConfigurationManager.ConnectionStrings["conexion"].ToString();
            SqlConnection sqlConnection = new SqlConnection(cadenaConexion);
            sqlConnection.Open();
            return sqlConnection;
        }


        public DataTable Seleccionar(string comandoSql)
        {
            var sqlConnection = conexion();

            DataTable dataTable = new DataTable();
            SqlCommand sqlCommand = new SqlCommand(comandoSql, sqlConnection);
            sqlCommand.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter SqlDataAdapter = new SqlDataAdapter(sqlCommand);
            SqlDataAdapter.Fill(dataTable);
            sqlConnection.Close();

            return dataTable;
        }

        public DataTable ObtenerDataTable(string storedProcedureName, params SqlParameter[] arrParam)
        {
            DataTable dataTable = new DataTable();

            //Abriendo la conexion
            string connectionString = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;
            SqlConnection connection = new SqlConnection(connectionString);
            connection.Open();

            // Declarar el comando
            using (SqlCommand sqlCommand = new SqlCommand())
            {
                sqlCommand.Connection = connection;
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.CommandText = storedProcedureName;

                // Agregar Parametros
                if (arrParam != null)
                {
                    foreach (SqlParameter param in arrParam)
                        sqlCommand.Parameters.Add(param);
                }

                // Declarar el dataAdapter y llena el dataset
                using (SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlCommand))
                {
                    sqlDataAdapter.Fill(dataTable);
                }
            }
            return dataTable;
        }


    }
}