namespace ToolsStore.Domain.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class RS_PRICE
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public RS_PRICE()
        {
            RS_CART = new HashSet<RS_CART>();
        }

        [Key]
        public long PriceId { get; set; }

        public long ProductId { get; set; }

        public long VatId { get; set; }

        public decimal PriceWithVat { get; set; }

        public decimal? PriceWithoutVat { get; set; }

        [DisplayFormat(DataFormatString = "{0:dd.MM.yyyy HH:mm:ss}")]
        public DateTime DateBegin { get; set; }

        [DisplayFormat(DataFormatString = "{0:dd.MM.yyyy HH:mm:ss}")]
        public DateTime? DateEnd { get; set; }

        public virtual CT_VAT CT_VAT { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RS_CART> RS_CART { get; set; }

        public virtual RS_PRODUCT RS_PRODUCT { get; set; }
    }
}
