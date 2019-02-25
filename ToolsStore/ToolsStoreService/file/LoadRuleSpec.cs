using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToolsStoreService.file
{
    /// <summary>
    /// Правила загрузки (специальные)
    /// </summary>
    public class LoadRuleSpec
    {
        /// <summary>
        /// Идентификатор правила загрузки (специальный)
        /// </summary>
        public long LoadRuleSpecId { get; set; }

        /// <summary>
        /// Наименование файла
        /// </summary>
        public string FileName { get; set; }

        /// <summary>
        /// Путь к файлам
        /// </summary>
        public string PathToFile { get; set; }

        /// <summary>
        /// Путь к файлам (расширенный)
        /// </summary>
        public string PathName { get; set; }

        /// <summary>
        /// Основной из файлов правила загрузки
        /// </summary>
        public bool IsMain { get; set; }
    }
}
