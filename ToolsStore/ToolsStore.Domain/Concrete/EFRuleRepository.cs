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
                    dbEntry.Pattern = loadRule.Pattern;
                    dbEntry.Method = loadRule.Method;
                    dbEntry.Descr = loadRule.Descr;
                    dbEntry.IsActive = loadRule.IsActive;                                       
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

        public void SaveLoadRuleSpec(MT_LOAD_RULE_SPEC loadRuleSpec, out string err)
        {
            err = string.Empty;
            try
            {
                loadRuleSpec.DateLoad = DateTime.Now;
                if (loadRuleSpec.LoadRuleSpecId == 0)
                {
                    context.MT_LOAD_RULE_SPEC.Add(loadRuleSpec);
                }
                else
                {
                    MT_LOAD_RULE_SPEC dbEntry = context.MT_LOAD_RULE_SPEC.Where(x => x.LoadRuleSpecId == loadRuleSpec.LoadRuleSpecId).Single();
                    if (dbEntry != null)
                    {
                        if (loadRuleSpec.Data != null
                            && loadRuleSpec.MimeType != null
                            && loadRuleSpec.FileName != null)
                        {
                            dbEntry.Data = loadRuleSpec.Data;
                            dbEntry.MimeType = loadRuleSpec.MimeType;
                            dbEntry.FileName = loadRuleSpec.FileName;
                            dbEntry.Size = loadRuleSpec.Size;
                        }
                        dbEntry.LoadRuleId = loadRuleSpec.LoadRuleId;
                        dbEntry.PathToFile = loadRuleSpec.PathToFile;
                        dbEntry.IsMain = loadRuleSpec.IsMain;
                        dbEntry.DateLoad = loadRuleSpec.DateLoad;
                    }
                }
                context.SaveChanges();
            }
            catch (Exception ex)
            {
                if (ex.InnerException != null && ex.InnerException.InnerException != null)
                    err = ex.InnerException.InnerException.Message;
                else if (ex.InnerException != null)
                    err = ex.InnerException.Message;
                else
                    err = ex.Message;
            }
        }

        public MT_LOAD_RULE_SPEC DeleteLoadRuleSpec(long loadRuleSpecId)
        {
            MT_LOAD_RULE_SPEC dbEntry = context.MT_LOAD_RULE_SPEC.Where(x => x.LoadRuleSpecId == loadRuleSpecId).Single();
            if (dbEntry != null)
            {
                context.MT_LOAD_RULE_SPEC.Remove(dbEntry);
                context.SaveChanges();
            }
            return dbEntry;
        }
    }
}
