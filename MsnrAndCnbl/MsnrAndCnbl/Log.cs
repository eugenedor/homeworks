using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.IO;

namespace MsnrAndCnbl
{
    /// <summary>
    /// Summary description for writeLod
    /// </summary>
    public static class Log
    {
        /// <summary>
        /// Запись в лог (Данный метод записывает только сообщение)
        /// </summary>
        /// <param name="msg"></param>
        /// <returns></returns>
        public static bool WriteLog(string msg)
        {
            string nameFile = "log.txt";
            string path;

            path = Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location); //Path.GetDirectoryName(Environment.GetCommandLineArgs()[0]);

            path += "\\log\\";

            if (!Directory.Exists(path))
                Directory.CreateDirectory(path);

            try
            {
                //
                nameFile = DateTime.Now.ToString("yyyyMMdd") + "_" + nameFile;
                FileInfo fi = new FileInfo(path + nameFile);
                StreamWriter sw = fi.AppendText();
                if (!String.IsNullOrEmpty(msg))
                {
                    sw.WriteLine("{0} - {1}", DateTime.Now.ToString(), msg);
                }
                else
                {
                    sw.WriteLine(string.Empty);
                }
                sw.Close();
                sw.Dispose();
                return true;
            }
            catch
            {
                return false;
            }
        }

        public static void DelOldFiles(string path)
        {
            DirectoryInfo dinf = new DirectoryInfo(path);
            FileInfo[] finf = dinf.GetFiles();
            for (int i = 0; i < finf.Length; i++)
            {
                if (finf[i].CreationTime.AddDays(30) < DateTime.Today.Date)
                {
                    finf[i].Delete();
                }
            }

        }
    }
}
