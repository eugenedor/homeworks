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

        [Required]
        [StringLength(50)]
        public string Code { get; set; }

        [Required]
        [StringLength(100)]
        public string FileName { get; set; }

        public bool IsActive { get; set; }

        [Required]
        [StringLength(100)]
        public string MethodLoad { get; set; }

        [Required]
        [StringLength(250)]
        public string PathToXsd { get; set; }

        [Required]
        [StringLength(100)]
        public string XsdName { get; set; }

        [Required]
        [StringLength(250)]
        [DataType(DataType.MultilineText)]
        public string Descr { get; set; }

        public int Ord { get; set; }
    }
}
