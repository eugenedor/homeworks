using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ToolsStoreService
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();

            string conn;
            conn = System.Configuration.ConfigurationManager.ConnectionStrings["ToolsStoreConnectionString"].ToString();
            //Log.write(conn);
            //FileManager.LoadFiles();
        }
    }
}
