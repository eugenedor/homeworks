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
        public static bool GetSettingValue(string code, out string value)
        {
            value = string.Empty;
            try
            {
                string conn;
                conn = System.Configuration.ConfigurationManager.ConnectionStrings["ToolsStoreConnectionString"].ToString();

                SqlCommand cmdSet = new SqlCommand();
                cmdSet.CommandType = System.Data.CommandType.StoredProcedure;
                cmdSet.CommandText = "SP_GET_SETTING_VALUE";

                cmdSet.Parameters.Add("@Code", SqlDbType.NVarChar, 50);
                cmdSet.Parameters["@Code"].IsNullable = true;
                cmdSet.Parameters["@Code"].Value = code;
                cmdSet.Parameters.Add("@Value", SqlDbType.NVarChar, 250);
                cmdSet.Parameters["@Value"].IsNullable = true;
                cmdSet.Parameters["@Value"].Direction = ParameterDirection.Output;

                cmdSet.Connection = new SqlConnection(conn);
                cmdSet.CommandTimeout = 1800;

                if (cmdSet.Connection.State != ConnectionState.Closed)
                    cmdSet.Connection.Close();
                cmdSet.Connection.Open();
                cmdSet.ExecuteNonQuery();

                if (cmdSet.Parameters["@Value"].Value == DBNull.Value)
                    value = null;
                else
                    value = cmdSet.Parameters["@Value"].Value.ToString();

                cmdSet.Connection.Close();

                return true;
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                return false;
            }
        }

        public static bool GetLoadRule(string path, out List<LoadRule> LoadRules)
        {
            LoadRules = new List<LoadRule>();
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
                        new System.Data.Common.DataColumnMapping("Pattern", "Pattern"),
                        new System.Data.Common.DataColumnMapping("Method", "Method"),
                        new System.Data.Common.DataColumnMapping("Descr", "Descr"),
                        new System.Data.Common.DataColumnMapping("IsActive", "IsActive"),
                        new System.Data.Common.DataColumnMapping("Ord", "Ord"),
                        new System.Data.Common.DataColumnMapping("LoadRuleSpecId", "LoadRuleSpecId"),
                        new System.Data.Common.DataColumnMapping("FileName", "FileName"),
                        new System.Data.Common.DataColumnMapping("PathToFile", "PathToFile"),
                        new System.Data.Common.DataColumnMapping("IsMain", "IsMain")})});

                var dsLoadRule = new dsLoadRule();
                dsLoadRule.Clear();
                daLoadRule.Fill(dsLoadRule);

                foreach (var row in dsLoadRule.SP_GET_LOAD_RULE)
                {
                    if (!LoadRules.Any(x => x.LoadRuleId == row.LoadRuleId))
                    {
                        var lr1 = new LoadRule();
                        lr1.LoadRuleId = row.LoadRuleId;
                        lr1.Code = row.Code;
                        lr1.Pattern = row.Pattern;
                        lr1.Method = row.Method;
                        lr1.Descr = row.Descr;
                        lr1.IsActive = row.IsActive;
                        lr1.Ord = row.Ord;

                        lr1.Specs = new List<LoadRuleSpec>();
                        var lrs1 = new LoadRuleSpec();
                        lrs1.LoadRuleSpecId = row.LoadRuleSpecId;
                        lrs1.FileName = row.FileName;
                        lrs1.PathToFile = row.PathToFile;
                        lrs1.IsMain = row.IsMain;

                        lr1.Specs.Add(lrs1);
                        LoadRules.Add(lr1);
                    }
                    else
                    {
                        var lr2 = LoadRules.Where(x => x.LoadRuleId == row.LoadRuleId).Single();
                        var lrs2 = new LoadRuleSpec();
                        lrs2.LoadRuleSpecId = row.LoadRuleSpecId;
                        lrs2.FileName = row.FileName;
                        lrs2.PathToFile = row.PathToFile;
                        lrs2.IsMain = row.IsMain;
                        lr2.Specs.Add(lrs2);
                    }
                }
                                
                return true;
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                LoadRules = null;
                return false;
            }
        }

        public static bool GetRuleDataBytes(long loadRuleSpecId, out Byte[] data)
        {
            data = null;
            try
            {
                string conn;
                conn = System.Configuration.ConfigurationManager.ConnectionStrings["ToolsStoreConnectionString"].ToString();

                SqlCommand comm_unload_file = new SqlCommand();
                comm_unload_file.CommandType = System.Data.CommandType.StoredProcedure;
                comm_unload_file.CommandText = "SP_GET_RULE_DATA";
                comm_unload_file.Connection = new SqlConnection(conn);
                comm_unload_file.CommandTimeout = 1800;

                comm_unload_file.Parameters.Add("@LoadRuleSpecId", SqlDbType.BigInt, 8);

                comm_unload_file.Parameters["@LoadRuleSpecId"].Value = loadRuleSpecId;

                if (comm_unload_file.Connection.State != ConnectionState.Closed)
                    comm_unload_file.Connection.Close();

                comm_unload_file.Connection.Open();                
                data = (Byte[])comm_unload_file.ExecuteScalar();              
                comm_unload_file.Connection.Close();

                return true;
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                data = null;
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
                cmd.Parameters.Add("@Code", SqlDbType.NVarChar, 100);
                cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 250);
                cmd.Parameters.Add("@Ord", SqlDbType.Int);

                cmd.Parameters["@Code"].Value = code;
                cmd.Parameters["@Name"].Value = name;
                cmd.Parameters["@Ord"].Value = ord;

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

        public static bool LoadVat(int code, string name, bool isactive)
        {
            string conn;
            conn = System.Configuration.ConfigurationManager.ConnectionStrings["ToolsStoreConnectionString"].ToString();

            var cmd = new SqlCommand("SP_IM_VAT", new SqlConnection(conn));
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandTimeout = 3600;

            try
            {
                cmd.Parameters.Add("@Code", SqlDbType.Int);
                cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 100);
                cmd.Parameters.Add("@IsActive", SqlDbType.Bit);

                cmd.Parameters["@Code"].Value = code;
                cmd.Parameters["@Name"].Value = name;
                cmd.Parameters["@IsActive"].Value = isactive;

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
