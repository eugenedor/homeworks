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


    }
}
