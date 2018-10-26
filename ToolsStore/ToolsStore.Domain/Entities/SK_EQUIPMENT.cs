namespace ToolsStore.Domain.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class SK_EQUIPMENT
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public SK_EQUIPMENT()
        {
            RS_PRODUCT = new HashSet<RS_PRODUCT>();
        }

        [Key]
        public long EquipmentId { get; set; }

        public long CategoryId { get; set; }

        [Required]
        [StringLength(50)]
        public string Code { get; set; }

        [Required]
        [StringLength(500)]
        public string Name { get; set; }

        [StringLength(500)]
        public string NameExtra { get; set; }

        public int? Ord { get; set; }

        public bool IsActive { get; set; }

        public virtual CT_CATEGORY CT_CATEGORY { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RS_PRODUCT> RS_PRODUCT { get; set; }
    }
}
