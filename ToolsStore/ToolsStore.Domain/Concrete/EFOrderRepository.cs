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

        public IQueryable<RS_CART> Crts
        {
            get { return context.RS_CART; }
        }

        public IEnumerable<CartX> Carts
        {
            get
            {
                var carts = (from crt in context.RS_CART
                             join pr in context.RS_PRODUCT on crt.ProductId equals pr.ProductId
                             join eq in context.SK_EQUIPMENT on pr.EquipmentId equals eq.EquipmentId
                             join prc1 in context.RS_PRICE on pr.ProductId equals prc1.ProductId into prc2
                             from prc in prc2.DefaultIfEmpty()
                             orderby crt.CartId, crt.OrderId
                             select new CartX
                             {
                                 CartId = crt.CartId,
                                 OrderId = crt.OrderId,
                                 ProductId = crt.ProductId,
                                 ProductName = pr.Name,
                                 EquipmentName = eq.Name,
                                 PriceId = prc.PriceId,
                                 Price = (prc != null) ? prc.PriceWithVat : 0,
                                 Quantity = crt.Quantity,
                                 Summ = ((prc != null) ? prc.PriceWithVat : 0) * crt.Quantity
                             }).ToList();

                return carts;
            }
        }
    }
}
