namespace ToolsStore.Domain.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class RS_PRICE
    {
        [Key]
        public long PriceId { get; set; }

        public long ProductId { get; set; }

        public long VatId { get; set; }

        public decimal PriceWithVat { get; set; }

        public decimal? PriceWithoutVat { get; set; }

        public DateTime DateBegin { get; set; }

        public DateTime? DateEnd { get; set; }

        public virtual CT_VAT CT_VAT { get; set; }

        public virtual RS_PRODUCT RS_PRODUCT { get; set; }
    }
}
