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
            RS_ORDER_CONTENT = new HashSet<RS_ORDER_CONTENT>();
        }

        [Key]
        public long PriceId { get; set; }

        public long ProductId { get; set; }

        public long VatId { get; set; }

        public decimal PriceWithVat { get; set; }

        public decimal? PriceWithoutVat { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy.MM.dd}", ApplyFormatInEditMode = true)]
        public DateTime DateBegin { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy.MM.dd}", ApplyFormatInEditMode = true)]
        public DateTime? DateEnd { get; set; }

        public virtual CT_VAT CT_VAT { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RS_ORDER_CONTENT> RS_ORDER_CONTENT { get; set; }

        public virtual RS_PRODUCT RS_PRODUCT { get; set; }
    }
}
