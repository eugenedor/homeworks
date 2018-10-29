using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ToolsStore.Domain.Entities;

namespace ToolsStore.WebUI.Models
{
    public class PriceViewModel
    {
        public RS_PRICE Price { get; set; }

        public IEnumerable<RS_PRODUCT> Products { get; set; }

        public IEnumerable<CT_VAT> Vats { get; set; }
    }
}