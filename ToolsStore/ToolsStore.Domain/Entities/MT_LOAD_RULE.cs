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

        [Required(ErrorMessage = "������� ��� ������� ��������")]
        [StringLength(50)]
        public string Code { get; set; }

        [Required(ErrorMessage = "������� ������������ �����")]
        [StringLength(100)]
        public string FileName { get; set; }

        [Required(ErrorMessage = "������� ������� ����������")]
        public bool IsActive { get; set; }

        [Required(ErrorMessage = "������� ����� ��������")]
        [StringLength(100)]
        public string MethodLoad { get; set; }

        [Required(ErrorMessage = "������� ���� � xsd-�����")]
        [StringLength(250)]
        public string PathToXsd { get; set; }

        [Required(ErrorMessage = "������� ������������ xsd-�����")]
        [StringLength(100)]
        public string XsdName { get; set; }

        [Required(ErrorMessage = "������� ��������")]
        [StringLength(250)]
        [DataType(DataType.MultilineText)]
        public string Descr { get; set; }

        [Required(ErrorMessage = "������� �������")]
        public int Ord { get; set; }
    }
}
