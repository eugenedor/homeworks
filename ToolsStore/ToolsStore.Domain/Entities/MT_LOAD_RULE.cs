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

        [Display(Name = "Код правила загрузки")]
        [Required(ErrorMessage = "Введите код правила загрузки")]
        [StringLength(50)]        
        public string Code { get; set; }

        [Display(Name = "Наименование файла")]
        [Required(ErrorMessage = "Введите наименование файла")]
        [StringLength(100)]
        public string FileName { get; set; }

        [Display(Name = "Признак активности")]
        [Required(ErrorMessage = "Укажите признак активности")]
        public bool IsActive { get; set; }

        [Display(Name = "Метод загрузки")]
        [Required(ErrorMessage = "Введите метод загрузки")]
        [StringLength(100)]
        public string MethodLoad { get; set; }

        [Display(Name = "Путь к xsd-файлу")]
        [Required(ErrorMessage = "Укажите путь к xsd-файлу")]
        [StringLength(250)]
        public string PathToXsd { get; set; }

        [Display(Name = "Наименование xsd-файла")]
        [Required(ErrorMessage = "Введите наименование xsd-файла")]
        [StringLength(100)]
        public string XsdName { get; set; }

        [Display(Name = "Описание")]
        [Required(ErrorMessage = "Введите описание")]
        [StringLength(250)]
        [DataType(DataType.MultilineText)]
        public string Descr { get; set; }

        [Display(Name = "Порядок")]
        [Required(ErrorMessage = "Укажите порядок")]
        [Range(1, 1000)]
        public int Ord { get; set; }
    }
}
