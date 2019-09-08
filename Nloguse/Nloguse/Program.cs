using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NLog;

namespace Nloguse
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                var txt = Console.ReadLine();
                LoggerHelper.Instance.Log.Info("info message");
                LoggerHelper.Instance.Log.Info($"{txt}");
                Console.ReadKey();

                //Logger log = LogManager.GetCurrentClassLogger();
                //log.Info("info message");
            }
            catch (Exception ex)
            {
                LoggerHelper.Instance.Log.Info($"{ex.Message}");
            }
        }
    }
}
