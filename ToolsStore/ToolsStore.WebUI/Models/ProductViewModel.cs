using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ToolsStore.Domain.Entities;

namespace ToolsStore.WebUI.Models
{
    public class ProductViewModel
    {
        public RS_PRODUCT Product { get; set; }

        //public CT_IMAGE Image { get; set; }

        public IEnumerable<SK_EQUIPMENT> Equipments { get; set; }

        public IEnumerable<CT_BRAND> Brands { get; set; }

        public IEnumerable<SK_MODEL> Models { get; set; }
    }
}