using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ToolsStoreService.file;
using ToolsStoreService.log;
using ToolsStoreService.db;
using ToolsStoreService.abstr;

namespace ToolsStoreService.clss.category
{
    public partial class packet : ILoadManager
    {
        public bool Load()
        {
            try
            {
                if (rec == null)
                {
                    Log.write("Ошибка. Массив записей в пакете xml-файла не удалось инициализировать.");
                    return false;
                }

                foreach (packetRec pcktRec in rec)
                {
                    if (pcktRec == null)
                    {
                        Log.write("Ошибка. Запись в пакете xml-файла не удалось инициализировать.");
                        return false;
                    }

                    if (!DataBaseManager.LoadCategory(pcktRec.Code, pcktRec.Name, pcktRec.Ord))
                        return false;
                }
                return true;
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                return false;
            }
        }
    }
}
