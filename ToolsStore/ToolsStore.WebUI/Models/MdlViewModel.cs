using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ToolsStore.Domain.Entities;

namespace ToolsStore.WebUI.Models
{
    public class MdlViewModel
    {
        public SK_MODEL Mdl { get; set; }

        public IEnumerable<CT_BRAND> Brand { get; set; }
    }
}