namespace ToolsStore.Domain.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class CT_IMAGE
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CT_IMAGE()
        {
            RS_PRODUCT = new HashSet<RS_PRODUCT>();
        }

        [Key]
        public long ImageId { get; set; }

        public byte[] Data { get; set; }

        [StringLength(50)]
        public string MimeType { get; set; }

        [StringLength(300)]
        public string Name { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RS_PRODUCT> RS_PRODUCT { get; set; }
    }
}
