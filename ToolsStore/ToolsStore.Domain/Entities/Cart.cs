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
    public class CART
    {
        private List<CART_LINE> lineCollection = new List<CART_LINE>();

        /// <summary>
        /// Добавить товар в корзину
        /// </summary>
        public void AddItem(PRODUCT product, int quantity)
        {
            CART_LINE line = lineCollection.Where(p => p.Product.ProductId == product.ProductId).FirstOrDefault();

            if (line == null)
            {
                lineCollection.Add(new CART_LINE
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
        public void RemoveItem(PRODUCT product)
        {
            //Удалить одну позицию
            int cntQuantity = lineCollection.Where(p => p.Product.ProductId == product.ProductId).Sum(x => x.Quantity);
            if (cntQuantity > 1)
            {
                CART_LINE line = lineCollection.Where(p => p.Product.ProductId == product.ProductId).FirstOrDefault();
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
        public void RemoveLine(PRODUCT product)
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
        public IEnumerable<CART_LINE> Lines
        {
            get { return lineCollection; }
        }
    }
}
