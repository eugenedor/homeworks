using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ToolsStore.Domain.Entities;

namespace ToolsStore.WebUI.Binders
{
    /// <summary>
    /// Специальный связыватель модели
    /// </summary>
    public class CartModelBinder : IModelBinder
    {
        private const string sessionKey = "Cart";
        public object BindModel(ControllerContext controllerContext, ModelBindingContext
        bindingContext)
        {
            // Получить объект CART из сессии
            CART cart = (CART)controllerContext.HttpContext.Session[sessionKey];

            // Создать экземпляр CART, если его не обнаружено в данных сеанса
            if (cart == null)
            {
                cart = new CART();
                controllerContext.HttpContext.Session[sessionKey] = cart;
            }
            // Вернуть объект CART
            return cart;
        }
    }
}