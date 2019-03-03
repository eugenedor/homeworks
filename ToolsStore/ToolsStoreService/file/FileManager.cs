using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.IO;
using System.Globalization;
using System.Text.RegularExpressions;
using System.Xml;
using System.Xml.Schema;
using System.Xml.Serialization;
using ToolsStoreService.log;
using ToolsStoreService.abstr;
using ToolsStoreService.db;

namespace ToolsStoreService.file
{
    public class FileManager
    {
        private delegate bool LoadDelegate (FileWithParam f);        

        /// <summary>
        /// Загрузка файлов
        /// </summary>
        public static void LoadFiles()
        {
            List<FileWithParam> fwps;
            DateTime currentDate = DateTime.Now;
            int count = 0, successCount = 0, errorCount = 0;
            string archivePath, trashPath, addPath = "", signGradationStr, cultureName = "en-US";
            bool signGradation;

            try
            {
                //коллекция файлов с параметрами
                fwps = GetFiles();

                if (fwps == null)
                    return;

                if (fwps.Count > 0)
                {
                    Log.write("Начало загрузки");
                    Log.write(string.Format("Всего файлов: {0}.", fwps.Count));

                    //архивный каталог
                    if (!DataBaseManager.GetSettingValue("archivePath", out archivePath))
                        return;

                    //каталог с ошибками
                    if (!DataBaseManager.GetSettingValue("trashPath", out trashPath))
                        return;

                    //признак градации
                    if (!DataBaseManager.GetSettingValue("signGradation", out signGradationStr))
                        return;
                    Boolean.TryParse(signGradationStr, out signGradation);

                    if (signGradation)
                    {
                        cultureName = ConfigurationManager.AppSettings["cultureName"] ?? "en-US"; //региональные параметры

                        addPath = currentDate.ToString("yyyy") + "\\" 
                                + currentDate.ToString("MM_MMMM", CultureInfo.GetCultureInfo(cultureName)) + "\\" 
                                + currentDate.ToString("yyyy_MM_dd");

                        archivePath = Path.Combine(archivePath, addPath);
                        trashPath = Path.Combine(trashPath, addPath);
                    }

                    //прохождение по списку файлов FileWithParam
                    foreach (FileWithParam fwp in fwps.OrderBy(x => x.Order).ThenBy(x => x.Date))
                    {
                        count++;
                        Log.write(string.Format("{0}. Файл {1}", count.ToString(), fwp.Name));
                        Log.write("Файл обрабатывается.");
                        if (LoadFile(fwp))
                        {
                            successCount++;
                            if (successCount == 1) // создание директории для первого загруженного файла
                                Utils.CreateDir(archivePath);
                            Log.write("Файл загружен.");
                            fwp.MoveTo(archivePath);
                        }
                        else
                        {
                            errorCount++;
                            if (errorCount == 1) // создание директории для первого незагруженного файла
                                Utils.CreateDir(trashPath);
                            Log.write("Файл не загружен.");
                            fwp.MoveTo(trashPath);
                        }
                        GC.Collect(3); //сборка мусора для третьего поколения
                    }
                    Log.write(string.Format("Итого: загружено: {0}; не загружено {1}.", successCount, errorCount));
                    Log.write("Конец загрузки." + Environment.NewLine);
                }
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
            }
        }

