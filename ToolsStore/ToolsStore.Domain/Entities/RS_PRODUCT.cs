namespace ToolsStore.Domain.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class RS_PRODUCT
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public RS_PRODUCT()
        {
            RS_CART = new HashSet<RS_CART>();
            RS_PRICE = new HashSet<RS_PRICE>();
        }

        [Key]
        public long ProductId { get; set; }

        public long EquipmentId { get; set; }

        public long ModelId { get; set; }

        public long? ImageId { get; set; }

        [Required]
        [StringLength(150)]
        public string Name { get; set; }

        [StringLength(2000)]
        public string Descr { get; set; }

        public decimal? Mass { get; set; }

        public decimal? Length { get; set; }

        public decimal? Width { get; set; }

        public decimal? Height { get; set; }

        [StringLength(50)]
        public string Color { get; set; }

        public int? Power { get; set; }

        [StringLength(250)]
        public string Kit { get; set; }

        public virtual CT_IMAGE CT_IMAGE { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RS_CART> RS_CART { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RS_PRICE> RS_PRICE { get; set; }

        public virtual SK_EQUIPMENT SK_EQUIPMENT { get; set; }

        public virtual SK_MODEL SK_MODEL { get; set; }
    }
}
