using System.Collections.Generic;
using SportsStore.Domain.Entities;

namespace SportsStore.WebUI.Models
{
    /// <summary>
    /// Список товаров
    /// </summary>
    public class ProductsListViewModel
    {
        /// <summary>
        /// Товары
        /// </summary>
        public IEnumerable<Product> Products { get; set; }

        /// <summary>
        /// Пейджинг (нумерация страниц)
        /// </summary>
        public PagingInfo PagingInfo { get; set; }

        /// <summary>
        /// Текущая категория
        /// </summary>
        public string CurrentCategory { get; set; }
    }
}