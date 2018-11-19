using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToolsStore.Domain.Entities
{
    public class OrderContent
    {
        public long CartId { get; set; }

        public long OrderId { get; set; }

        public long ProductId { get; set; }

        public string ProductName { get; set; }

        public string EquipmentName { get; set; }

        public string CategoryName { get; set; }

        public long? PriceId { get; set; }

        public decimal? Price { get; set; }

        public int Quantity { get; set; }

        public decimal? Summ { get; set; }
    }
}
