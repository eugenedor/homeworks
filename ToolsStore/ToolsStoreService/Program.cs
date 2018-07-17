using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;

namespace ToolsStoreService
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        static void Main()
        {
            //Application.EnableVisualStyles();
            //Application.SetCompatibleTextRenderingDefault(false);
            //Application.Run(new Form1());

            ServiceBase[] ServicesToRun;
            ServicesToRun = new ServiceBase[]
            {
                new ToolsStoreService()
            };
            ServiceBase.Run(ServicesToRun);
        }
    }
}
