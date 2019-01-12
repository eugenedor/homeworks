using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

namespace ToolsStore.WebUI.Models
{
    public class StreamWithName
    {
        public string FileName { get; set; }
        public MemoryStream Stream { get; set; }
    }
}