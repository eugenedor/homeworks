using System;
using System.Collections.Generic;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.Spatial;

namespace ToolsStore.Domain.Entities
{
    public partial class MT_SETTING
    {
        [Key]
        [HiddenInput(DisplayValue = false)]
        public long SettingId { get; set; }

        [Display(Name = "Код настройки")]
        [Required(ErrorMessage = "Введите код настройки")]
        [StringLength(50)]
        public string Code { get; set; }

        [Display(Name = "Значение")]
        [Required(ErrorMessage = "Введите значение")]
        [StringLength(250)]
        public string Value { get; set; }

        [Display(Name = "Описание")]
        [Required(ErrorMessage = "Введите описание")]
        [StringLength(250)]
        [DataType(DataType.MultilineText)]
        public string Descr { get; set; }

        [Display(Name = "Признак активности")]
        [Required(ErrorMessage = "Укажите признак активности")]
        public bool IsActive { get; set; }
    }
}
