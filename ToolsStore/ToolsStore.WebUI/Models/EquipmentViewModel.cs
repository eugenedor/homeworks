using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ToolsStore.Domain.Entities;

namespace ToolsStore.WebUI.Models
{
    public class EquipmentViewModel
    {
        public SK_EQUIPMENT Equipment { get; set; }

        public IEnumerable<CT_CATEGORY> Categories { get; set; }
    }
}