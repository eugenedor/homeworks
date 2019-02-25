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
                        new System.Data.Common.DataColumnMapping("PathName", "PathName"),
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
                        lrs1.PathName = row.PathName;
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
                        lrs2.PathName = row.PathName;
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

        public static bool LoadVat(int code, string name, bool isactive)
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
                cmd.Parameters.Add("@isactive", SqlDbType.Bit);

                cmd.Parameters["@code"].Value = code;
                cmd.Parameters["@name"].Value = name;
                cmd.Parameters["@isactive"].Value = isactive;

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
