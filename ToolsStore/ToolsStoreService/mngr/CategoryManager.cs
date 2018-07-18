using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ToolsStoreService.clss.category;
using ToolsStoreService.file;
using ToolsStoreService.log;
//using ToolsStoreService.db;

namespace ToolsStoreService.mngr
{
    class CategoryManager
    {
        public static bool Load(packet pck, FileWithParam fwp)
        {
            try
            {
                if (pck == null)
                {
                    Log.write("Ошибка. Пакет xml-файла не удалось инициализировать.");
                    return false;
                }

                if (pck.rec == null)
                {
                    Log.write("Ошибка. Массив записей в пакете xml-файла не удалось инициализировать.");
                    return false;
                }

                foreach (packetRec rec in pck.rec)
                {
                    if (rec == null)
                    {
                        Log.write("Ошибка. Запись в пакете xml-файла не удалось инициализировать.");
                        return false;    
                    }

                    //if (!DataBaseManager.LoadCategory(rec.Code, rec.Name, rec.Ord, fwp.Name))
                    //    return false;                    
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
