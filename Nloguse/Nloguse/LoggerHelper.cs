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
        // Поле должно быть volatile!
        private static volatile LoggerHelper _instance;
        private static readonly object _syncRoot = new object();

        public Logger Log { get; private set; }

        LoggerHelper()
        {
            Log = LogManager.GetLogger(GetType().FullName);
        }

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
