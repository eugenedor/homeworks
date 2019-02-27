using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using ToolsStoreService.log;
using ToolsStoreService.db;

namespace ToolsStoreService.file
{
    public static class Utils
    {
        /// <summary>
        /// Получить список правил
        /// </summary>
        public static List<LoadRule> GetLoadRules()
        {
            try
            {
                string pathToXsd = Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location);
                List<LoadRule> loadrules = new List<LoadRule>();

                if (!DataBaseManager.GetLoadRule(pathToXsd, out loadrules))
                    throw new Exception("Ошибка инициализации правил загрузки");

                return loadrules;
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                return null;
            }
        }

        public static void CreateData(long loadRuleSpecId, string pathName)
        {
            Byte[] data;
            try
            {
                if (!DataBaseManager.GetRuleDataBytes(loadRuleSpecId, out data))
                    throw new Exception("Ошибка данных");

                using (var fstream = new FileStream(pathName, System.IO.FileMode.OpenOrCreate))
                {
                    fstream.Write(data, 0, data.Length);
                }
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                throw;
            }
        }
    }
}
