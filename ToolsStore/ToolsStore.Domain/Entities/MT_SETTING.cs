namespace ToolsStore.Domain.Entities
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class MT_SETTING
    {
        [Key]
        public long SettingId { get; set; }

        [Required]
        [StringLength(50)]
        public string Code { get; set; }

        [Required]
        [StringLength(250)]
        public string Value { get; set; }

        [Required]
        [StringLength(250)]
        public string Descr { get; set; }

        public bool IsActive { get; set; }
    }
}
