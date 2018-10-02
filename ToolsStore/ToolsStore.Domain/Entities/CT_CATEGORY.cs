using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;
using System.Web.Mvc;

namespace ToolsStore.Domain.Entities
{
    public partial class CT_CATEGORY
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CT_CATEGORY()
        {
            SK_EQUIPMENT = new HashSet<SK_EQUIPMENT>();
        }

        [Key]
        [HiddenInput(DisplayValue = false)]
        public long CategoryId { get; set; }

        [Display(Name = "��� ���������")]
        [Required(ErrorMessage = "������� ��� ���������")]
        [StringLength(100)]
        public string Code { get; set; }

        [StringLength(250)]
        [Display(Name = "������������")]
        [Required(ErrorMessage = "������� ������������")]
        public string Name { get; set; }

        [Display(Name = "�������")]
        public int? Ord { get; set; }

        [Display(Name = "���� ��������")]
        [DisplayFormat(DataFormatString = "{0:dd.MM.yyyy HH:mm:ss}")]
        public DateTime? DateLoad { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<SK_EQUIPMENT> SK_EQUIPMENT { get; set; }
    }
}
