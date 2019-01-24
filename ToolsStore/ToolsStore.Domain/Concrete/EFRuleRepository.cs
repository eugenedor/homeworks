using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;

namespace ToolsStore.Domain.Concrete
{
    public class EFRuleRepository : IRuleRepository
    {
        private EFDbContext context = new EFDbContext();

        public IQueryable<MT_LOAD_RULE> LoadRules
        {
            get { return context.MT_LOAD_RULE; }
        }

        public IQueryable<MT_LOAD_RULE_SPEC> LoadRulesSpec
        {
            get { return context.MT_LOAD_RULE_SPEC; }
        }

        public void SaveLoadRule(MT_LOAD_RULE loadRule)
        {
            if (loadRule.LoadRuleId == 0)
            {
                context.MT_LOAD_RULE.Add(loadRule);
            }
            else
            {
                MT_LOAD_RULE dbEntry = context.MT_LOAD_RULE.Where(x => x.LoadRuleId == loadRule.LoadRuleId).Single(); //.Find(loadRule.LoadRuleId);
                if (dbEntry != null)
                {
                    dbEntry.Code = loadRule.Code;
                    dbEntry.FileName = loadRule.FileName;
                    dbEntry.IsActive = loadRule.IsActive;
                    dbEntry.MethodLoad = loadRule.MethodLoad;
                    dbEntry.PathToXsd = loadRule.PathToXsd;
                    dbEntry.XsdName = loadRule.XsdName;
                    dbEntry.Descr = loadRule.Descr;
                    dbEntry.Ord = loadRule.Ord;
                }
            }
            context.SaveChanges();
        }

        public MT_LOAD_RULE DeleteLoadRule(long loadRuleId)
        {
            MT_LOAD_RULE dbEntry = context.MT_LOAD_RULE.Where(x => x.LoadRuleId == loadRuleId).Single(); //.Find(loadRuleId);
            if (dbEntry != null)
            {
                context.MT_LOAD_RULE.Remove(dbEntry);
                context.SaveChanges();
            }
            return dbEntry;
        }
    }
}
