using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToolsStore.Domain.Entities
{
    /// <summary>
    /// Тележка (корзина)
    /// </summary>
    public class Cart
    {
        private List<CartLine> lineCollection = new List<CartLine>();

        /// <summary>
        /// Добавить товар в корзину
        /// </summary>
        public void AddItem(Product product, int quantity)
        {
            CartLine line = lineCollection.Where(p => p.Product.ProductId == product.ProductId).FirstOrDefault();

            if (line == null)
            {
                lineCollection.Add(new CartLine
                {
                    Product = product,
                    Quantity = quantity
                });
            }
            else
            {
                line.Quantity += quantity;
            }
        }

        /// <summary>
        /// Удалить 1 элемент товара из корзины
        /// </summary>
        public void RemoveItem(Product product)
        {
            //Удалить одну позицию
            int cntQuantity = lineCollection.Where(p => p.Product.ProductId == product.ProductId).Sum(x => x.Quantity);
            if (cntQuantity > 1)
            {
                CartLine line = lineCollection.Where(p => p.Product.ProductId == product.ProductId).FirstOrDefault();
                line.Quantity -= 1;
            }
            else
            {
                lineCollection.RemoveAll(l => l.Product.ProductId == product.ProductId);  // Если всё удалить, а не одну позицию
            }
        }

        /// <summary>
        /// Удалить товар из корзины
        /// </summary>
        public void RemoveLine(Product product)
        {
            lineCollection.RemoveAll(l => l.Product.ProductId == product.ProductId);
        }

        /// <summary>
        /// Общая сумма
        /// </summary>
        public decimal ComputeTotalValue()
        {
            return lineCollection.Sum(e => (decimal)(e.Product.PriceWithVat ?? 0) * e.Quantity);
        }

        /// <summary>
        /// Очистить корзину
        /// </summary>
        public void Clear()
        {
            lineCollection.Clear();
        }

        /// <summary>
        /// Список товаров
        /// </summary>
        public IEnumerable<CartLine> Lines
        {
            get { return lineCollection; }
        }
    }
}
