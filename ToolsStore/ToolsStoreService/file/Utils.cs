using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using ToolsStoreService.log;

namespace ToolsStoreService.file
{
    public static class Utils
    {
        /// <summary>
        /// Получить список правил
        /// </summary>
        /// <returns></returns>
        public static List<LoadRule> GetLoadRules()
        {
            try
            {
                string pathToXsd = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);

                LoadRule lrCategory = new LoadRule()
                {
                    Code = "Category",
                    FileName = "Category.xml",
                    IsActive = true,
                    MethodLoad = "LoadCategory",
                    Order = 1,
                    PathToXsd = pathToXsd + "\\xsd",
                    XsdName = "Category.xsd"
                };

                LoadRule lrVat = new LoadRule()
                {
                    Code = "Vat",
                    FileName = "Vat.xml",
                    IsActive = true,
                    MethodLoad = "LoadVat",
                    Order = 2,
                    PathToXsd = pathToXsd + "\\xsd",
                    XsdName = "Vat.xsd"
                };

                List<LoadRule> loadrules = new List<LoadRule>();
                loadrules.Add(lrCategory);
                loadrules.Add(lrVat);

                return loadrules;
            }
            catch
            {
                Log.write("Ошибка инициализации правил загрузки");
                return null;
            }
        }
    }
}
