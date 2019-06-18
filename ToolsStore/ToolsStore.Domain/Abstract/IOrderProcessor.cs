using ToolsStore.Domain.Entities;

namespace ToolsStore.Domain.Abstract
{
    public interface IOrderProcessor
    {
        void ProcessOrder(Cart cart, SHIPPING_DETAILS shippingDetails);

        void SaveOrder(Cart cart, SHIPPING_DETAILS shippingInfo);
    }
}
