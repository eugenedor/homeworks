using System;
using System.Collections.Generic;
using System.Linq;
using ToolsStore.Domain.Entities;

namespace ToolsStore.Domain.Abstract
{
    public interface IRuleRepository
    {
        IQueryable<MT_LOAD_RULE> LoadRules { get; }

        IQueryable<MT_LOAD_RULE_SPEC> LoadRulesSpec { get; }

        void SaveLoadRule(MT_LOAD_RULE loadRule);

        MT_LOAD_RULE DeleteLoadRule(long loadRuleId);

        void SaveLoadRuleSpec(MT_LOAD_RULE_SPEC loadRuleSpec);
    }
}
