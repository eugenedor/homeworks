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
            Logger log = LogManager.GetCurrentClassLogger();

            log.Trace("trace message");
            log.Debug("debug message");
            log.Info("info message");
            log.Warn("warn message");
            log.Error("error message");
            log.Fatal("fatal message");
        }
    }
}
