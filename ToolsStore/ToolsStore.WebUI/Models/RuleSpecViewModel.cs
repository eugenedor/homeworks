using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ToolsStore.Domain.Entities;

namespace ToolsStore.WebUI.Models
{
    public class RuleSpecViewModel
    {
        public MT_LOAD_RULE_SPEC LoadRuleSpec { get; set; }

        public IEnumerable<MT_LOAD_RULE> LoadRules { get; set; }
    }
}