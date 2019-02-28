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

        /// <summary>
        /// Создание директории
        /// </summary>
        public static void CreateDir(string dir)
        {
            try
            {
                if (!Directory.Exists(dir))
                    Directory.CreateDirectory(dir);
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                throw;
            }
        }

        /// <summary>
        /// Создание (выгрузка) файлов из правил
        /// </summary>
        public static void CreateFileByRule(long loadRuleSpecId, string pathName)
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

        /// <summary>
        /// Удаление файлов
        /// </summary>
        public static void DeleteFileByRule(string pathName)
        {
            try
            {
                if (File.Exists(pathName))
                    File.Delete(pathName);
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                throw;
            }
        }

        /// <summary>
        /// Удаление директории
        /// </summary>
        public static void DeleteDir(string dir)
        {
            try
            {
                if (Directory.Exists(dir))
                    Directory.Delete(dir);
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                throw;
            }
        }

    }
}
