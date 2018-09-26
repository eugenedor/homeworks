using System;
using System.Collections.Generic;
using System.Linq;
using ToolsStore.Domain.Entities;

namespace ToolsStore.Domain.Abstract
{
    public interface IRuleRepository
    {
        IQueryable<MT_LOAD_RULE> LoadRules { get; }

        void SaveLoadRule(MT_LOAD_RULE loadRule);

        MT_LOAD_RULE DeleteLoadRule(long LoadRuleId);
    }
}
