using System;
using System.Collections.Generic;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace ToolsStore.Domain.Entities
{
    public partial class MT_LOAD_RULE_SPEC
    {
        [Key]
        public long LoadRuleSpecId { get; set; }

        public long LoadRuleId { get; set; }

        [Required]
        public byte[] Data { get; set; }

        [Required]
        [StringLength(50)]
        public string MimeType { get; set; }

        [Display(Name = "Наименование xsd-файла")]
        [Required(ErrorMessage = "Введите наименование xsd-файла")]
        [StringLength(100)]
        public string FileName { get; set; }

        [Display(Name = "Путь к xsd-файлу")]
        [Required(ErrorMessage = "Укажите путь к xsd-файлу")]
        [StringLength(250)]
        public string PathToFile { get; set; }

        public int? Size { get; set; }

        public bool IsActive { get; set; }

        [Display(Name = "Дата загрузки")]
        [DisplayFormat(DataFormatString = "{0:dd.MM.yyyy HH:mm:ss}")]
        public DateTime DateLoad { get; set; }

        public virtual MT_LOAD_RULE MT_LOAD_RULE { get; set; }
    }
}
