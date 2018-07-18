using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace ToolsStoreService.file
{
    public class FileWithParam
    {
        /// <summary>
        /// Полный путь к файлу
        /// </summary>
        public string FullName { get; set; }

        /// <summary>
        /// Наименование файла
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// Дата в названии файла если есть, иначе по умолчанию дата
        /// </summary>
        public DateTime Date { get; set; }

        /// <summary>
        /// Кодировка xml
        /// </summary>
        public Encoding Encoding { get; set; }

        /// <summary>
        /// Признак корректности имени файла
        /// </summary>
        public bool SignFileName { get; set; }

        /// <summary>
        /// Признак корректности xml-кодировки
        /// </summary>
        public bool SignEncodingXml { get; set; }

        /// <summary>
        /// Признак действительных данных
        /// </summary>
        public bool SignValidData { get; set; }

        /// <summary>
        /// Признак валидации
        /// </summary>
        public bool SignValidXml { get; set; }

        /// <summary>
        /// Сообщение об ошибке
        /// </summary>
        public string ErrorMsg { get; set; }

        /// <summary>
        /// Код загрузки по xsd-схеме
        /// </summary>
        public string CodeRule { get; set; }

        /// <summary>
        /// Метод загрузки
        /// </summary>
        public string MethodLoad { get; set; }

        /// <summary>
        /// Порядок
        /// </summary>
        public int Order { get; set; }

        /// <summary>
        /// Перенос файла в указанную директорию
        /// </summary>
        public void MoveTo(string dir)
        {
            string destination = Path.Combine(dir, Name);
            if (File.Exists(destination))
                File.Delete(destination);

            File.Move(FullName, destination);
        }
    }
}
