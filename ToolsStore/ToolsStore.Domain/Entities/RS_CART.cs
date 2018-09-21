namespace ToolsStore.Domain.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class RS_CART
    {
        [Key]
        public long CartId { get; set; }

        public long OrderId { get; set; }

        public long ProductId { get; set; }

        public long? PriceId { get; set; }

        public int Quantity { get; set; }

        public virtual RS_ORDER RS_ORDER { get; set; }

        public virtual RS_PRICE RS_PRICE { get; set; }

        public virtual RS_PRODUCT RS_PRODUCT { get; set; }
    }
}
