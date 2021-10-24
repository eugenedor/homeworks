using System;

namespace SportsStore.WebUI.Models
{
    /// <summary>
    /// Пейджинг
    /// </summary>
    public class PagingInfo
    {
        /// <summary>
        /// Количество товара
        /// </summary> 
        public int TotalItems { get; set; }

        /// <summary>
        /// Количество на странице
        /// </summary>
        public int ItemsPerPage { get; set; }

        /// <summary>
        /// Текущая страница
        /// </summary>
        public int CurrentPage { get; set; }

        /// <summary>
        /// Количество страниц
        /// </summary>
        public int TotalPages
        {
            get { return (int)Math.Ceiling((decimal)TotalItems / ItemsPerPage); }
        }
    }
}