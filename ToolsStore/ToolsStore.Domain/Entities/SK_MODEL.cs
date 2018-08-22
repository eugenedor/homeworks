namespace ToolsStore.Domain.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class SK_MODEL
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public SK_MODEL()
        {
            RS_PRODUCT = new HashSet<RS_PRODUCT>();
        }

        [Key]
        public long ModelId { get; set; }

        public long BrandId { get; set; }

        public long Code { get; set; }

        [Required]
        [StringLength(500)]
        public string Name { get; set; }

        public virtual CT_BRAND CT_BRAND { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RS_PRODUCT> RS_PRODUCT { get; set; }
    }
}
