using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;


namespace ToolsStore.Domain.Concrete
{
    public class EFProductRepository : IProductRepository
    {
        private EFDbContext context = new EFDbContext();

        public IQueryable<RS_PRODUCT> Products
        {
            get { return context.RS_PRODUCT; }
        }
    }
}
