using System.Linq;
using ToolsStore.Domain.Entities;
using System.Collections.Generic;

namespace ToolsStore.Domain.Abstract
{
    public interface IProductRepository
    {
        IQueryable<RS_PRODUCT> Prdcts { get; }

        IQueryable<SK_EQUIPMENT> Equipments { get; }

        IQueryable<CT_CATEGORY> Categories { get; }

        IQueryable<CT_BRAND> Brands { get; }

        IQueryable<SK_MODEL> Models { get; }

        IQueryable<CT_IMAGE> Images { get; }

        IQueryable<RS_PRICE> Prices { get; }

        IQueryable<CT_VAT> Vats { get; }       

        IEnumerable<Product> Products { get; }
    }
}