        /// <summary>
        /// Функция, возвращающая список файлов с параметрами
        /// </summary>
        /// <returns></returns>
        public static List<FileWithParam> GetFiles()
        {
            List<FileWithParam> fwps;
            List<LoadRule> lrs;
            int cnt = 0;

            //шаблоны
            string patterndate = @"(19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])";
            string patternnum = @"\d+";
            string pattern = patterndate + "_" + patternnum;

            try
            {
                fwps = new List<FileWithParam>();

                string filePath;
                if (!DataBaseManager.GetSettingValue("filePath", out filePath))
                    return fwps;

                Utils.CreateDir(filePath);

                DirectoryInfo dir = new DirectoryInfo(filePath);
                List<FileInfo> files = dir.GetFiles().ToList();

                if (files.Count == 0)
                    return fwps;

                //правила загрузки
                lrs = Utils.GetLoadRules();

                if (lrs == null)
                {
                    Log.write("Список правил загрузок пустой!");
                    return fwps;
                }

                if (lrs.Where(x => x.IsActive && !(x.Pattern == null || x.Pattern.Equals(""))).Count() == 0)
                {
                    Log.write("Список правил загрузок некорректен!");
                    return fwps;
                }

                //создание директорий и запись файлов на диск по правилам загрузки
                if (!CreateDirAndFilesByRules(lrs))
                    return fwps;

                //прохождение по списку файлов FileInfo
                foreach (FileInfo file in files)
                {
                    FileWithParam fwp = new FileWithParam();
                    fwp.FullName = file.FullName;
                    fwp.Name = file.Name;

                    fwp.SignFileName = false;
                    fwp.SignEncodingXml = false;
                    fwp.SignValidData = false;
                    fwp.SignValidXml = false;
                    fwp.ErrorMsg = null;

                    cnt = 0;
                    foreach (LoadRule lr in lrs.Where(x => x.IsActive && !(x.Pattern == null || x.Pattern.Equals(""))).OrderBy(x => x.Ord))
                    {
                        if (Regex.IsMatch(fwp.Name, "^" + lr.Pattern + "$", RegexOptions.IgnoreCase))
                        {
                            cnt++;
                            if (cnt == 1) //первое совпадение в цикле
                            {
                                //корректное имя файла
                                fwp.SignFileName = true;

                                //кодировка xml-файла
                                fwp.Encoding = FileCheck.GetEncoding(fwp);
                                if (fwp.Encoding == null)
                                {
                                    fwp.SignValidData = false; //ошибка действительности данных - прекращение поиска правил
                                    break;
                                }

                                //проверка кодировки
                                fwp.SignEncodingXml = FileCheck.CheckEncoding(fwp);
                                if (!fwp.SignEncodingXml) //Некорректная кодировка
                                {
                                    fwp.SignValidData = true; //не является ошибкой действительности данных
                                    break;
                                }
                            }

                            XmlDocument xnldoc = new XmlDocument();
                            StreamReader strmrdr = new StreamReader(fwp.FullName, System.Text.Encoding.GetEncoding(fwp.Encoding.HeaderName));
                            try
                            {
                                xnldoc.Load(strmrdr);
                                fwp.SignValidData = true;

                                string errMsg;
                                string pathName = lr.Specs.Where(x => x.IsMain).Select(x => x.PathName).First();
                                //валидация xml
                                if (FileCheck.CheckValidate(xnldoc, pathName, out errMsg)) //успешная валдация - правило найдено - прекращение поиска правил
                                {
                                    fwp.CodeRule = lr.Code;
                                    fwp.MethodLoad = lr.Method;
                                    fwp.SignValidXml = true;
                                    fwp.ErrorMsg = null;
                                    fwp.Order = lr.Ord;
                                    break;
                                }
                                else
                                {
                                    fwp.SignValidXml = false;
                                    fwp.ErrorMsg = string.IsNullOrEmpty(fwp.ErrorMsg) ? string.Concat(lr.Pattern, ": ", errMsg) : string.Concat(fwp.ErrorMsg, " ", string.Concat(lr.Pattern, ": ", errMsg));
                                }
                            }
                            catch (Exception ex)
                            {
                                //действительность данных
                                fwp.SignValidData = false;
                                fwp.ErrorMsg = ex.Message;
                                break;
                            }
                            finally
                            {
                                strmrdr.Close();
                            }
                        }
                    }

                    //шаблон: дата
                    if (fwp.SignFileName)
                    {                        
                        if (Regex.IsMatch(fwp.Name, patterndate, RegexOptions.IgnoreCase))
                        {
                            Match match = Regex.Match(fwp.Name, patterndate, RegexOptions.IgnoreCase);
                            string dt = match.Value;
                            fwp.Date = DateTime.ParseExact(dt, "yyyyMMdd", CultureInfo.InvariantCulture);
                        }
                        else
                        {
                            fwp.Date = new DateTime(2999, 12, 31);
                        }
                    }
                    else
                    {
                        fwp.Date = new DateTime(2999, 12, 31);
                    }
                    fwps.Add(fwp);
                }

                //удаление файлов с диска и директорий по правилам загрузки
                DeleteFilesAndDirByRules(lrs);

                return fwps;
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                return null;
            }
        }

        /// <summary>
        /// Cоздание директорий и запись файлов на диск по правилам загрузки
        /// </summary>
        private static bool CreateDirAndFilesByRules(List<LoadRule> lrs)
        {
            try
            {
                foreach (LoadRule lr in lrs)
                {
                    if (lr == null || lr.Specs == null)
                        continue;

                    foreach (LoadRuleSpec s in lr.Specs)
                    {
                        Utils.CreateDir(s.PathToFile);
                        Utils.CreateFileByRule(s.LoadRuleSpecId, s.PathName);
                    }
                }
                return true;
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                return false;
            }
        }

        /// <summary>
        /// Удаление файлов с диска и директорий по правилам загрузки
        /// </summary>
        private static bool DeleteFilesAndDirByRules(List<LoadRule> lrs)
        {
            try
            {
                //delete file
                foreach (LoadRule lr in lrs)
                {
                    if (lr == null || lr.Specs == null)
                        continue;
                    foreach (LoadRuleSpec s in lr.Specs)
                        Utils.DeleteFileByRule(s.PathName);
                }

                //delete directory
                foreach (LoadRule lr in lrs)
                {
                    if (lr == null || lr.Specs == null)
                        continue;
                    foreach (LoadRuleSpec s in lr.Specs)
                        Utils.DeleteDir(s.PathToFile);
                }

                return true;
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                return false;
            }
        }

