using System;
using System.Collections.Generic;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace ToolsStore.Domain.Entities
{
    public partial class MT_LOAD_RULE
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public MT_LOAD_RULE()
        {
            MT_LOAD_RULE_SPEC = new HashSet<MT_LOAD_RULE_SPEC>();
        }

        [Key]
        [HiddenInput(DisplayValue = false)]
        public long LoadRuleId { get; set; }

        [Display(Name = "��� ������� ��������")]
        [Required(ErrorMessage = "������� ��� ������� ��������")]
        [StringLength(50)]        
        public string Code { get; set; }

        [Display(Name = "������������ �����")]
        [Required(ErrorMessage = "������� ������������ �����")]
        [StringLength(100)]
        public string FileName { get; set; }

        [Display(Name = "������� ����������")]
        [Required(ErrorMessage = "������� ������� ����������")]
        public bool IsActive { get; set; }

        [Display(Name = "����� ��������")]
        [Required(ErrorMessage = "������� ����� ��������")]
        [StringLength(100)]
        public string MethodLoad { get; set; }

        [Display(Name = "���� � xsd-�����")]
        [Required(ErrorMessage = "������� ���� � xsd-�����")]
        [StringLength(250)]
        public string PathToXsd { get; set; }

        [Display(Name = "������������ xsd-�����")]
        [Required(ErrorMessage = "������� ������������ xsd-�����")]
        [StringLength(100)]
        public string XsdName { get; set; }

        [Display(Name = "��������")]
        [Required(ErrorMessage = "������� ��������")]
        [StringLength(250)]
        [DataType(DataType.MultilineText)]
        public string Descr { get; set; }

        [Display(Name = "�������")]
        [Required(ErrorMessage = "������� �������")]
        [Range(1, 1000)]
        public int Ord { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<MT_LOAD_RULE_SPEC> MT_LOAD_RULE_SPEC { get; set; }
    }
}
