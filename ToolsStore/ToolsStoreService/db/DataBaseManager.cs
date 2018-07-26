using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using ToolsStoreService.log;

namespace ToolsStoreService.db
{
    class DataBaseManager
    {
        public static bool LoadCategory(string code, string name, int ord)
        {
            string conn;
            conn = System.Configuration.ConfigurationManager.ConnectionStrings["ToolsStoreConnectionString"].ToString();

            var cmd = new SqlCommand("SP_IM_CATEGORY", new SqlConnection(conn));
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 3600;

            try
            {
                cmd.Parameters.Add("@code", SqlDbType.NVarChar, 100);
                cmd.Parameters.Add("@name", SqlDbType.NVarChar, 250);
                cmd.Parameters.Add("@ord", SqlDbType.Int);

                cmd.Parameters["@code"].Value = code;
                cmd.Parameters["@name"].Value = name;
                cmd.Parameters["@ord"].Value = ord;

                if (cmd.Connection.State != ConnectionState.Closed)
                    cmd.Connection.Close();

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();
                cmd.Connection.Close();

                return true;
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                return false;
            }
            finally
            {
                if (cmd.Connection.State != ConnectionState.Closed)
                    cmd.Connection.Close();
            }                          
        }
    }
}
