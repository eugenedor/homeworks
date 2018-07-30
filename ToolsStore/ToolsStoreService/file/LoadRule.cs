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
        /// Код
        /// </summary>
        public string Code { get; set; }

        /// <summary>
        /// Наименование файла
        /// </summary>
        public string FileName { get; set; }

        /// <summary>
        /// Признак активности
        /// </summary>
        public bool IsActive { get; set;}

        /// <summary>
        /// Метод загрузки
        /// </summary>
        public string MethodLoad { get; set; }

        /// <summary>
        /// Путь к файлам xsd-схем
        /// </summary>
        public string PathToXsd { get; set; }

        /// <summary>
        /// Наименование xsd-файла
        /// </summary>
        public string XsdName { get; set; }

        /// <summary>
        /// Описание
        /// </summary>
        public string Description { get; set; }

        /// <summary>
        /// Порядок
        /// </summary>
        public int Order { get; set; }
    }
}
