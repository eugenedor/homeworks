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
            //Logger log = LogManager.GetCurrentClassLogger();
            //log.Info("info message");

            LoggerHelper.Instance.Log.Info("info message");
        }
    }
}
