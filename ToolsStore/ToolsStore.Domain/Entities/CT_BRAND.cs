using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;
using System.Web.Mvc;

namespace ToolsStore.Domain.Entities
{
    public partial class CT_BRAND
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CT_BRAND()
        {
            SK_MODEL = new HashSet<SK_MODEL>();
        }

        [Key]
        [HiddenInput(DisplayValue = false)]
        public long BrandId { get; set; }

        [Display(Name = "��� ������")]
        [Required(ErrorMessage = "������� ��� ������")]
        [StringLength(100)]
        public string Code { get; set; }

        [StringLength(500)]
        [Display(Name = "������������")]
        [Required(ErrorMessage = "������� ������������")]
        public string Name { get; set; }

        [Display(Name = "���� ��������")]
        [DisplayFormat(DataFormatString = "{0:dd.MM.yyyy HH:mm:ss}")]
        public DateTime? DateLoad { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<SK_MODEL> SK_MODEL { get; set; }
    }
}
