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

        [Display(Name = "Код правила загрузки")]
        [Required(ErrorMessage = "Введите код правила загрузки")]
        [StringLength(50)]
        public string Code { get; set; }

        [Display(Name = "Паттерн")]
        [Required(ErrorMessage = "Введите наименование файла")]
        [StringLength(100)]
        public string Pattern { get; set; }

        [Display(Name = "Метод")]
        [Required(ErrorMessage = "Введите метод загрузки")]
        [StringLength(100)]
        public string Method { get; set; }

        [Display(Name = "Описание")]
        [Required(ErrorMessage = "Введите описание")]
        [StringLength(250)]
        [DataType(DataType.MultilineText)]
        public string Descr { get; set; }

        [Display(Name = "Признак активности")]
        [Required(ErrorMessage = "Укажите признак активности")]
        public bool IsActive { get; set; }

        [Display(Name = "Порядок")]
        [Required(ErrorMessage = "Укажите порядок")]
        [Range(1, 1000)]
        public int Ord { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<MT_LOAD_RULE_SPEC> MT_LOAD_RULE_SPEC { get; set; }
    }
}
