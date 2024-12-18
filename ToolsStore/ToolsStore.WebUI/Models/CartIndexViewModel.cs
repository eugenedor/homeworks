﻿using ToolsStore.Domain.Entities;

namespace ToolsStore.WebUI.Models
{
    /// <summary>
    /// Содержимое тележки
    /// </summary>
    public class CartIndexViewModel
    {
        /// <summary>
        /// Тележка
        /// </summary>
        public CART Cart { get; set; }

        /// <summary>
        /// Url
        /// </summary>
        public string ReturnUrl { get; set; }
    }
}