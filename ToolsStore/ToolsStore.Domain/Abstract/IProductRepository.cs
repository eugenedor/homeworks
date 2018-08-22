using System.Linq;
using ToolsStore.Domain.Entities;

namespace ToolsStore.Domain.Abstract
{
    public interface IProductRepository
    {
        IQueryable<RS_PRODUCT> Products { get; }
    }
}