        private static bool LoadFile(FileWithParam fwp)
        {
            //проверка
            //корректности имени файла
            if (!FileCheck.CheckFileName(fwp)) return false;
            //действительности данных
            if (!FileCheck.CheckValidData(fwp)) return false;
            //корректности кодировки
            if (!FileCheck.CheckEncodingXml(fwp)) return false;
            //валидации файла
            if (!FileCheck.CheckValidXml(fwp)) return false;

            try
            {
                bool loaded = false;
                
                //словарь вариантов загрузок: ключ и значение (цель делегата)
                Dictionary<string, LoadDelegate> oper = new Dictionary<string, LoadDelegate>
                {
                    { "loadcategory", LoadCategory },
                    { "loadvat", LoadVat },
                };

                if (!oper.ContainsKey(fwp.MethodLoad.ToLower()))
                    loaded = LoadError(fwp);

                loaded = oper[fwp.MethodLoad.ToLower()](fwp);

                //switch (fwp.MethodLoad.ToLower())
                //{
                //    case "loadcategory":
                //        loaded = LoadCategory(fwp);
                //        break;
                //    case "loadvat":
                //        loaded = LoadVat(fwp);
                //        break;
                //    default:
                //        loaded = LoadError(fwp);
                //        break;
                //}

                return loaded;
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                return false;
            }
        }

        /// <summary>
        /// Ошибка загрузки файла
        /// </summary>
        private static bool LoadError(FileWithParam fwp)
        {
            Log.write("Ошибка загрузки файла. Некорректный код.");
            return false;
        }

        /// <summary>
        /// Загрузка. Получение xml-строки и корневого узла
        /// </summary>
        private static bool Load(FileWithParam fwp, string xAttr, out XmlRootAttribute xRoot, out string xmlStr)
        {
            xRoot = new XmlRootAttribute();
            xmlStr = "";
            try
            {
                //xml-документ
                XmlDocument xDoc = new XmlDocument();
                StreamReader sr = new StreamReader(fwp.FullName, Encoding.GetEncoding(fwp.Encoding.HeaderName));
                try
                {
                    xDoc.Load(sr);
                }
                catch (Exception ex)
                {
                    Log.write(ex.Message);
                    return false;
                }
                finally
                {
                    sr.Close();
                }

                //xml-корень
                xRoot.ElementName = xAttr;
                xRoot.IsNullable = true;

                //xml-string
                XmlNode xNode = xDoc.SelectSingleNode(xAttr);
                xmlStr = xNode.OuterXml;

                return true;
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                return false;
            }
        }

        /// <summary>
        /// Загузка. XmlSerializer и TextReader
        /// </summary>
        private static bool Load(FileWithParam fwp, string xAttr, Type type, out XmlSerializer xSer, out TextReader reader)
        {
            XmlRootAttribute xRoot;
            string xmlStr;
            xSer = null;
            reader = null;

            //xml-узел, xml-строка
            if (!Load(fwp, xAttr, out xRoot, out xmlStr)) return false;

            //проверка xml-строки
            if (!FileCheck.CheckXmlString(xmlStr)) return false;

            xSer = new XmlSerializer(type, xRoot);
            reader = new StringReader(xmlStr);
            return true;
        }

        /// <summary>
        /// Загрузка объекта
        /// </summary>
        private static bool Load(ILoadManager ilmngr)
        {
            if (ilmngr == null)
                return false;

            return ilmngr.Load();
        }

        /// <summary>
        /// Загрузка категории
        /// </summary>
        private static bool LoadCategory(FileWithParam fwp)
        {
            XmlSerializer xSer;
            TextReader reader;
            if (!Load(fwp, "packet", typeof(clss.category.packet), out xSer, out reader))
                return false;
            try
            {
                ILoadManager ilmngr = xSer.Deserialize(reader) as clss.category.packet;
                return Load(ilmngr);
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                return false;
            }
            finally
            {
                reader.Close();
            }
        }

        /// <summary>
        /// Загрузка НДС
        /// </summary>
        private static bool LoadVat(FileWithParam fwp)
        {
            XmlSerializer xSer;
            TextReader reader;
            if (!Load(fwp, "packet", typeof(clss.vat.packet), out xSer, out reader))
                return false;
            try
            {
                ILoadManager ilmngr = xSer.Deserialize(reader) as clss.vat.packet;
                return Load(ilmngr);
            }
            catch (Exception ex)
            {
                Log.write(ex.Message);
                return false;
            }
            finally
            {
                reader.Close();
            }
        }

    }
}