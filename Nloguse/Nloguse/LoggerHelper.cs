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
        private static volatile LoggerHelper _instance;
        private static readonly object _syncRoot = new object();        

        LoggerHelper()
        {
            Log = LogManager.GetLogger(GetType().FullName);
        }

        public Logger Log { get; private set; }

        public static LoggerHelper Instance
        {
            get
            {
                if (_instance == null)
                {
                    lock (_syncRoot)
                    {
                        if (_instance == null)
                        {
                            _instance = new LoggerHelper();
                        }
                    }
                }
                return _instance;
            }
        }
    }
}
