using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToolsStoreService.file
{
    /// <summary>
    /// Правила загрузки
    /// </summary>
    public class LoadRule
    {
        /// <summary>
        /// Идентификатор правила загрузки
        /// </summary>
        public long LoadRuleId { get; set; }

        /// <summary>
        /// Код
        /// </summary>
        public string Code { get; set; }

        /// <summary>
        /// Шаблон
        /// </summary>
        public string Pattern { get; set; }

        /// <summary>
        /// Метод загрузки
        /// </summary>
        public string Method { get; set; }

        /// <summary>
        /// Описание
        /// </summary>
        public string Descr { get; set; }

        /// <summary>
        /// Признак активности
        /// </summary>
        public bool IsActive { get; set; }

        /// <summary>
        /// Порядок
        /// </summary>
        public int Ord { get; set; }

        /// <summary>
        /// Список специальных правил загрузок
        /// </summary>
        public List<LoadRuleSpec> Specs { get; set; }
}
}
