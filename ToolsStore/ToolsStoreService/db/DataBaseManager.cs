using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;
using ToolsStoreService.log;
using ToolsStoreService.ds;
using ToolsStoreService.file;

namespace ToolsStoreService.db
{
    class DataBaseManager
    {
        public static bool GetLoadRule(string path, out List<LoadRule> lrs)
        {
            lrs = new List<LoadRule>();
            try
            {
                string conn;
                conn = System.Configuration.ConfigurationManager.ConnectionStrings["ToolsStoreConnectionString"].ToString();

                var daLoadRule = new SqlDataAdapter("SP_GET_LOAD_RULE", new SqlConnection(conn));
                daLoadRule.SelectCommand.CommandType = CommandType.StoredProcedure;
                daLoadRule.SelectCommand.CommandTimeout = 1800;
                daLoadRule.SelectCommand.Parameters.Add("@Path", System.Data.SqlDbType.NVarChar, 1000);
                daLoadRule.SelectCommand.Parameters["@Path"].Value = path;
                daLoadRule.TableMappings.AddRange(new System.Data.Common.DataTableMapping[] {
                        new System.Data.Common.DataTableMapping("Table", "SP_GET_LOAD_RULE", new System.Data.Common.DataColumnMapping[] {
                        new System.Data.Common.DataColumnMapping("LoadRuleId", "LoadRuleId"),
                        new System.Data.Common.DataColumnMapping("Code", "Code"),
                        new System.Data.Common.DataColumnMapping("FileName", "FileName"),
                        new System.Data.Common.DataColumnMapping("IsActive", "IsActive"),
                        new System.Data.Common.DataColumnMapping("MethodLoad", "MethodLoad"),
                        new System.Data.Common.DataColumnMapping("PathToXsd", "PathToXsd"),
                        new System.Data.Common.DataColumnMapping("XsdName", "XsdName"),
                        new System.Data.Common.DataColumnMapping("Descr", "Descr"),
                        new System.Data.Common.DataColumnMapping("Ord", "Ord")})});

                var dsLoadRule = new dsLoadRule();
                dsLoadRule.Clear();
                daLoadRule.Fill(dsLoadRule);

                foreach (var row in dsLoadRule.SP_GET_LOAD_RULE)
                {
                    var lr = new LoadRule();

                    lr.Code = row.Code;
                    lr.FileName = row.FileName;
                    lr.IsActive = row.IsActive;
                    lr.MethodLoad = row.MethodLoad;
                    lr.PathToXsd = row.PathToXsd;
                    lr.XsdName = row.XsdName;
                    lr.Description = row.Descr;
                    lr.Order = row.Ord;

                    lrs.Add(lr);
                }
                                
                return true;
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                lrs = null;
                return false;
            }
        }

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

        public static bool LoadVat(int code, string name, bool rem)
        {
            string conn;
            conn = System.Configuration.ConfigurationManager.ConnectionStrings["ToolsStoreConnectionString"].ToString();

            var cmd = new SqlCommand("SP_IM_VAT", new SqlConnection(conn));
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 3600;

            try
            {
                cmd.Parameters.Add("@code", SqlDbType.Int);
                cmd.Parameters.Add("@name", SqlDbType.NVarChar, 100);
                cmd.Parameters.Add("@rem", SqlDbType.Bit);

                cmd.Parameters["@code"].Value = code;
                cmd.Parameters["@name"].Value = name;
                cmd.Parameters["@rem"].Value = rem;

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
