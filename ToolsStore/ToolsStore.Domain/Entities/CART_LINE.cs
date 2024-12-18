﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToolsStore.Domain.Entities
{
    /// <summary>
    /// Позиция товара в корзине
    /// </summary>
    public class CART_LINE
    {
        /// <summary>
        /// Товар
        /// </summary>
        public PRODUCT Product { get; set; }

        /// <summary>
        /// Количество
        /// </summary>
        public int Quantity { get; set; }
    }
}
