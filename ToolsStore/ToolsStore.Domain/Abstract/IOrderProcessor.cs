using ToolsStore.Domain.Entities;

namespace ToolsStore.Domain.Abstract
{
    public interface IOrderProcessor
    {
        void ProcessOrder(CART cart, SHIPPING_DETAILS shippingDetails);

        void SaveOrder(CART cart, SHIPPING_DETAILS shippingInfo);
    }
}
