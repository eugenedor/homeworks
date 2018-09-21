using ToolsStore.Domain.Entities;

namespace ToolsStore.Domain.Abstract
{
    public interface IOrderProcessor
    {
        void ProcessOrder(Cart cart, ShippingDetails shippingDetails);

        void SaveOrder(Cart cart, ShippingDetails shippingInfo);
    }
}
