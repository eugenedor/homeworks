using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Schema;
using System.Xml.Serialization;
using ToolsStoreService.log;

namespace ToolsStoreService.file
{
    public class FileCheck
    {
        #region Methods for GetFiles
        /// <summary>
        /// Кодировка xml-документа
        /// </summary>
        public static Encoding GetEncoding(FileWithParam fwp)
        {
            try
            {
                using (var strmReader = new StreamReader(fwp.FullName))
                {
                    using (var xmlReader = XmlReader.Create(strmReader))
                    {
                        if (!xmlReader.Read())
                        {
                            xmlReader.Close();
                            strmReader.Close();
                            Log.write("Ошибка чтения XML-документа (XmlReader).");
                            return null;
                        }

                        string encoding = xmlReader.GetAttribute("encoding");
                        Encoding en = Encoding.GetEncoding(encoding);
                        return en;
                    }
                }
            }
            catch (Exception ex)
            {
                fwp.ErrorMsg = ex.Message;
                return null;
            }
        }

        /// <summary>
        /// Проверка xml-документа на кодировку. Возвращаемое значение: true - успешно, false - ошибка.
        /// </summary>
        public static bool CheckEncoding(FileWithParam fwp)
        {
            try
            {
                Encoding en;
                string encodingXml = ConfigurationManager.AppSettings["encodingXml"] ?? ""; //можно перенести в правила загрузки

                if (fwp.Encoding != null)
                    en = fwp.Encoding;
                else
                    return false;

                return (encodingXml.ToLower() == en.HeaderName.ToLower());
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                return false;
            }
        }

        /// <summary>
        /// Валидация XML-документа. Возвращаемое значение: true - валидация прошла успешно, false - ошибка.
        /// </summary>
        public static bool CheckValidate(XmlDocument doc, string pathName, out string msgValidXml)
        {
            msgValidXml = null;
            try
            {
                if (File.Exists(pathName))
                {
                    XmlSchemaSet schemas = new XmlSchemaSet();
                    XmlTextReader txtReaderXsd = new XmlTextReader(pathName);
                    schemas.Add("", txtReaderXsd);
                    doc.Schemas.Add(schemas);
                    try
                    {
                        doc.Validate(null); //eventHandler
                        msgValidXml = "";
                    }
                    catch (XmlSchemaValidationException e)
                    {
                        msgValidXml = e.Message;
                    }
                    finally
                    {
                        txtReaderXsd.Close();
                    }
                }
                else
                {
                    msgValidXml = string.Format("Xsd-схема не найдена. Путь к схеме: \"{0}\"", pathName);
                }
                return string.IsNullOrEmpty(msgValidXml);
            }
            catch (Exception ex)
            {
                msgValidXml = ex.Message;
                return false;
            }
        }
        #endregion

        #region Checks LoadFile    
        /// <summary>
        /// Проверка корректности имени файла.
        /// </summary>
        public static bool CheckFileName(FileWithParam fwp)
        {
            if (!fwp.SignFileName)
                Log.write("Ошибка загрузки файла. Некорректное имя файла.");

            return fwp.SignFileName;
        }

        /// <summary>
        /// Проверка действительности данных
        /// </summary>
        public static bool CheckValidData(FileWithParam fwp)
        {
            if (!fwp.SignValidData)
                Log.write(string.Concat("Ошибка загрузки файла. ", fwp.ErrorMsg ?? "Недействительные данные."));

            return fwp.SignValidData;
        }

        /// <summary>
        /// Проверка корректности кодировки
        /// </summary>
        public static bool CheckEncodingXml(FileWithParam fwp)
        {
            string en = fwp.Encoding == null ? "" : (fwp.Encoding.HeaderName ?? "");
            string enXml = ConfigurationManager.AppSettings["encodingXml"] ?? "";

            if (!fwp.SignEncodingXml)
                Log.write(string.Format("Ошибка загрузки файла. Несоответствие кодировок в XML-документе: \"{0}\" и config: \"{1}\".", en.ToLower(), enXml.ToLower()));

            return fwp.SignEncodingXml;
        }

        /// <summary>
        /// Проверка валидации файла
        /// </summary>
        public static bool CheckValidXml(FileWithParam fwp)
        {
            if (!fwp.SignValidXml)
                Log.write(string.Concat("Ошибка загрузки файла.  Не найдена верна xsd-схема и метод загрузки. ", fwp.ErrorMsg ?? "").Trim());

            return fwp.SignValidXml;
        }

        /// <summary>
        /// Проверка xml-строки
        /// </summary>
        public static bool CheckXmlString(string xmlStr)
        {
            if (string.IsNullOrEmpty(xmlStr))
            {
                Log.write("Xml-строка является пустой.");
                return false;
            }
            else
            {
                return true;
            }
        }
        #endregion
    }
}
