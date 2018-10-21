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

        [Display(Name = "��� ���������")]
        [Required(ErrorMessage = "������� ��� ���������")]
        [StringLength(50)]
        public string Code { get; set; }

        [Display(Name = "��������")]
        [Required(ErrorMessage = "������� ��������")]
        [StringLength(250)]
        public string Value { get; set; }

        [Display(Name = "��������")]
        [Required(ErrorMessage = "������� ��������")]
        [StringLength(250)]
        [DataType(DataType.MultilineText)]
        public string Descr { get; set; }

        [Display(Name = "������� ����������")]
        [Required(ErrorMessage = "������� ������� ����������")]
        public bool IsActive { get; set; }
    }
}
