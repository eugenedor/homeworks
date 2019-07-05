using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ToolsStore.Domain.Entities;

namespace ToolsStore.Domain.Abstract
{
    public interface IOrderRepository
    {
        IQueryable<RS_ORDER> Orders { get; }

        IQueryable<RS_ORDER_CONTENT> Carts { get; }

        IEnumerable<ORDER_CONTENT> OrderContents { get; }
    }
}
