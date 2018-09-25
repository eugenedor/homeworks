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
    }
}
