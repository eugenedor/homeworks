using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NLog;

namespace Nloguse
{
    public class LoggerHelper
    {
        private static readonly Lazy<LoggerHelper> _instance = new Lazy<LoggerHelper>(() => new LoggerHelper());        

        LoggerHelper()
        {
            Log = LogManager.GetLogger(GetType().FullName);
        }

        public Logger Log { get; private set; }

        public static LoggerHelper Instance
        {
            get
            {
                return _instance.Value;
            }
        }
    }
}
