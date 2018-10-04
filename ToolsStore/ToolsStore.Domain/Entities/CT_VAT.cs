namespace ToolsStore.Domain.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class CT_VAT
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CT_VAT()
        {
            RS_PRICE = new HashSet<RS_PRICE>();
        }

        [Key]
        public long VatId { get; set; }

        public int Code { get; set; }

        [Required]
        [StringLength(100)]
        public string Name { get; set; }

        public bool Rem { get; set; }

        [Display(Name = "Дата загрузки")]
        [DisplayFormat(DataFormatString = "{0:dd.MM.yyyy HH:mm:ss}")]
        public DateTime? DateLoad { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RS_PRICE> RS_PRICE { get; set; }
    }
}
