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

        public byte[] Data { get; set; }

        [StringLength(50)]
        public string MimeType { get; set; }

        [StringLength(300)]
        public string Name { get; set; }

        [Display(Name = "Дата загрузки")]
        [DisplayFormat(DataFormatString = "{0:dd.MM.yyyy HH:mm:ss}")]
        public DateTime DateLoad { get; set; }

        public virtual MT_LOAD_RULE MT_LOAD_RULE { get; set; }
    }
}
