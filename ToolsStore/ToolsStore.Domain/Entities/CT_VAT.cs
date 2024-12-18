using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;
using System.Web.Mvc;

namespace ToolsStore.Domain.Entities
{
    public partial class CT_VAT
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CT_VAT()
        {
            RS_PRICE = new HashSet<RS_PRICE>();
        }

        [Key]
        [HiddenInput(DisplayValue = false)]
        public long VatId { get; set; }

        [Display(Name = "��� ���")]
        [Required(ErrorMessage = "������� ��� ���������")]
        public int Code { get; set; }

        [StringLength(100)]
        [Display(Name = "������������")]
        [Required(ErrorMessage = "������� ������������")]
        public string Name { get; set; }

        [Display(Name = "������� ��������")]
        public bool IsActive { get; set; }

        [Display(Name = "���� ��������")]
        [DisplayFormat(DataFormatString = "{0:dd.MM.yyyy HH:mm:ss}")]
        public DateTime? DateLoad { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<RS_PRICE> RS_PRICE { get; set; }
    }
}
