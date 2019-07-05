using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;

namespace ToolsStore.Domain.Concrete
{
    public class EFOrderRepository : IOrderRepository
    {
        private EFDbContext context = new EFDbContext();

        public IQueryable<RS_ORDER> Orders
        {
            get { return context.RS_ORDER; }
        }

        public IQueryable<RS_ORDER_CONTENT> OrderContents
        {
            get { return context.RS_ORDER_CONTENT; }
        }

        public IEnumerable<ORDER_CONTENT> OrdContents
        {
            get
            {
                var orderContent = ( from orc in context.RS_ORDER_CONTENT

                                     join pr in context.RS_PRODUCT on orc.ProductId equals pr.ProductId

                                     join eq in context.SK_EQUIPMENT on pr.EquipmentId equals eq.EquipmentId

                                     join ct in context.CT_CATEGORY on eq.CategoryId equals ct.CategoryId

                                     join prc1 in context.RS_PRICE on orc.PriceId equals prc1.PriceId into prc2
                                     from prc in prc2.DefaultIfEmpty()

                                     orderby orc.OrderContentId, orc.OrderId
                                     select new ORDER_CONTENT
                                     {
                                         OrderContentId = orc.OrderContentId,
                                         OrderId = orc.OrderId,
                                         ProductId = orc.ProductId,
                                         ProductName = pr.Name,
                                         EquipmentName = eq.Name,
                                         CategoryName = (ct != null) ? ct.Name : string.Empty,
                                         PriceId = (prc != null) ? prc.PriceId : -1,
                                         Price = (prc != null) ? prc.PriceWithVat : 0,
                                         Quantity = orc.Quantity,
                                         Summ = ((prc != null) ? prc.PriceWithVat : 0) * orc.Quantity
                                     }).ToList();

                return orderContent;
            }
        }
    }
}
