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
        [Key]
        [HiddenInput(DisplayValue = false)]
        public long LoadRuleId { get; set; }

        [Required(ErrorMessage = "¬ведите код правила загрузки")]
        [StringLength(50)]
        public string Code { get; set; }

        [Required(ErrorMessage = "¬ведите наименование файла")]
        [StringLength(100)]
        public string FileName { get; set; }

        [Required(ErrorMessage = "”кажите признак активности")]
        public bool IsActive { get; set; }

        [Required(ErrorMessage = "¬ведите метод загрузки")]
        [StringLength(100)]
        public string MethodLoad { get; set; }

        [Required(ErrorMessage = "”кажите путь к xsd-файлу")]
        [StringLength(250)]
        public string PathToXsd { get; set; }

        [Required(ErrorMessage = "¬ведите наименование xsd-файла")]
        [StringLength(100)]
        public string XsdName { get; set; }

        [Required(ErrorMessage = "¬ведите описание")]
        [StringLength(250)]
        [DataType(DataType.MultilineText)]
        public string Descr { get; set; }

        [Required(ErrorMessage = "”кажите пор€док")]
        public int Ord { get; set; }
    }
}
