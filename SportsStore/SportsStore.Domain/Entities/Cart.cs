using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SportsStore.Domain.Entities
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
            CartLine line = lineCollection.Where(p => p.Product.ProductID == product.ProductID).FirstOrDefault();

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
        /// Удалить товар из корзины
        /// </summary>
        public void RemoveLine(Product product)
        {
            lineCollection.RemoveAll(l => l.Product.ProductID == product.ProductID);

            ////Удалить одну позицию
            //int cntQuantity = lineCollection.Where(p => p.Product.ProductID == product.ProductID).Sum(x => x.Quantity);
            //if (cntQuantity > 1)
            //{
            //    CartLine line = lineCollection.Where(p => p.Product.ProductID == product.ProductID).FirstOrDefault();
            //    line.Quantity -= 1;
            //}
            //else
            //{
            //    lineCollection.RemoveAll(l => l.Product.ProductID == product.ProductID);  // Если всё удалить, а не одну позицию
            //}
        }

        /// <summary>
        /// Общая сумма
        /// </summary>
        public decimal ComputeTotalValue()
        {
            return lineCollection.Sum(e => e.Product.Price * e.Quantity);
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

    /// <summary>
    /// Позиция товара в корзине
    /// </summary>
    public class CartLine
    {
        /// <summary>
        /// Товар
        /// </summary>
        public Product Product { get; set; }

        /// <summary>
        /// Количество
        /// </summary>
        public int Quantity { get; set; }
    }
}
