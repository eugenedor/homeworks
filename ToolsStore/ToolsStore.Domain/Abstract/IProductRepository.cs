using System.Linq;
using ToolsStore.Domain.Entities;

namespace ToolsStore.Domain.Abstract
{
    public interface IProductRepository
    {
        IQueryable<RS_PRODUCT> Products { get; }

        IQueryable<SK_EQUIPMENT> Equipments { get; }

        IQueryable<CT_CATEGORY> Categories { get; }
    }
}
